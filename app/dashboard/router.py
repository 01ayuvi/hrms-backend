# app/dashboard/router.py

from fastapi import APIRouter
from sqlalchemy.orm import Session
from fastapi import Depends

from app.database.dependencies import get_db
from app.employees.models import Employee
from app.departments.models import Department
from app.models.employee_document import EmployeeDocument

router = APIRouter()

@router.get("/summary")
def dashboard_summary(
    db: Session = Depends(get_db)
):

    total_employees = db.query(Employee).count()

    active_employees = (
        db.query(Employee)
        .filter(Employee.status == "ACTIVE")
        .count()
    )

    inactive_employees = (
        db.query(Employee)
        .filter(Employee.status == "INACTIVE")
        .count()
    )

    total_departments = (
        db.query(Department)
        .count()
    )

    total_documents = (
        db.query(EmployeeDocument)
        .count()
    )

    return {
        "total_employees": total_employees,
        "active_employees": active_employees,
        "inactive_employees": inactive_employees,
        "total_departments": total_departments,
        "total_documents": total_documents
    }
