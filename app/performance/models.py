from sqlalchemy import (
    Column,
    Integer,
    String,
    Text,
    DateTime,
    ForeignKey,
    Index
)

from sqlalchemy.sql import func

from app.database.database import Base


class PerformanceReview(Base):
    __tablename__ = "performance_reviews"

    review_id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    employee_id = Column(
        Integer,
        ForeignKey(
            "employees.employee_id"
        ),
        nullable=False
    )

    reviewer_id = Column(
        Integer,
        ForeignKey(
            "users.id"
        ),
        nullable=False
    )

    review_period = Column(
        String(100),
        nullable=False
    )

    rating = Column(
        Integer,
        nullable=False
    )

    strengths = Column(
        Text
    )

    improvements = Column(
        Text
    )

    goals = Column(
        Text
    )

    status = Column(
        String(20),
        nullable=False,
        default="DRAFT"
    )

    created_at = Column(
        DateTime(timezone=True),
        server_default=func.now(),
        nullable=False
    )

    updated_at = Column(
        DateTime(timezone=True),
        server_default=func.now(),
        onupdate=func.now(),
        nullable=False
    )


Index(
    "idx_review_employee",
    PerformanceReview.employee_id
)

Index(
    "idx_review_reviewer",
    PerformanceReview.reviewer_id
)

Index(
    "idx_review_status",
    PerformanceReview.status
)