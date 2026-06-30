from pydantic import BaseModel
from datetime import time
from datetime import date
establishment_date: date 

class OrganizationPolicyUpdate(
    BaseModel
):
    working_days: str

    office_start_time: time

    office_end_time: time

    late_mark_after: time

    half_day_after: time

    annual_leave_limit: int

    casual_leave_limit: int

    sick_leave_limit: int

    probation_months: int

    notice_period_days: int
    
class OrganizationUpdate(
    BaseModel
):
    name: str

    organization_type: str 
    
    establishment_date: date 
    
    status: str = "ACTIVE"

    company_code: str

    gst_number: str

    cin_number: str

    pan_number: str
    
    hr_contact_email: str 

    industry: str

    website: str

    logo_path: str | None = None

    email: str

    phone: str

    address: str

    city: str

    state: str

    country: str

    postal_code: str

    timezone: str

    employee_strength: int