from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from .company_model import Organization
from fastapi import UploadFile, File
import os
import shutil
from .schemas import (
    OrganizationPolicyUpdate,
    OrganizationUpdate
)

from app.database.dependencies import get_db


router = APIRouter(
    prefix="/organization",
    tags=["Organization"]
)
LOGO_UPLOAD_DIR = "uploads/organization"

os.makedirs(
    LOGO_UPLOAD_DIR,
    exist_ok=True
)
from .models import OrganizationPolicy



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
    org.organization_type = request.organization_type
    org.establishment_date = request.establishment_date
    org.status = request.status
    org.company_code = request.company_code
    org.gst_number = request.gst_number
    org.cin_number = request.cin_number
    org.pan_number = request.pan_number
    org.hr_contact_email = request.hr_contact_email
    org.industry = request.industry
    org.website = request.website
    org.logo_path = request.logo_path
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

@router.post("/upload-logo")
def upload_logo(
    file: UploadFile = File(...),
    db: Session = Depends(get_db)
):
    org = db.query(Organization).first()

    if not org:
        raise HTTPException(
            status_code=404,
            detail="Organization not found"
        )

    file_path = os.path.join(
        LOGO_UPLOAD_DIR,
        file.filename
    )

    with open(file_path, "wb") as buffer:
        shutil.copyfileobj(
            file.file,
            buffer
        )

    # Save URL-friendly path in database
    org.logo_path = file_path.replace("\\", "/")

    db.commit()

    db.refresh(org)

    return {
        "message": "Logo uploaded successfully",
        "logo_path": org.logo_path
    }
    
@router.put("/policies")
def update_policy(
    request: OrganizationPolicyUpdate,
    db: Session = Depends(get_db)
):
    policy = db.query(
        OrganizationPolicy
    ).filter(
        OrganizationPolicy.organization_id == 1
    ).first()

    if not policy:
        raise HTTPException(
            status_code=404,
            detail="Organization policy not found"
        )

    policy.working_days = request.working_days
    policy.office_start_time = request.office_start_time
    policy.office_end_time = request.office_end_time
    policy.late_mark_after = request.late_mark_after
    policy.half_day_after = request.half_day_after
    policy.annual_leave_limit = request.annual_leave_limit
    policy.casual_leave_limit = request.casual_leave_limit
    policy.sick_leave_limit = request.sick_leave_limit
    policy.probation_months = request.probation_months
    policy.notice_period_days = request.notice_period_days

    db.commit()

    db.refresh(policy)

    return {
        "message": "Organization policy updated successfully"
    }