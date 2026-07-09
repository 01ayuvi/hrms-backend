from pydantic import BaseModel
from decimal import Decimal
from datetime import datetime


class SalaryStructureCreate(BaseModel):
    employee_id: int
    basic_salary: Decimal
    hra_percentage: Decimal = 40
    pf_percentage: Decimal = 12
    esic_percentage: Decimal = 0.75
    professional_tax: Decimal = 200
    tds: Decimal = 0

class SalaryStructureUpdate(BaseModel):
    basic_salary: Decimal
    hra_percentage: Decimal
    pf_percentage: Decimal
    esic_percentage: Decimal
    professional_tax: Decimal
    tds: Decimal

class SalaryStructureResponse(BaseModel):
    salary_structure_id: int
    employee_id: int

    basic_salary: Decimal
    hra_percentage: Decimal
    pf_percentage: Decimal
    esic_percentage: Decimal
    professional_tax: Decimal
    tds: Decimal

    created_at: datetime
    updated_at: datetime

class Config:
        from_attributes = True