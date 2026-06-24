from sqlalchemy import Column
from sqlalchemy import Integer
from sqlalchemy import String
from sqlalchemy import Text

from app.database.database import Base


class Organization(Base):
    __tablename__ = "organizations"

    id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    name = Column(String)

    company_code = Column(String)

    gst_number = Column(String)

    cin_number = Column(String)

    pan_number = Column(String)

    industry = Column(String)

    website = Column(String)

    email = Column(String)

    phone = Column(String)

    address = Column(Text)

    city = Column(String)

    state = Column(String)

    country = Column(String)

    postal_code = Column(String)

    timezone = Column(String)

    employee_strength = Column(Integer)