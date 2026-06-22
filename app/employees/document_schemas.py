from pydantic import BaseModel
from datetime import datetime


class EmployeeDocumentResponse(BaseModel):
    id: int
    employee_id: int
    document_name: str
    document_type: str
    uploaded_at: datetime

    class Config:
        from_attributes = True

class EmployeeDocumentSearchRequest(BaseModel):
    document_type: str | None = None

    page: int = 1
    page_size: int = 50

class EmployeeDocumentSearchResponse(BaseModel):
    count: int
    page: int
    page_size: int
    records: list[EmployeeDocumentResponse]