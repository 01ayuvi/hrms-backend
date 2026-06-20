from pydantic import BaseModel
from typing import Optional
from datetime import date


class EmployeeExportRequest(BaseModel):

    employee_name: Optional[str] = None

    department_id: Optional[int] = None

    status: Optional[str] = None

    designation: Optional[str] = None

    joining_date_from: Optional[date] = None

    joining_date_to: Optional[date] = None