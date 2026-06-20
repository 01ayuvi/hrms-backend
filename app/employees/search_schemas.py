from pydantic import BaseModel
from typing import Optional
from datetime import date


class EmployeeSearchRequest(BaseModel):

    employee_name: Optional[str] = None

    department_id: Optional[int] = None

    status: Optional[str] = None

    designation: Optional[str] = None

    joining_date_from: Optional[date] = None

    joining_date_to: Optional[date] = None

    page: int = 1

    page_size: int = 10

    sort_by: str = "employee_id"

    sort_order: str = "desc"


class EmployeeSearchResponse(BaseModel):

    count: int

    page: int

    page_size: int

    records: list