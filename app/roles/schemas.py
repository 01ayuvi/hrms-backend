from pydantic import BaseModel


class RoleCreate(BaseModel):

    role_name: str
    description: str | None = None


class RoleUpdate(BaseModel):

    role_name: str
    description: str | None = None


class RoleResponse(BaseModel):

    id: int
    role_name: str
    description: str | None = None

    class Config:
        from_attributes = True