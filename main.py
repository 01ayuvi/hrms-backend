from fastapi import FastAPI
from app.auth.router import router as auth_router
from app.database.database import Base, engine
from app.employees.router import router as employee_router

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