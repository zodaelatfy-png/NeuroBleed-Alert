import asyncio
from passlib.context import CryptContext
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession, async_sessionmaker
from app.domain.models import User, RoleEnum, Base

# Configuration (duplicate here for standalone script simplicity)
DATABASE_URL = "postgresql+asyncpg://neuro_user:neuro_password@localhost:5432/neuro_db"

engine = create_async_engine(DATABASE_URL, echo=True)
AsyncSessionLocal = async_sessionmaker(engine, class_=AsyncSession, expire_on_commit=False)
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

async def init_db():
    async with engine.begin() as conn:
        # Create all tables (in production use alembic)
        await conn.run_sync(Base.metadata.create_all)

async def seed_data():
    async with AsyncSessionLocal() as session:
        # Check if SUPER_ADMIN exists
        from sqlalchemy import select
        result = await session.execute(select(User).filter(User.email == "medomaree11@gmail.com"))
        admin = result.scalars().first()
        
        if not admin:
            print("Seeding SUPER_ADMIN...")
            new_admin = User(
                email="medomaree11@gmail.com",
                hashed_password=pwd_context.hash("medo2011"),
                role=RoleEnum.SUPER_ADMIN,
                is_active=True
            )
            session.add(new_admin)

        # Check if USER exists
        result = await session.execute(select(User).filter(User.email == "Ziad@gmail.com"))
        user = result.scalars().first()
        
        if not user:
            print("Seeding USER...")
            new_user = User(
                email="Ziad@gmail.com",
                hashed_password=pwd_context.hash("ziad1111"),
                role=RoleEnum.USER,
                is_active=True
            )
            session.add(new_user)

        await session.commit()
        print("Database seeded successfully!")

async def main():
    await init_db()
    await seed_data()

if __name__ == "__main__":
    asyncio.run(main())
