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
from sqlalchemy.orm import relationship

from app.database.database import Base

class JobOpening(Base):
    __tablename__ = "job_openings"

    job_id = Column(Integer, primary_key=True, index=True)

    title = Column(String(255), nullable=False)

    department_id = Column(
        Integer,
        ForeignKey("departments.id"),
        nullable=False
    )

    description = Column(Text)

    openings_count = Column(
        Integer,
        nullable=False,
        default=1
    )

    status = Column(
        String(20),
        nullable=False,
        default="OPEN"
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

    candidates = relationship(
        "Candidate",
        back_populates="job"
    )

class Candidate(Base):
    __tablename__ = "candidates"

    candidate_id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    job_id = Column(
        Integer,
        ForeignKey("job_openings.job_id"),
        nullable=False
    )

    first_name = Column(
        String(100),
        nullable=False
    )

    last_name = Column(
        String(100),
        nullable=False
    )

    email = Column(
        String(255),
        nullable=False
    )

    phone = Column(
        String(30)
    )

    resume_path = Column(
        String(500)
    )

    status = Column(
        String(30),
        nullable=False,
        default="APPLIED"
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

    job = relationship(
        "JobOpening",
        back_populates="candidates"
    )

Index(
    "idx_job_openings_department",
    JobOpening.department_id
)

Index(
    "idx_candidates_job",
    Candidate.job_id
)

Index(
    "idx_candidates_email",
    Candidate.email
)

Index(
    "idx_candidates_status",
    Candidate.status
)