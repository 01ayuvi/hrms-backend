from sqlalchemy import Column
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy import Text
from sqlalchemy import DateTime
from sqlalchemy import ForeignKey

from sqlalchemy.sql import func

from app.database.database import Base

class EmployeeDocument(Base):
    __tablename__ = "employee_documents"

    id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    employee_id = Column(
        Integer,
        ForeignKey("employees.employee_id"),
        nullable=False
    )

    document_name = Column(
        String(255),
        nullable=False
    )

    document_type = Column(
        String(100),
        nullable=False
    )

    file_path = Column(
        Text,
        nullable=False
    )

    uploaded_by = Column(
        Integer,
        ForeignKey("users.id"),
        nullable=True
    )

    uploaded_at = Column(
        DateTime,
        server_default=func.now()
    )

    created_at = Column(
        DateTime,
        server_default=func.now()
    )