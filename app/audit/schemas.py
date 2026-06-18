from pydantic import BaseModel
from datetime import datetime


class AuditResponse(BaseModel):

    id: int
    user_id: int | None
    action: str
    entity_type: str | None
    entity_id: int | None
    timestamp: datetime

    class Config:
        from_attributes = True