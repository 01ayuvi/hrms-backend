from pydantic import BaseModel
from typing import Optional


class EmployeeSearchRequest(BaseModel):

    employee_name: Optional[str] = None

    department_id: Optional[int] = None

    status: Optional[str] = None

    page: int = 1

    page_size: int = 10

    sort_by: str = "employee_id"

    sort_order: str = "desc"


class EmployeeSearchResponse(BaseModel):

    count: int

    page: int

    page_size: int

    records: list