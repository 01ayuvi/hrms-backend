from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.dependencies import get_db

from app.leave.leave_balance_model import LeaveBalance
from app.leave.leave_balance_schema import (
    LeaveBalanceCreate,
    LeaveBalanceResponse
)

router = APIRouter(
    prefix="/leave-balance",
    tags=["Leave Balance"]
)


@router.post("/", response_model=LeaveBalanceResponse)
def create_leave_balance(
    leave_data: LeaveBalanceCreate,
    db: Session = Depends(get_db)
):
    leave_balance = LeaveBalance(
        employee_id=leave_data.employee_id,
        leave_type=leave_data.leave_type,
        total_leaves=leave_data.total_leaves,
        used_leaves=0,
        remaining_leaves=leave_data.total_leaves
    )

    db.add(leave_balance)
    db.commit()
    db.refresh(leave_balance)

    return leave_balance


@router.get("/", response_model=list[LeaveBalanceResponse])
def get_leave_balances(
    db: Session = Depends(get_db)
):
    return db.query(LeaveBalance).all()