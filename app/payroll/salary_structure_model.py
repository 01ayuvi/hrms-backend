from sqlalchemy import (
    Column,
    Integer,
    DateTime,
    ForeignKey,
    DECIMAL
)
from sqlalchemy.sql import func

from app.database.database import Base


class SalaryStructure(Base):
    __tablename__ = "salary_structures"

    salary_structure_id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    employee_id = Column(
        Integer,
        ForeignKey("employees.employee_id"),
        unique=True,
        nullable=False
    )

    basic_salary = Column(
        DECIMAL(12, 2),
        nullable=False
    )

    hra_percentage = Column(
        DECIMAL(5, 2),
        default=40
    )

    pf_percentage = Column(
        DECIMAL(5, 2),
        default=12
    )

    esic_percentage = Column(
        DECIMAL(5, 2),
        default=0.75
    )

    professional_tax = Column(
        DECIMAL(12, 2),
        default=200
    )

    tds = Column(
        DECIMAL(12, 2),
        default=0
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