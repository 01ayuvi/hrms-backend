from pydantic import BaseModel, EmailStr

class RegisterRequest(BaseModel):
    employee_id: int
    username: str
    email: EmailStr
    password: str
    role: str


class LoginRequest(BaseModel):
    username: str
    password: str