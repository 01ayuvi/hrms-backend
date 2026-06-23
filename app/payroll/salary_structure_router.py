from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.database import get_db

from app.payroll.salary_structure_model import SalaryStructure
from app.payroll.salary_structure_schema import (
    SalaryStructureCreate,
    SalaryStructureResponse
)

router = APIRouter(
    prefix="/salary-structure",
    tags=["Salary Structure"]
)


@router.post("/", response_model=SalaryStructureResponse)
def create_salary_structure(
    salary_data: SalaryStructureCreate,
    db: Session = Depends(get_db)
):
    salary_structure = SalaryStructure(
        employee_id=salary_data.employee_id,
        basic_salary=salary_data.basic_salary,
        hra_percentage=salary_data.hra_percentage,
        pf_percentage=salary_data.pf_percentage,
        esic_percentage=salary_data.esic_percentage,
        professional_tax=salary_data.professional_tax,
        tds=salary_data.tds
    )

    db.add(salary_structure)
    db.commit()
    db.refresh(salary_structure)

    return salary_structure


@router.get("/", response_model=list[SalaryStructureResponse])
def get_salary_structures(
    db: Session = Depends(get_db)
):
    return db.query(SalaryStructure).all()