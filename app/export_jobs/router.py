from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from fastapi.responses import FileResponse

from app.database.dependencies import get_db
from app.export_jobs.models import ExportJob

router = APIRouter()
from fastapi import (
    APIRouter,
    Depends,
    HTTPException
)

@router.get("/")
def get_export_jobs(
    db: Session = Depends(get_db)
):

    jobs = db.query(
        ExportJob
    ).order_by(
        ExportJob.id.desc()
    ).all()

    return jobs
@router.get("/{job_id}")
def get_export_job(
    job_id: int,
    db: Session = Depends(get_db)
):

    job = db.query(
        ExportJob
    ).filter(
        ExportJob.id == job_id
    ).first()

    if not job:
        raise HTTPException(
            status_code=404,
            detail="Export job not found"
        )

    return job
@router.get("/{job_id}/download")
def download_export(
    job_id: int,
    db: Session = Depends(get_db)
):

    job = db.query(
        ExportJob
    ).filter(
        ExportJob.id == job_id
    ).first()

    if not job:
        raise HTTPException(
            status_code=404,
            detail="Export job not found"
        )

    if not job.file_name:
        raise HTTPException(
            status_code=404,
            detail="File not generated"
        )

    return FileResponse(
        path=job.file_name,
        filename=job.file_name.split("/")[-1],
        media_type=
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    )