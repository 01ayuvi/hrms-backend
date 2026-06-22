from pydantic import BaseModel
from typing import Optional


class DocumentSearchRequest(BaseModel):

    employee_id: Optional[int] = None

    document_type: Optional[str] = None

    page: int = 1

    page_size: int = 20