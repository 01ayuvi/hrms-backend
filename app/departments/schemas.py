from pydantic import BaseModel


class DepartmentCreate(BaseModel):

    organization_id: int
    department_name: str
    department_code: str


class DepartmentUpdate(BaseModel):

    department_name: str
    department_code: str


class DepartmentResponse(BaseModel):

    id: int
    organization_id: int
    department_name: str
    department_code: str

    class Config:
        from_attributes = True