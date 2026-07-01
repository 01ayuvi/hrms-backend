from pydantic import BaseModel
from datetime import date, datetime
from decimal import Decimal


class AttendanceCheckIn(BaseModel):
    pass


class AttendanceCheckOut(BaseModel):
    pass


class AttendanceResponse(BaseModel):
    attendance_id: int
    employee_id: int
    attendance_date: date

    check_in_time: datetime | None = None
    check_out_time: datetime | None = None

    working_hours: Decimal | None = None

    attendance_status: str

    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True