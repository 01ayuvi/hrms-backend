from datetime import datetime
from pydantic import BaseModel


class LeaveBalanceCreate(BaseModel):
    employee_id: int
    leave_type: str
    total_leaves: int


class LeaveBalanceResponse(BaseModel):
    leave_balance_id: int
    employee_id: int
    leave_type: str
    total_leaves: int
    used_leaves: int
    remaining_leaves: int
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True