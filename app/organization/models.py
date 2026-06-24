from sqlalchemy import Column
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy import Time
from sqlalchemy import DateTime


from sqlalchemy.sql import func

from app.database.database import Base


class OrganizationPolicy(Base):
    __tablename__ = "organization_policies"

    policy_id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    organization_id = Column(
    Integer,
    nullable=False
)

    working_days = Column(String)

    office_start_time = Column(Time)

    office_end_time = Column(Time)

    late_mark_after = Column(Time)

    half_day_after = Column(Time)

    annual_leave_limit = Column(Integer)

    casual_leave_limit = Column(Integer)

    sick_leave_limit = Column(Integer)

    probation_months = Column(Integer)

    notice_period_days = Column(Integer)

    created_at = Column(
        DateTime,
        server_default=func.now()
    )

    updated_at = Column(
        DateTime,
        server_default=func.now(),
        onupdate=func.now()
    )