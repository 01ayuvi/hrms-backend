from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app.auth.dependencies import get_current_user

from app.database.dependencies import get_db

from app.auth.models import User
from app.roles.models import Role

from app.user_roles.models import UserRole
from app.user_roles.schemas import UserRoleCreate
from app.audit.utils import create_audit_log

router = APIRouter()


@router.post("/assign")
def assign_role_to_user(
    request: UserRoleCreate,
    db: Session = Depends(get_db),
    current_user=Depends(get_current_user)
):

    user = db.query(User).filter(
        User.id == request.user_id
    ).first()

    if not user:
        raise HTTPException(
            status_code=404,
            detail="User not found"
        )

    role = db.query(Role).filter(
        Role.id == request.role_id
    ).first()

    if not role:
        raise HTTPException(
            status_code=404,
            detail="Role not found"
        )

    existing = db.query(UserRole).filter(
        UserRole.user_id == request.user_id,
        UserRole.role_id == request.role_id
    ).first()

    if existing:
        raise HTTPException(
            status_code=400,
            detail="Role already assigned"
        )

    assignment = UserRole(
        user_id=request.user_id,
        role_id=request.role_id
    )

    db.add(assignment)

    db.commit()

    db.refresh(assignment)
    create_audit_log(
    db=db,
    user_id=current_user.id,
    action="ASSIGN_ROLE",
    entity_type="UserRole",
    entity_id=assignment.id
)

    return assignment


@router.get("/")
def get_user_roles(
    db: Session = Depends(get_db)
):

    assignments = db.query(
        UserRole
    ).all()

    return assignments