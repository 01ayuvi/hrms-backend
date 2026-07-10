from app.payroll.salary_structure_model import SalaryStructure
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from fastapi.responses import FileResponse

from app.payroll.salary_structure_model import SalaryStructure

from app.payroll.salary_structure_schema import (
    SalaryStructureCreate,
    SalaryStructureUpdate,
    SalaryStructureResponse
)

from app.employees.models import Employee

from app.payroll.payslip_generator import generate_payslip
from app.leave.models import LeaveRequest
from app.database.dependencies import get_db
from app.payroll.models import PayrollRun, PayrollDetail
from app.payroll.schemas import (
    PayrollRunCreate,
    PayrollRunResponse,
    PayrollDetailCreate,
    PayrollDetailResponse
)

router = APIRouter(
    tags=["Payroll"]
)


@router.post("/run", response_model=PayrollRunResponse)
def create_payroll_run(
    payroll_data: PayrollRunCreate,
    db: Session = Depends(get_db)
):
    payroll_run = PayrollRun(
        pay_period=payroll_data.pay_period,
        remarks=payroll_data.remarks,
        status="COMPLETED"
    )

    db.add(payroll_run)
    db.commit()
    db.refresh(payroll_run)

    return payroll_run


@router.post("/detail", response_model=PayrollDetailResponse)
def create_payroll_detail(
    payroll_data: PayrollDetailCreate,
    db: Session = Depends(get_db)
):

    salary_structure = db.query(SalaryStructure).filter(
        SalaryStructure.employee_id == payroll_data.employee_id
    ).first()

    if not salary_structure:
        raise HTTPException(
            status_code=404,
            detail="Salary structure not found"
        )

    basic_salary = float(salary_structure.basic_salary)

    hra = (
        basic_salary *
        float(salary_structure.hra_percentage)
    ) / 100

    gross_salary = basic_salary + hra

    pf_deduction = (
        basic_salary *
        float(salary_structure.pf_percentage)
    ) / 100

    esic_deduction = (
        basic_salary *
        float(salary_structure.esic_percentage)
    ) / 100

    professional_tax = float(
        salary_structure.professional_tax
    )

    tds = float(
        salary_structure.tds
    )

    lwp_days = 0

    approved_leaves = db.query(LeaveRequest).filter(
        LeaveRequest.employee_id == payroll_data.employee_id,
        LeaveRequest.status == "APPROVED"
    ).all()

    for leave in approved_leaves:
        lwp_days += leave.lwp_days

    per_day_salary = basic_salary / 30

    lwp_deduction = (
        per_day_salary * lwp_days
    )

    total_deductions = (
        pf_deduction +
        esic_deduction +
        professional_tax +
        tds +
        lwp_deduction
    )

    net_salary = (
        gross_salary -
        total_deductions
    )

    payroll_detail = PayrollDetail(
        payroll_run_id=payroll_data.payroll_run_id,
        employee_id=payroll_data.employee_id,

        basic_salary=basic_salary,

        hra=hra,
        gross_salary=gross_salary,

        allowances=0,
        deductions=total_deductions,

        pf_deduction=pf_deduction,
        esic_deduction=esic_deduction,
        professional_tax=professional_tax,
        tds=tds,

        lwp_deduction=lwp_deduction,

        net_salary=net_salary
    )

    db.add(payroll_detail)
    db.commit()
    db.refresh(payroll_detail)

    return payroll_detail


@router.get("/runs", response_model=list[PayrollRunResponse])
def get_payroll_runs(
    db: Session = Depends(get_db)
):
    return db.query(PayrollRun).all()


@router.get("/details", response_model=list[PayrollDetailResponse])
def get_payroll_details(
    db: Session = Depends(get_db)
):
    return db.query(PayrollDetail).all()

