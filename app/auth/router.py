from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from fastapi.security import OAuth2PasswordRequestForm

from app.auth.schemas import RegisterRequest
from app.auth.models import User
from app.auth.security import hash_password, verify_password
from app.auth.jwt_handler import (
    create_access_token,
    create_refresh_token,
    create_reset_token,
    verify_token
)
from app.auth.password_schemas import (
    ForgotPasswordRequest,
    ResetPasswordRequest
)

from app.auth.dependencies import get_current_user

from app.audit.utils import create_audit_log

from app.database.dependencies import get_db

router = APIRouter()


@router.post("/register")
def register(
    request: RegisterRequest,
    db: Session = Depends(get_db)
):

    existing_user = db.query(User).filter(
        User.username == request.username
    ).first()

    if existing_user:
        raise HTTPException(
            status_code=400,
            detail="Username already exists"
        )

    existing_email = db.query(User).filter(
        User.email == request.email
    ).first()

    if existing_email:
        raise HTTPException(
            status_code=400,
            detail="Email already exists"
        )

    hashed_password = hash_password(
        request.password
    )

    new_user = User(
        username=request.username,
        email=request.email,
        password_hash=hashed_password,
        is_active=True
    )

    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    return {
        "message": "User registered successfully",
        "user_id": new_user.id
    }


@router.post("/login")
def login(
    form_data: OAuth2PasswordRequestForm = Depends(),
    db: Session = Depends(get_db)
):

    user = db.query(User).filter(
        User.username == form_data.username
    ).first()

    if not user:
        raise HTTPException(
            status_code=401,
            detail="Invalid credentials"
        )

    if not verify_password(
        form_data.password,
        user.password_hash
    ):
        raise HTTPException(
            status_code=401,
            detail="Invalid credentials"
        )

    access_token = create_access_token(
        {"sub": user.username}
    )

    refresh_token = create_refresh_token(
        {"sub": user.username}
    )

    create_audit_log(
        db=db,
        user_id=user.id,
        action="LOGIN",
        entity_type="Authentication",
        entity_id=user.id
    )

    return {
        "access_token": access_token,
        "refresh_token": refresh_token,
        "token_type": "bearer"
    }

@router.post("/refresh")
def refresh_access_token(
    refresh_token: str
):

    username = verify_token(
        refresh_token
    )

    if not username:
        raise HTTPException(
            status_code=401,
            detail="Invalid refresh token"
        )

    new_access_token = create_access_token(
        {"sub": username}
    )

    return {
        "access_token": new_access_token,
        "token_type": "bearer"
    }
@router.post("/forgot-password")
def forgot_password(
    request: ForgotPasswordRequest,
    db: Session = Depends(get_db)
):

    user = db.query(User).filter(
        User.email == request.email
    ).first()

    if not user:
        raise HTTPException(
            status_code=404,
            detail="User not found"
        )

    reset_token = create_reset_token(
        {"sub": user.username}
    )

    return {
        "message": "Password reset token generated",
        "reset_token": reset_token
    }

@router.post("/reset-password")
def reset_password(
    request: ResetPasswordRequest,
    db: Session = Depends(get_db)
):

    username = verify_token(
        request.token
    )

    if not username:
        raise HTTPException(
            status_code=401,
            detail="Invalid or expired token"
        )

    user = db.query(User).filter(
        User.username == username
    ).first()

    if not user:
        raise HTTPException(
            status_code=404,
            detail="User not found"
        )

    user.password_hash = hash_password(
        request.new_password
    )

    db.commit()

    create_audit_log(
        db=db,
        user_id=user.id,
        action="PASSWORD_RESET",
        entity_type="Authentication",
        entity_id=user.id
    )

    return {
        "message": "Password reset successful"
    }


@router.get("/me")
def get_me(
    current_user=Depends(get_current_user)
):

    return {
        "id": current_user.id,
        "username": current_user.username,
        "email": current_user.email,
        "is_active": current_user.is_active
    }


@router.get("/whoami")
def who_am_i(
    current_user=Depends(get_current_user)
):

    return {
        "id": current_user.id,
        "username": current_user.username
    }

@router.post("/logout")
def logout(
    db: Session = Depends(get_db),
    current_user=Depends(get_current_user)
):

    create_audit_log(
        db=db,
        user_id=current_user.id,
        action="LOGOUT",
        entity_type="Authentication",
        entity_id=current_user.id
    )

    return {
        "message": "Logout successful"
    }