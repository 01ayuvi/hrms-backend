from datetime import datetime
from typing import Optional, Literal

from pydantic import BaseModel, EmailStr
class JobOpeningCreate(BaseModel):
    title: str
    department_id: int
    description: Optional[str] = None
    openings_count: int = 1

class JobOpeningResponse(BaseModel):
    job_id: int
    title: str
    department_id: int
    description: Optional[str]
    openings_count: int
    status: str
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True
class CandidateCreate(BaseModel):
    job_id: int
    first_name: str
    last_name: str
    email: EmailStr
    phone: Optional[str] = None
    resume_path: Optional[str] = None

class CandidateStatusUpdate(BaseModel):
    status: Literal[
        "APPLIED",
        "SCREENING",
        "INTERVIEW",
        "OFFERED",
        "HIRED",
        "REJECTED"
    ]
class CandidateResponse(BaseModel):
    candidate_id: int
    job_id: int
    first_name: str
    last_name: str
    email: str
    phone: Optional[str]
    resume_path: Optional[str]
    status: str
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True
class JobOpeningListResponse(BaseModel):
    jobs: list[JobOpeningResponse]


class CandidateListResponse(BaseModel):
    candidates: list[CandidateResponse]