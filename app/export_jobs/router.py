from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.dependencies import get_db
from app.export_jobs.models import ExportJob

router = APIRouter()


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