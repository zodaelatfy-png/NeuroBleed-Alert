import logging
from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordRequestForm
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.future import select
from pydantic import BaseModel
from passlib.context import CryptContext
from datetime import datetime, timedelta
from jose import jwt

from app.domain.database import get_db
from app.domain.models import User
from app.core.config import settings

logger = logging.getLogger(__name__)
router = APIRouter()
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

class TokenResponse(BaseModel):
    access_token: str
    token_type: str
    role: str

def create_access_token(data: dict, expires_delta: timedelta | None = None):
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta if expires_delta else timedelta(minutes=15))
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=settings.ALGORITHM)
    return encoded_jwt

@router.post("/login", response_model=TokenResponse)
async def login(request: OAuth2PasswordRequestForm = Depends(), db: AsyncSession = Depends(get_db)):
    try:
        # Find user by email (using username field from form)
        result = await db.execute(select(User).filter(User.email == request.username))
        user = result.scalars().first()
        
        if not user:
            logger.warning(f"Login attempt failed: User {request.username} not found")
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="User not found",
            )
            
        if not pwd_context.verify(request.password, user.hashed_password):
            logger.warning(f"Login attempt failed: Incorrect password for {request.username}")
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail="Incorrect email or password",
                headers={"WWW-Authenticate": "Bearer"},
            )
            
        if not user.is_active:
            logger.warning(f"Login attempt failed: User {request.username} is inactive")
            raise HTTPException(status_code=400, detail="Inactive user")

        # Handle user.role which could be string or Enum
        role_value = user.role.value if hasattr(user.role, 'value') else str(user.role)

        # Generate JWT
        access_token_expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
        access_token = create_access_token(
            data={"sub": user.email, "role": role_value}, expires_delta=access_token_expires
        )
        
        logger.info(f"User {request.username} logged in successfully")
        
        # Return token + role (so frontend can do the hidden redirect)
        return TokenResponse(
            access_token=access_token,
            token_type="bearer",
            role=role_value
        )
    except HTTPException:
        raise
    except Exception as e:
        logger.error(f"Internal server error during login for {request.username}: {str(e)}", exc_info=True)
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail="An unexpected error occurred during login. Please try again later."
        )
