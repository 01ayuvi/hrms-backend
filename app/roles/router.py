from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database.dependencies import get_db
from app.auth.permissions import require_permission

from app.roles.models import Role
from app.roles.schemas import (
    RoleCreate,
    RoleUpdate
)

router = APIRouter()


@router.post("/")
def create_role(
    request: RoleCreate,
    db: Session = Depends(get_db),
    current_user=Depends(
        require_permission("manage_roles")
    )
):

    existing_role = db.query(Role).filter(
        Role.role_name == request.role_name
    ).first()

    if existing_role:
        raise HTTPException(
            status_code=400,
            detail="Role already exists"
        )

    role = Role(
        role_name=request.role_name,
        description=request.description
    )

    db.add(role)
    db.commit()
    db.refresh(role)

    return role


@router.get("/")
def get_roles(
    db: Session = Depends(get_db)
):

    roles = db.query(Role).all()

    return roles


@router.put("/{role_id}")
def update_role(
    role_id: int,
    request: RoleUpdate,
    db: Session = Depends(get_db),
    current_user=Depends(
        require_permission("manage_roles")
    )
):

    role = db.query(Role).filter(
        Role.id == role_id
    ).first()

    if not role:
        raise HTTPException(
            status_code=404,
            detail="Role not found"
        )

    role.role_name = request.role_name
    role.description = request.description

    db.commit()
    db.refresh(role)

    return role