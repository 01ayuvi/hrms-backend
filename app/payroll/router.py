from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.leave.models import LeaveRequest
from app.database.database import get_db
from app.payroll.models import PayrollRun, PayrollDetail
from app.payroll.schemas import (
    PayrollRunCreate,
    PayrollRunResponse,
    PayrollDetailCreate,
    PayrollDetailResponse
)

router = APIRouter(
    prefix="/payroll",
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
    lwp_days = 0

    approved_leaves = db.query(LeaveRequest).filter(
        LeaveRequest.employee_id == payroll_data.employee_id,
        LeaveRequest.status == "APPROVED"
    ).all()

    for leave in approved_leaves:
        lwp_days += leave.lwp_days

    per_day_salary = payroll_data.basic_salary / 30

    lwp_deduction = per_day_salary * lwp_days

    total_deductions = (
        payroll_data.deductions +
        lwp_deduction
    )

    net_salary = (
        payroll_data.basic_salary +
        payroll_data.allowances -
        total_deductions
    )

    payroll_detail = PayrollDetail(
        payroll_run_id=payroll_data.payroll_run_id,
        employee_id=payroll_data.employee_id,
        basic_salary=payroll_data.basic_salary,
        allowances=payroll_data.allowances,
        deductions=payroll_data.deductions,
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