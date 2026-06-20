from pydantic import BaseModel
from datetime import datetime


class ExportJobResponse(BaseModel):

    id: int

    report_type: str

    file_name: str | None

    status: str

    created_at: datetime

    completed_at: datetime | None

    class Config:
        from_attributes = True