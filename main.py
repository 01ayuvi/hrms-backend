from fastapi import FastAPI

from app.employees.models import Employee

from app.attendance.router import router as attendance_router
from app.leave.router import router as leave_router
from app.payroll.router import router as payroll_router

from app.payroll.salary_structure_router import (
    router as salary_structure_router
)
from app.leave.leave_balance_router import (
    router as leave_balance_router
)

app = FastAPI(title="HRMS Backend")

app.include_router(attendance_router)
app.include_router(leave_router)
app.include_router(payroll_router)
app.include_router(salary_structure_router)
app.include_router(leave_balance_router)

@app.get("/")
def root():
    return {"message": "HRMS Backend Running"}