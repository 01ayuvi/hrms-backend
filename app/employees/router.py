from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
import os
import shutil

from app.database.dependencies import get_db
from app.auth.permissions import require_permission
from sqlalchemy import asc, desc

from app.employees.models import Employee
from app.employees.schemas import (
    EmployeeCreate,
    EmployeeUpdate
)

from app.audit.utils import create_audit_log

router = APIRouter()

from app.employees.search_schemas import (
    EmployeeSearchRequest,
    EmployeeSearchResponse
)
from fastapi.responses import FileResponse
from openpyxl import Workbook

from app.employees.export_schemas import (
    EmployeeExportRequest
)
from fastapi import BackgroundTasks
from app.export_jobs.models import ExportJob
from datetime import datetime
from fastapi import UploadFile
from fastapi import File
from fastapi import Form
from app.models.employee_document import EmployeeDocument

def generate_employee_excel(
    employees,
    file_name
):

    workbook = Workbook()

    sheet = workbook.active

    sheet.title = "Employees"

    sheet.append([
        "Employee ID",
        "First Name",
        "Last Name",
        "Email",
        "Department ID",
        "Designation",
        "Status",
        "Joining Date",
        "Created At",
        "Updated At"
    ])

    for employee in employees:

        sheet.append([
            employee.employee_id,
            employee.first_name,
            employee.last_name,
            employee.email,
            employee.department_id,
            employee.designation,
            employee.status,
            str(employee.joining_date),
            str(employee.created_at),
            str(employee.updated_at)
        ])

    workbook.save(file_name)

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
    skip: int = 0,
    limit: int = 10,
    db: Session = Depends(get_db)
):

    employees = (
        db.query(Employee)
        .offset(skip)
        .limit(limit)
        .all()
    )

    return employees
@router.post("/search")
def search_employees(
    request: EmployeeSearchRequest,
    db: Session = Depends(get_db)
):

    query = db.query(Employee)

    if request.employee_name:
        query = query.filter(
            Employee.first_name.ilike(
                f"%{request.employee_name}%"
            )
        )

    if request.department_id:
        query = query.filter(
            Employee.department_id ==
            request.department_id
        )

    if request.status:
        query = query.filter(
            Employee.status ==
            request.status
        )
    if request.designation:
        query = query.filter(
        Employee.designation.ilike(
            f"%{request.designation}%"
        )
    )

    if request.joining_date_from:
        query = query.filter(
        Employee.joining_date >=
        request.joining_date_from
    )

    if request.joining_date_to:
        query = query.filter(
        Employee.joining_date <=
        request.joining_date_to
    )
    sort_column = getattr(
    Employee,
    request.sort_by,
    Employee.employee_id
)

    if request.sort_order.lower() == "asc":
        query = query.order_by(
        asc(sort_column)
    )
    else:
        query = query.order_by(
        desc(sort_column)
    )
    total_count = query.count()

    offset = (
        request.page - 1
    ) * request.page_size

    employees = (
        query
        .offset(offset)
        .limit(request.page_size)
        .all()
    )

    return {
        "count": total_count,
        "page": request.page,
        "page_size": request.page_size,
        "records": employees
    }

    return {
        "message": "search endpoint working"
    }
@router.post("/export")
def export_employees(
    request: EmployeeExportRequest,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db)
):

    query = db.query(Employee)

    if request.employee_name:
        query = query.filter(
            Employee.first_name.ilike(
                f"%{request.employee_name}%"
            )
        )

    if request.department_id:
        query = query.filter(
            Employee.department_id ==
            request.department_id
        )

    if request.status:
        query = query.filter(
            Employee.status ==
            request.status
        )

    if request.designation:
        query = query.filter(
            Employee.designation.ilike(
                f"%{request.designation}%"
            )
        )

    if request.joining_date_from:
        query = query.filter(
            Employee.joining_date >=
            request.joining_date_from
        )

    if request.joining_date_to:
        query = query.filter(
            Employee.joining_date <=
            request.joining_date_to
        )

    employees = query.all()

    
    job = ExportJob(
    report_type="EMPLOYEE",
    status="PENDING"
    )

    db.add(job)
    db.commit()
    db.refresh(job)
    file_name = (
    f"exports/employees_export_{job.id}.xlsx"
    )
    background_tasks.add_task(
        generate_employee_excel,
        employees,
        file_name
    )
    job.file_name = file_name

    job.status = "COMPLETED"

    job.completed_at = datetime.utcnow()

    db.commit()

    return {
    "job_id": job.id,
    "status": job.status,
    "file_name": file_name
    }


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
    employee.manager_id = request.manager_id

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

@router.get("/{employee_id}/manager")
def get_employee_manager(
    employee_id: int,
    db: Session = Depends(get_db)
):

    employee = db.query(Employee).filter(
        Employee.employee_id == employee_id
    ).first()

    if not employee:
        raise HTTPException(
            status_code=404,
            detail="Employee not found"
        )

    if not employee.manager_id:
        return {
            "message": "No manager assigned"
        }

    manager = db.query(Employee).filter(
        Employee.employee_id ==
        employee.manager_id
    ).first()

    return {
    "employee_id": manager.employee_id,
    "first_name": manager.first_name,
    "last_name": manager.last_name,
    "email": manager.email,
    "designation": manager.designation,
    "status": manager.status
}