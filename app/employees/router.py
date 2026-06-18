from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database.dependencies import get_db
from app.auth.dependencies import get_current_user

from app.employees.models import Employee
from app.employees.schemas import (
    EmployeeCreate,
    EmployeeResponse
)

router = APIRouter()


@router.post("/")
def create_employee(
    request: EmployeeCreate,
    db: Session = Depends(get_db)
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

    return employee


@router.get("/")
def get_employees(
    db: Session = Depends(get_db)
):

    employees = db.query(Employee).all()

    return employees