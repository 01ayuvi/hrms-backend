from sqlalchemy import (
    Column,
    Integer,
    String,
    DateTime,
    ForeignKey
)

from sqlalchemy.sql import func

from app.database.database import Base


class LeaveBalance(Base):
    __tablename__ = "leave_balances"

    leave_balance_id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    employee_id = Column(
        Integer,
        ForeignKey("employees.employee_id"),
        nullable=False
    )

    leave_type = Column(
        String(50),
        nullable=False
    )

    total_leaves = Column(
        Integer,
        default=12
    )

    used_leaves = Column(
        Integer,
        default=0
    )

    remaining_leaves = Column(
        Integer,
        default=12
    )

    created_at = Column(
        DateTime,
        server_default=func.now()
    )

    updated_at = Column(
        DateTime,
        server_default=func.now(),
        onupdate=func.now()
    )