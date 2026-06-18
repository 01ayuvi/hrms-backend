from sqlalchemy import Column, Integer, String, Date, DateTime
from sqlalchemy.sql import func

from app.database.database import Base


class Employee(Base):
    __tablename__ = "employees"

    employee_id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    organization_id = Column(
        Integer,
        nullable=False
    )

    department_id = Column(
        Integer,
        nullable=False
    )

    first_name = Column(
        String(50),
        nullable=False
    )

    last_name = Column(
        String(50),
        nullable=False
    )

    email = Column(
        String(100),
        nullable=False,
        unique=True
    )

    phone = Column(
        String(20)
    )

    designation = Column(
        String(100)
    )

    joining_date = Column(
        Date
    )

    status = Column(
        String(20),
        default="ACTIVE"
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