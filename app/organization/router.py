from fastapi import APIRouter
from fastapi import Depends
from sqlalchemy.orm import Session
from .schemas import (
    OrganizationPolicyUpdate,
    OrganizationUpdate
)

from app.database.dependencies import get_db

router = APIRouter(
    prefix="/organization",
    tags=["Organization"]
)
from .models import OrganizationPolicy

from .company_model import Organization

@router.get("/policies")
def get_policies(
    db: Session = Depends(get_db)
):
    return db.query(
        OrganizationPolicy
    ).all()
@router.post("/policies")
def create_policy(
    request: OrganizationPolicyUpdate,
    db: Session = Depends(get_db)
):
    policy = OrganizationPolicy(
        organization_id=1,
        working_days=request.working_days,
        office_start_time=request.office_start_time,
        office_end_time=request.office_end_time,
        late_mark_after=request.late_mark_after,
        half_day_after=request.half_day_after,
        annual_leave_limit=request.annual_leave_limit,
        casual_leave_limit=request.casual_leave_limit,
        sick_leave_limit=request.sick_leave_limit,
        probation_months=request.probation_months,
        notice_period_days=request.notice_period_days
    )

    db.add(policy)

    db.commit()

    db.refresh(policy)

    return policy
@router.get("/")
def get_organization(
    db: Session = Depends(get_db)
):
    return db.query(
        Organization
    ).first()
@router.put("/")
def update_organization(
    request: OrganizationUpdate,
    db: Session = Depends(get_db)
):
    org = db.query(
        Organization
    ).first()

    if not org:
        raise HTTPException(
            status_code=404,
            detail="Organization not found"
        )

    org.name = request.name
    org.company_code = request.company_code
    org.gst_number = request.gst_number
    org.cin_number = request.cin_number
    org.pan_number = request.pan_number
    org.industry = request.industry
    org.website = request.website
    org.email = request.email
    org.phone = request.phone
    org.address = request.address
    org.city = request.city
    org.state = request.state
    org.country = request.country
    org.postal_code = request.postal_code
    org.timezone = request.timezone
    org.employee_strength = request.employee_strength

    db.commit()

    return {
        "message":
        "Organization Updated Successfully"
    }