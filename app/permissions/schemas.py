from pydantic import BaseModel


class PermissionCreate(BaseModel):

    permission_name: str
    description: str | None = None


class PermissionUpdate(BaseModel):

    permission_name: str
    description: str | None = None


class PermissionResponse(BaseModel):

    id: int
    permission_name: str
    description: str | None = None

    class Config:
        from_attributes = True