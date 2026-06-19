from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database.dependencies import get_db
from app.auth.permissions import require_permission

from app.permissions.models import Permission
from app.permissions.schemas import (
    PermissionCreate,
    PermissionUpdate
)

router = APIRouter()


@router.post("/")
def create_permission(
    request: PermissionCreate,
    db: Session = Depends(get_db)
):

    existing_permission = db.query(
        Permission
    ).filter(
        Permission.permission_name ==
        request.permission_name
    ).first()

    if existing_permission:
        raise HTTPException(
            status_code=400,
            detail="Permission already exists"
        )

    permission = Permission(
        permission_name=request.permission_name,
        description=request.description
    )

    db.add(permission)
    db.commit()
    db.refresh(permission)

    return permission


@router.get("/")
def get_permissions(
    db: Session = Depends(get_db)
):

    permissions = db.query(
        Permission
    ).all()

    return permissions


@router.put("/{permission_id}")
def update_permission(
    permission_id: int,
    request: PermissionUpdate,
    db: Session = Depends(get_db),
    current_user=Depends(
        require_permission("manage_permissions")
    )
):

    permission = db.query(
        Permission
    ).filter(
        Permission.id == permission_id
    ).first()

    if not permission:
        raise HTTPException(
            status_code=404,
            detail="Permission not found"
        )

    permission.permission_name = (
        request.permission_name
    )

    permission.description = (
        request.description
    )

    db.commit()
    db.refresh(permission)

    return permission