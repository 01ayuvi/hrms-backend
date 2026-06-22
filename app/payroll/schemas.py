from pydantic import BaseModel
from decimal import Decimal
from datetime import datetime


class PayrollRunCreate(BaseModel):
    pay_period: str
    remarks: str | None = None


class PayrollRunResponse(BaseModel):
    payroll_run_id: int
    pay_period: str
    run_date: datetime
    status: str
    remarks: str | None = None
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


class PayrollDetailCreate(BaseModel):
    payroll_run_id: int
    employee_id: int
    basic_salary: Decimal
    allowances: Decimal = 0
    deductions: Decimal = 0


class PayrollDetailResponse(BaseModel):
    payroll_detail_id: int

    payroll_run_id: int
    employee_id: int

    basic_salary: Decimal

    hra: Decimal
    gross_salary: Decimal

    allowances: Decimal
    deductions: Decimal

    pf_deduction: Decimal
    esic_deduction: Decimal
    professional_tax: Decimal
    tds: Decimal

    lwp_deduction: Decimal

    net_salary: Decimal

    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True
