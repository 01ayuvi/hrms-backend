from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.auth.schemas import RegisterRequest
from app.auth.models import User
from app.auth.security import hash_password

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