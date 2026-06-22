from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database.database import get_db
from app.leave.models import LeaveRequest
from app.leave.schemas import (
    LeaveApply,
    LeaveApproval,
    LeaveResponse
)

router = APIRouter(
    prefix="/leave",
    tags=["Leave Management"]
)


@router.post("/apply", response_model=LeaveResponse)
def apply_leave(
    leave_data: LeaveApply,
    db: Session = Depends(get_db)
):
    leave_request = LeaveRequest(
        employee_id=leave_data.employee_id,
        leave_type=leave_data.leave_type,
        start_date=leave_data.start_date,
        end_date=leave_data.end_date,
        reason=leave_data.reason,
        status="PENDING"
    )

    db.add(leave_request)
    db.commit()
    db.refresh(leave_request)

    return leave_request


@router.post("/approve", response_model=LeaveResponse)
def approve_leave(
    approval_data: LeaveApproval,
    db: Session = Depends(get_db)
):
    leave_request = db.query(LeaveRequest).filter(
        LeaveRequest.leave_id == approval_data.leave_id
    ).first()

    if not leave_request:
        raise HTTPException(
            status_code=404,
            detail="Leave request not found"
        )

    leave_request.status = "APPROVED"
    leave_request.approved_by = approval_data.approved_by

    db.commit()
    db.refresh(leave_request)

    return leave_request


@router.post("/reject", response_model=LeaveResponse)
def reject_leave(
    approval_data: LeaveApproval,
    db: Session = Depends(get_db)
):
    leave_request = db.query(LeaveRequest).filter(
        LeaveRequest.leave_id == approval_data.leave_id
    ).first()

    if not leave_request:
        raise HTTPException(
            status_code=404,
            detail="Leave request not found"
        )

    leave_request.status = "REJECTED"
    leave_request.approved_by = approval_data.approved_by

    db.commit()
    db.refresh(leave_request)

    return leave_request


@router.get("/", response_model=list[LeaveResponse])
def get_leave_requests(
    db: Session = Depends(get_db)
):
    return db.query(LeaveRequest).all()