from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database.dependencies import get_db
from app.auth.permissions import require_permission

from app.departments.models import Department
from app.departments.schemas import (
    DepartmentCreate,
    DepartmentUpdate
)

router = APIRouter()


@router.post("/")
def create_department(
    request: DepartmentCreate,
    db: Session = Depends(get_db),
    current_user=Depends(
        require_permission("create_department")
    )
):

    department = Department(
        organization_id=request.organization_id,
        department_name=request.department_name,
        department_code=request.department_code
    )

    db.add(department)
    db.commit()
    db.refresh(department)

    return department


@router.get("/")
def get_departments(
    db: Session = Depends(get_db)
):

    departments = db.query(
        Department
    ).all()

    return departments


@router.put("/{department_id}")
def update_department(
    department_id: int,
    request: DepartmentUpdate,
    db: Session = Depends(get_db),
    current_user=Depends(
        require_permission("update_department")
    )
):

    department = db.query(
        Department
    ).filter(
        Department.id == department_id
    ).first()

    if not department:
        raise HTTPException(
            status_code=404,
            detail="Department not found"
        )

    department.department_name = (
        request.department_name
    )

    department.department_code = (
        request.department_code
    )

    db.commit()
    db.refresh(department)

    return department