@router.get("/payslip/{payroll_detail_id}")
def download_payslip(
    payroll_detail_id: int,
    db: Session = Depends(get_db)
):

    payroll = db.query(PayrollDetail).filter(
        PayrollDetail.payroll_detail_id == payroll_detail_id
    ).first()

    if not payroll:
        raise HTTPException(
            status_code=404,
            detail="Payroll detail not found"
        )

    filename = f"payslip_{payroll_detail_id}.pdf"

    generate_payslip(
        filename,
        payroll
    )

    return FileResponse(
        path=filename,
        media_type="application/pdf",
        filename=filename
    )



@router.post(
    "/salary-structure",
    response_model=SalaryStructureResponse
)
def create_salary_structure(
    request: SalaryStructureCreate,
    db: Session = Depends(get_db)
):

    employee = db.query(Employee).filter(
        Employee.employee_id == request.employee_id
    ).first()

    if not employee:
        raise HTTPException(
            status_code=404,
            detail="Employee not found"
        )

    existing = db.query(SalaryStructure).filter(
        SalaryStructure.employee_id == request.employee_id
    ).first()

    if existing:
        raise HTTPException(
            status_code=400,
            detail="Salary structure already exists"
        )

    salary = SalaryStructure(
        employee_id=request.employee_id,
        basic_salary=request.basic_salary,
        hra_percentage=request.hra_percentage,
        pf_percentage=request.pf_percentage,
        esic_percentage=request.esic_percentage,
        professional_tax=request.professional_tax,
        tds=request.tds
    )

    db.add(salary)
    db.commit()
    db.refresh(salary)

    return salary


@router.get(
    "/salary-structure",
    response_model=list[SalaryStructureResponse]
)
def get_salary_structures(
    db: Session = Depends(get_db)
):

    salary_structures = db.query(
        SalaryStructure
    ).all()

    result = []

    for salary in salary_structures:

        employee = db.query(Employee).filter(
            Employee.employee_id == salary.employee_id
        ).first()

        result.append({

            "salary_structure_id":
                salary.salary_structure_id,

            "employee_id":
                salary.employee_id,

            "employee_name":
                f"{employee.first_name} {employee.last_name}"
                if employee else None,

            "basic_salary":
                salary.basic_salary,

            "hra_percentage":
                salary.hra_percentage,

            "pf_percentage":
                salary.pf_percentage,

            "esic_percentage":
                salary.esic_percentage,

            "professional_tax":
                salary.professional_tax,

            "tds":
                salary.tds,

            "created_at":
                salary.created_at,

            "updated_at":
                salary.updated_at

        })

    return result

@router.put(
    "/salary-structure/{employee_id}",
    response_model=SalaryStructureResponse
)
def update_salary_structure(
    employee_id: int,
    request: SalaryStructureUpdate,
    db: Session = Depends(get_db)
):

    salary_structure = db.query(
        SalaryStructure
    ).filter(
        SalaryStructure.employee_id == employee_id
    ).first()

    if not salary_structure:
        raise HTTPException(
            status_code=404,
            detail="Salary structure not found"
        )

    salary_structure.basic_salary = request.basic_salary
    salary_structure.hra_percentage = request.hra_percentage
    salary_structure.pf_percentage = request.pf_percentage
    salary_structure.esic_percentage = request.esic_percentage
    salary_structure.professional_tax = request.professional_tax
    salary_structure.tds = request.tds

    db.commit()
    db.refresh(salary_structure)

    return salary_structure

@router.delete("/salary-structure/{employee_id}")
def delete_salary_structure(
    employee_id: int,
    db: Session = Depends(get_db)
):

    salary_structure = db.query(
        SalaryStructure
    ).filter(
        SalaryStructure.employee_id == employee_id
    ).first()

    if not salary_structure:
        raise HTTPException(
            status_code=404,
            detail="Salary structure not found"
        )

    db.delete(salary_structure)
    db.commit()

    return {
        "message": "Salary structure deleted successfully"
    }    