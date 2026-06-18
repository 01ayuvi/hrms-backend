from datetime import date

from pydantic import BaseModel, EmailStr


class EmployeeCreate(BaseModel):

    organization_id: int
    department_id: int

    first_name: str
    last_name: str

    email: EmailStr

    phone: str | None = None

    designation: str | None = None

    joining_date: date | None = None


class EmployeeResponse(BaseModel):

    employee_id: int

    organization_id: int
    department_id: int

    first_name: str
    last_name: str

    email: str

    phone: str | None = None

    designation: str | None = None

    status: str

    class Config:
        from_attributes = True