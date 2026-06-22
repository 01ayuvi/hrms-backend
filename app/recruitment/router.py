from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database.dependencies import get_db

from app.auth.permissions import require_permission

from app.audit.utils import create_audit_log

from app.departments.models import Department

from app.recruitment.models import (
    JobOpening,
    Candidate
)

from app.recruitment.schemas import (
    JobOpeningCreate,
    CandidateCreate,
    CandidateStatusUpdate
)

router = APIRouter()
@router.post("/jobs")
def create_job_opening(
    request: JobOpeningCreate,
    db: Session = Depends(get_db),
    current_user=Depends(
        require_permission(
            "create_job_opening"
        )
    )
):

    department = db.query(
        Department
    ).filter(
        Department.id ==
        request.department_id
    ).first()

    if not department:
        raise HTTPException(
            status_code=404,
            detail="Department not found"
        )

    job = JobOpening(
        title=request.title,
        department_id=request.department_id,
        description=request.description,
        openings_count=request.openings_count
    )

    db.add(job)

    db.commit()

    db.refresh(job)

    create_audit_log(
        db=db,
        user_id=current_user.id,
        action="CREATE",
        entity_type="JobOpening",
        entity_id=job.job_id
    )

    return job

@router.get("/jobs")
def get_job_openings(
    db: Session = Depends(get_db),
    current_user=Depends(
        require_permission(
            "view_job_openings"
        )
    )
):

    jobs = db.query(
        JobOpening
    ).all()

    return jobs

@router.post("/candidates")
def create_candidate(
    request: CandidateCreate,
    db: Session = Depends(get_db),
    current_user=Depends(
        require_permission(
            "create_candidate"
        )
    )
):

    job = db.query(
        JobOpening
    ).filter(
        JobOpening.job_id ==
        request.job_id
    ).first()

    if not job:
        raise HTTPException(
            status_code=404,
            detail="Job opening not found"
        )

    candidate = Candidate(
        job_id=request.job_id,
        first_name=request.first_name,
        last_name=request.last_name,
        email=request.email,
        phone=request.phone,
        resume_path=request.resume_path
    )

    db.add(candidate)

    db.commit()

    db.refresh(candidate)

    create_audit_log(
        db=db,
        user_id=current_user.id,
        action="CREATE",
        entity_type="Candidate",
        entity_id=candidate.candidate_id
    )

    return candidate

@router.get("/candidates")
def get_candidates(
    db: Session = Depends(get_db),
    current_user=Depends(
        require_permission(
            "view_candidates"
        )
    )
):

    candidates = db.query(
        Candidate
    ).all()

    return candidates
@router.put(
    "/candidates/{candidate_id}/status"
)
def update_candidate_status(
    candidate_id: int,
    request: CandidateStatusUpdate,
    db: Session = Depends(get_db),
    current_user=Depends(
        require_permission(
            "update_candidate_status"
        )
    )
):

    candidate = db.query(
        Candidate
    ).filter(
        Candidate.candidate_id ==
        candidate_id
    ).first()

    if not candidate:
        raise HTTPException(
            status_code=404,
            detail="Candidate not found"
        )

    candidate.status = request.status

    db.commit()

    db.refresh(candidate)

    create_audit_log(
        db=db,
        user_id=current_user.id,
        action="UPDATE",
        entity_type="Candidate",
        entity_id=candidate.candidate_id
    )

    return candidate