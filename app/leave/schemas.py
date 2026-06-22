from pydantic import BaseModel
from datetime import date, datetime


class LeaveApply(BaseModel):
    employee_id: int
    leave_type: str
    start_date: date
    end_date: date
    reason: str


class LeaveApproval(BaseModel):
    leave_id: int
    approved_by: int


class LeaveResponse(BaseModel):
    leave_id: int
    employee_id: int
    leave_type: str
    start_date: date
    end_date: date
    reason: str
    status: str
    approved_by: int | None = None

    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True