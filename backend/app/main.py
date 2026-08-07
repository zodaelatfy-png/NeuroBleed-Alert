from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core.config import settings
import logging

logger = logging.getLogger(__name__)

def create_app() -> FastAPI:
    app = FastAPI(
        title=settings.PROJECT_NAME,
        version=settings.VERSION,
        openapi_url=f"{settings.API_V1_STR}/openapi.json",
        docs_url="/api/docs",
        redoc_url="/api/redoc"
    )

    # CORS settings
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"], # Update for production
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    @app.on_event("startup")
    async def on_startup():
        logger.info("Initializing database...")
        try:
            from app.domain.database import engine, Base, AsyncSessionLocal
            from app.domain.models import User, RoleEnum
            from sqlalchemy import select
            from passlib.context import CryptContext
            
            pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

            async with engine.begin() as conn:
                await conn.run_sync(Base.metadata.create_all)

            async with AsyncSessionLocal() as session:
                # Seed SUPER_ADMIN
                result = await session.execute(select(User).filter(User.email == "medomaree11@gmail.com"))
                if not result.scalars().first():
                    logger.info("Seeding SUPER_ADMIN...")
                    new_admin = User(
                        email="medomaree11@gmail.com",
                        hashed_password=pwd_context.hash("medo2011"),
                        role=RoleEnum.SUPER_ADMIN,
                        is_active=True
                    )
                    session.add(new_admin)

                # Seed USER
                result = await session.execute(select(User).filter(User.email == "Ziad@gmail.com"))
                if not result.scalars().first():
                    logger.info("Seeding USER...")
                    new_user = User(
                        email="Ziad@gmail.com",
                        hashed_password=pwd_context.hash("ziad1111"),
                        role=RoleEnum.USER,
                        is_active=True
                    )
                    session.add(new_user)

                await session.commit()
                logger.info("Database initialized and seeded.")
        except Exception as e:
            logger.error(f"Error during startup DB initialization: {e}")

    @app.get("/health")
    async def health_check():
        return {"status": "ok", "app": settings.PROJECT_NAME}

    from app.presentation.api.v1 import auth, ai
    app.include_router(auth.router, prefix=f"{settings.API_V1_STR}/auth", tags=["Authentication"])
    app.include_router(ai.router, prefix=f"{settings.API_V1_STR}/ai", tags=["AI Intelligence"])

    return app

app = create_app()

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("app.main:app", host="0.0.0.0", port=8000, reload=True)
