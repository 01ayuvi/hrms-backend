from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database.dependencies import get_db

from app.audit.models import AuditLog

router = APIRouter()


@router.get("/")
def get_audit_logs(
    db: Session = Depends(get_db)
):

    logs = db.query(
        AuditLog
    ).all()

    return logs