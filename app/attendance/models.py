from sqlalchemy import (
    Column,
    Integer,
    String,
    Date,
    DateTime,
    ForeignKey,
    DECIMAL
)
from sqlalchemy.sql import func

from app.database.database import Base


class Attendance(Base):
    __tablename__ = "attendance"

    attendance_id = Column(Integer, primary_key=True, index=True)

    employee_id = Column(
        Integer,
        ForeignKey("employees.employee_id"),
        nullable=False
    )

    attendance_date = Column(Date, nullable=False)

    check_in_time = Column(DateTime)
    check_out_time = Column(DateTime)

    working_hours = Column(DECIMAL(5, 2))

    attendance_status = Column(
        String(20),
        default="PRESENT"
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