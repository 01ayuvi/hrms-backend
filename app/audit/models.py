from sqlalchemy import (
    Column,
    Integer,
    String,
    DateTime,
    ForeignKey
)

from sqlalchemy.sql import func

from app.database.database import Base


class AuditLog(Base):
    __tablename__ = "audit_logs"

    id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    user_id = Column(
        Integer,
        ForeignKey("users.id"),
        nullable=True
    )

    action = Column(
        String(255),
        nullable=False
    )

    entity_type = Column(
        String(100)
    )

    entity_id = Column(
        Integer
    )

    timestamp = Column(
        DateTime,
        server_default=func.now()
    )