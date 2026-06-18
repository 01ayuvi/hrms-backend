from fastapi import FastAPI
from app.auth.router import router as auth_router
from app.database.database import Base, engine

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