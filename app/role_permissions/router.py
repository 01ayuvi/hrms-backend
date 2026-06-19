from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.auth.dependencies import get_current_user

from app.database.dependencies import get_db

from app.roles.models import Role
from app.permissions.models import Permission

from app.role_permissions.models import (
    RolePermission
)

from app.role_permissions.schemas import (
    RolePermissionCreate
)
from app.audit.utils import create_audit_log
router = APIRouter()
@router.post("/assign")
def assign_permission_to_role(
    request: RolePermissionCreate,
    db: Session = Depends(get_db),
    current_user=Depends(get_current_user)
):

    role = db.query(Role).filter(
        Role.id == request.role_id
    ).first()

    if not role:
        raise HTTPException(
            status_code=404,
            detail="Role not found"
        )

    permission = db.query(Permission).filter(
        Permission.id == request.permission_id
    ).first()

    if not permission:
        raise HTTPException(
            status_code=404,
            detail="Permission not found"
        )

    existing = db.query(RolePermission).filter(
        RolePermission.role_id == request.role_id,
        RolePermission.permission_id ==
        request.permission_id
    ).first()

    if existing:
        raise HTTPException(
            status_code=400,
            detail="Permission already assigned"
        )

    assignment = RolePermission(
        role_id=request.role_id,
        permission_id=request.permission_id
    )

    db.add(assignment)

    db.commit()

    db.refresh(assignment)
    create_audit_log(
    db=db,
    user_id=current_user.id,
    action="ASSIGN_PERMISSION",
    entity_type="RolePermission",
    entity_id=assignment.id
)

    return assignment
@router.get("/")
def get_role_permissions(
    db: Session = Depends(get_db)
):

    assignments = db.query(
        RolePermission
    ).all()

    return assignments