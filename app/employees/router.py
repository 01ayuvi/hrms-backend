from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database.dependencies import get_db
from app.auth.permissions import require_permission

from app.employees.models import Employee
from app.employees.schemas import (
    EmployeeCreate,
    EmployeeUpdate
)

from app.audit.utils import create_audit_log

router = APIRouter()


@router.post("/")
def create_employee(
    request: EmployeeCreate,
    db: Session = Depends(get_db),
    current_user=Depends(
        require_permission("create_employee")
    )
):

    existing_employee = db.query(Employee).filter(
        Employee.email == request.email
    ).first()

    if existing_employee:
        raise HTTPException(
            status_code=400,
            detail="Employee email already exists"
        )

    employee = Employee(
        organization_id=request.organization_id,
        department_id=request.department_id,
        first_name=request.first_name,
        last_name=request.last_name,
        email=request.email,
        phone=request.phone,
        designation=request.designation,
        joining_date=request.joining_date
    )

    db.add(employee)
    db.commit()
    db.refresh(employee)

    create_audit_log(
        db=db,
        user_id=current_user.id,
        action="CREATE",
        entity_type="Employee",
        entity_id=employee.employee_id
    )

    return employee


@router.get("/")
def get_employees(
    db: Session = Depends(get_db)
):

    employees = db.query(Employee).all()

    return employees


@router.put("/{employee_id}")
def update_employee(
    employee_id: int,
    request: EmployeeUpdate,
    db: Session = Depends(get_db),
    current_user=Depends(
        require_permission("update_employee")
    )
):

    employee = db.query(Employee).filter(
        Employee.employee_id == employee_id
    ).first()

    if not employee:
        raise HTTPException(
            status_code=404,
            detail="Employee not found"
        )

    employee.first_name = request.first_name
    employee.last_name = request.last_name
    employee.email = request.email
    employee.phone = request.phone
    employee.designation = request.designation
    employee.status = request.status

    db.commit()
    db.refresh(employee)

    create_audit_log(
        db=db,
        user_id=current_user.id,
        action="UPDATE",
        entity_type="Employee",
        entity_id=employee.employee_id
    )

    return employee


@router.patch("/{employee_id}/deactivate")
def deactivate_employee(
    employee_id: int,
    db: Session = Depends(get_db),
    current_user=Depends(
        require_permission("update_employee")
    )
):

    employee = db.query(Employee).filter(
        Employee.employee_id == employee_id
    ).first()

    if not employee:
        raise HTTPException(
            status_code=404,
            detail="Employee not found"
        )

    employee.status = "INACTIVE"

    db.commit()
    db.refresh(employee)

    create_audit_log(
        db=db,
        user_id=current_user.id,
        action="DEACTIVATE",
        entity_type="Employee",
        entity_id=employee.employee_id
    )

    return employee