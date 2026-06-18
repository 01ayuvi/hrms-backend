from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database.dependencies import get_db

from app.departments.models import Department
from app.departments.schemas import (
    DepartmentCreate,
    DepartmentUpdate
)

router = APIRouter()

@router.post("/")
def create_department(
    request: DepartmentCreate,
    db: Session = Depends(get_db)
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