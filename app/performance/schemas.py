from datetime import datetime
from typing import Optional, Literal

from pydantic import BaseModel


class PerformanceReviewCreate(BaseModel):
    employee_id: int
    reviewer_id: int
    review_period: str
    rating: int
    strengths: Optional[str] = None
    improvements: Optional[str] = None
    goals: Optional[str] = None


class PerformanceReviewUpdate(BaseModel):
    review_period: Optional[str] = None
    rating: Optional[int] = None
    strengths: Optional[str] = None
    improvements: Optional[str] = None
    goals: Optional[str] = None
    status: Optional[
        Literal[
            "DRAFT",
            "SUBMITTED",
            "APPROVED"
        ]
    ] = None


class PerformanceReviewResponse(BaseModel):
    review_id: int
    employee_id: int
    reviewer_id: int
    review_period: str
    rating: int
    strengths: Optional[str]
    improvements: Optional[str]
    goals: Optional[str]
    status: str
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True


class PerformanceReviewListResponse(BaseModel):
    reviews: list[PerformanceReviewResponse]