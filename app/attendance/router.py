from datetime import datetime, date

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database.dependencies import get_db
from app.attendance.models import Attendance
from app.attendance.schemas import (
    AttendanceCheckIn,
    AttendanceCheckOut,
    AttendanceResponse
)

router = APIRouter(
    tags=["Attendance"]
)


@router.post("/checkin", response_model=AttendanceResponse)
def check_in(
    attendance_data: AttendanceCheckIn,
    db: Session = Depends(get_db)
):
    today = date.today()

    existing = db.query(Attendance).filter(
        Attendance.employee_id == attendance_data.employee_id,
        Attendance.attendance_date == today
    ).first()

    if existing:
        raise HTTPException(
            status_code=400,
            detail="Employee already checked in today"
        )

    attendance = Attendance(
        employee_id=attendance_data.employee_id,
        attendance_date=today,
        check_in_time=datetime.now(),
        attendance_status="PRESENT"
    )

    db.add(attendance)
    db.commit()
    db.refresh(attendance)

    return attendance


@router.post("/checkout", response_model=AttendanceResponse)
def check_out(
    attendance_data: AttendanceCheckOut,
    db: Session = Depends(get_db)
):
    today = date.today()

    attendance = db.query(Attendance).filter(
        Attendance.employee_id == attendance_data.employee_id,
        Attendance.attendance_date == today
    ).first()

    if not attendance:
        raise HTTPException(
            status_code=404,
            detail="Attendance record not found"
        )

    attendance.check_out_time = datetime.now()

    if attendance.check_in_time:
        hours = (
            attendance.check_out_time -
            attendance.check_in_time
        ).total_seconds() / 3600

        attendance.working_hours = round(hours, 2)

    db.commit()
    db.refresh(attendance)

    return attendance


@router.get("/", response_model=list[AttendanceResponse])
def get_attendance(
    db: Session = Depends(get_db)
):
    return db.query(Attendance).all()