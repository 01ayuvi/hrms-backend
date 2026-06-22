from fastapi import FastAPI

from app.employees.models import Employee
from app.attendance.router import router as attendance_router
from app.leave.router import router as leave_router

app = FastAPI(title="HRMS Backend")

app.include_router(attendance_router)
app.include_router(leave_router)


@app.get("/")
def root():
    return {"message": "HRMS Backend Running"}