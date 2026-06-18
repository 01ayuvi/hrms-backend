from fastapi import FastAPI
from app.auth.router import router as auth_router
from app.database.database import Base, engine
from app.employees.router import router as employee_router
from app.departments.router import router as department_router
from app.roles.router import router as role_router
from app.roles.models import Role
from app.permissions.models import Permission
from app.permissions.router import (
    router as permission_router
)
Base.metadata.create_all(bind=engine)
app = FastAPI(
    title="HRMS Backend"
)


@app.get("/")
def root():
    return {"message": "HRMS Backend Running"}

app.include_router(
    auth_router,
    prefix="/auth",
    tags=["Authentication"]
)
app.include_router(
    employee_router,
    prefix="/employees",
    tags=["Employees"]
)
app.include_router(
    department_router,
    prefix="/departments",
    tags=["Departments"]
)
app.include_router(
    role_router,
    prefix="/roles",
    tags=["Roles"]
)

app.include_router(
    permission_router,
    prefix="/permissions",
    tags=["Permissions"]
)