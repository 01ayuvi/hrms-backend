from sqlalchemy import (
    Column,
    Integer,
    String,
    DateTime,
    ForeignKey,
    DECIMAL,
    Text
)
from sqlalchemy.sql import func

from app.database.database import Base


class PayrollRun(Base):
    __tablename__ = "payroll_runs"

    payroll_run_id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    pay_period = Column(
        String(20),
        nullable=False
    )

    run_date = Column(
        DateTime,
        server_default=func.now()
    )

    status = Column(
        String(20),
        default="COMPLETED"
    )

    remarks = Column(Text)

    created_at = Column(
        DateTime,
        server_default=func.now()
    )

    updated_at = Column(
        DateTime,
        server_default=func.now(),
        onupdate=func.now()
    )


class PayrollDetail(Base):
    __tablename__ = "payroll_details"

    payroll_detail_id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    payroll_run_id = Column(
        Integer,
        ForeignKey("payroll_runs.payroll_run_id"),
        nullable=False
    )

    employee_id = Column(
        Integer,
        ForeignKey("employees.employee_id"),
        nullable=False
    )

    basic_salary = Column(
        DECIMAL(12, 2),
        nullable=False
    )

    allowances = Column(
        DECIMAL(12, 2),
        default=0
    )

    deductions = Column(
        DECIMAL(12, 2),
        default=0
    )

    net_salary = Column(
        DECIMAL(12, 2),
        nullable=False
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