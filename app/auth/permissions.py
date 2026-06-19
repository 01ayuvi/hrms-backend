from fastapi import Depends, HTTPException
from sqlalchemy.orm import Session

from app.database.dependencies import get_db

from app.auth.dependencies import get_current_user

from app.user_roles.models import UserRole
from app.role_permissions.models import RolePermission
from app.permissions.models import Permission


def require_permission(permission_name: str):

    def permission_checker(
        current_user=Depends(get_current_user),
        db: Session = Depends(get_db)
    ):

        user_roles = db.query(
            UserRole
        ).filter(
            UserRole.user_id == current_user.id
        ).all()

        role_ids = [
            role.role_id
            for role in user_roles
        ]

        role_permissions = db.query(
            RolePermission
        ).filter(
            RolePermission.role_id.in_(role_ids)
        ).all()

        permission_ids = [
            rp.permission_id
            for rp in role_permissions
        ]

        permissions = db.query(
            Permission
        ).filter(
            Permission.id.in_(permission_ids)
        ).all()

        permission_names = [
            p.permission_name
            for p in permissions
        ]

        if permission_name not in permission_names:
            raise HTTPException(
                status_code=403,
                detail="Permission denied"
            )

        return current_user

    return permission_checker