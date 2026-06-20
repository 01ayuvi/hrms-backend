from sqlalchemy import (
    Column,
    Integer,
    String,
    DateTime
)

from sqlalchemy.sql import func

from app.database.database import Base


class ExportJob(Base):

    __tablename__ = "export_jobs"

    id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    report_type = Column(
        String(50),
        nullable=False
    )

    file_name = Column(
        String(255)
    )

    status = Column(
        String(20),
        default="PENDING"
    )

    created_at = Column(
        DateTime,
        server_default=func.now()
    )

    completed_at = Column(
        DateTime,
        nullable=True
    )