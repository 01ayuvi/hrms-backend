from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.auth.schemas import RegisterRequest
from app.auth.models import User
from app.auth.security import hash_password
from app.auth.schemas import LoginRequest
from app.auth.jwt_handler import create_access_token
from app.auth.security import verify_password

from app.database.dependencies import get_db

router = APIRouter()


@router.post("/register")
def register(
    request: RegisterRequest,
    db: Session = Depends(get_db)
):

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
    request: LoginRequest,
    db: Session = Depends(get_db)
):

    user = db.query(User).filter(
        User.username == request.username
    ).first()

    if not user:
        raise HTTPException(
            status_code=401,
            detail="Invalid credentials"
        )

    if not verify_password(
        request.password,
        user.password_hash
    ):
        raise HTTPException(
            status_code=401,
            detail="Invalid credentials"
        )

    access_token = create_access_token(
        {"sub": user.username}
    )

    return {
        "access_token": access_token,
        "token_type": "bearer"
    }