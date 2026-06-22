from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database.dependencies import get_db

from app.auth.permissions import require_permission

from app.audit.utils import create_audit_log

from app.employees.models import Employee
from app.auth.models import User
from app.performance.models import (
    PerformanceReview
)

from app.performance.schemas import (
    PerformanceReviewCreate,
    PerformanceReviewUpdate
)

router = APIRouter()


@router.post("/reviews")
def create_performance_review(
    request: PerformanceReviewCreate,
    db: Session = Depends(get_db),
    current_user=Depends(
        require_permission(
            "create_performance_review"
        )
    )
):

    employee = db.query(
        Employee
    ).filter(
        Employee.employee_id ==
        request.employee_id
    ).first()

    if not employee:
        raise HTTPException(
            status_code=404,
            detail="Employee not found"
        )

    reviewer = db.query(
        User
    ).filter(
        User.id ==
        request.reviewer_id
    ).first()

    if not reviewer:
        raise HTTPException(
            status_code=404,
            detail="Reviewer not found"
        )

    review = PerformanceReview(
        employee_id=request.employee_id,
        reviewer_id=request.reviewer_id,
        review_period=request.review_period,
        rating=request.rating,
        strengths=request.strengths,
        improvements=request.improvements,
        goals=request.goals
    )

    db.add(review)

    db.commit()

    db.refresh(review)

    create_audit_log(
        db=db,
        user_id=current_user.id,
        action="CREATE",
        entity_type="PerformanceReview",
        entity_id=review.review_id
    )

    return review


@router.get("/reviews")
def get_reviews(
    db: Session = Depends(get_db),
    current_user=Depends(
        require_permission(
            "view_performance_reviews"
        )
    )
):

    reviews = db.query(
        PerformanceReview
    ).all()

    return reviews


@router.get("/reviews/{employee_id}")
def get_employee_reviews(
    employee_id: int,
    db: Session = Depends(get_db),
    current_user=Depends(
        require_permission(
            "view_performance_reviews"
        )
    )
):

    employee = db.query(
        Employee
    ).filter(
        Employee.employee_id ==
        employee_id
    ).first()

    if not employee:
        raise HTTPException(
            status_code=404,
            detail="Employee not found"
        )

    reviews = db.query(
        PerformanceReview
    ).filter(
        PerformanceReview.employee_id ==
        employee_id
    ).all()

    return reviews


@router.put("/reviews/{review_id}")
def update_review(
    review_id: int,
    request: PerformanceReviewUpdate,
    db: Session = Depends(get_db),
    current_user=Depends(
        require_permission(
            "update_performance_review"
        )
    )
):

    review = db.query(
        PerformanceReview
    ).filter(
        PerformanceReview.review_id ==
        review_id
    ).first()

    if not review:
        raise HTTPException(
            status_code=404,
            detail="Review not found"
        )

    if request.review_period is not None:
        review.review_period = request.review_period

    if request.rating is not None:
        review.rating = request.rating

    if request.strengths is not None:
        review.strengths = request.strengths

    if request.improvements is not None:
        review.improvements = request.improvements

    if request.goals is not None:
        review.goals = request.goals

    if request.status is not None:
        review.status = request.status

    db.commit()

    db.refresh(review)

    create_audit_log(
        db=db,
        user_id=current_user.id,
        action="UPDATE",
        entity_type="PerformanceReview",
        entity_id=review.review_id
    )

    return review