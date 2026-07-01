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

from app.role_permissions.router import (
    router as role_permission_router
)
from app.role_permissions.models import (
    RolePermission
)

from app.user_roles.router import router as user_role_router
from app.user_roles.models import UserRole

from app.audit.router import router as audit_router
from app.audit.models import AuditLog

from app.dashboard.router import router as dashboard_router
from app.performance.models import PerformanceReview
from app.export_jobs.models import ExportJob
from app.export_jobs.router import (
    router as export_jobs_router
)

from app.performance.router import (
    router as performance_router
)
from app.recruitment.router import router as recruitment_router
#Base.metadata.create_all(bind=engine)

from app.attendance.router import router as attendance_router

from app.leave.router import router as leave_router
from app.leave.leave_balance_router import (
    router as leave_balance_router
)

from app.payroll.router import router as payroll_router
from app.payroll.salary_structure_router import (
    router as salary_structure_router
)
from app.attendance.models import Attendance

from app.leave.models import LeaveRequest
from app.leave.leave_balance_model import LeaveBalance

from app.payroll.models import (
    PayrollRun,
    PayrollDetail
)

from app.payroll.salary_structure_model import (
    SalaryStructure
)
Base.metadata.create_all(bind=engine)
from app.organization.router import router as organization_router
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
app = FastAPI(
    title="HRMS Backend"
)
app.mount(
    "/uploads",
    StaticFiles(directory="uploads"),
    name="uploads"
)

app.include_router(organization_router)
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:5173",
        "http://127.0.0.1:5173"
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
@app.get("/")
def root():
    return {
        "message": "HRMS Backend Running"
    }
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

app.include_router(
    role_permission_router,
    prefix="/role-permissions",
    tags=["Role Permissions"]
)

app.include_router(
    user_role_router,
    prefix="/user-roles",
    tags=["User Roles"]
)

app.include_router(
    audit_router,
    prefix="/audit",
    tags=["Audit Logs"]
)

app.include_router(
    export_jobs_router,
    prefix="/export-jobs",
    tags=["Export Jobs"]
)

app.include_router(
    dashboard_router,
    prefix="/dashboard",
    tags=["Dashboard"]
)

app.include_router(
    recruitment_router,
    prefix="/recruitment",
    tags=["Recruitment"]
)
app.include_router(
    performance_router,
    prefix="/performance",
    tags=["Performance"]
)
app.include_router(
    attendance_router,
    prefix="/attendance",
    tags=["Attendance"]
)

app.include_router(
    leave_router,
    prefix="/leave",
    tags=["Leave"]
)

app.include_router(
    leave_balance_router,
    prefix="/leave-balance",
    tags=["Leave Balance"]
)

app.include_router(
    payroll_router,
    prefix="/payroll",
    tags=["Payroll"]
)

app.include_router(
    salary_structure_router,
    prefix="/salary-structure",
    tags=["Salary Structure"]
)