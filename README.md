# HRMS Backend

## Setup

1. Clone repository

git clone <repo-url>

2. Create virtual environment

python -m venv venv

3. Activate

venv\Scripts\activate

4. Install dependencies

pip install -r requirements.txt

5. Create PostgreSQL database

hrms_db

6. Run schema

database_schema/hrms_schema.sql

7. Start server

uvicorn app.main:app --reload

8. Swagger

http://127.0.0.1:8000/docs

9. Import Postman collection

postman/hrms_collection.json
