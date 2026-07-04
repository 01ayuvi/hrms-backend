# Enterprise HRMS Backend

A scalable Enterprise Human Resource Management System (HRMS) backend built with **FastAPI**, **PostgreSQL**, and **JWT Authentication**. The system provides secure role-based access control (RBAC) for managing employees, recruitment, attendance, payroll, leave management, performance, organization settings, and employee documents.

---

# Features

- JWT Authentication & Authorization
- Role-Based Access Control (RBAC)
- Employee Management
- User Management
- Recruitment Management
- Candidate Pipeline
- Attendance Management
- Leave Management
- Payroll Management
- Performance Management
- Document Management
- Organization Management
- Organization Policies
- Department Management
- Employee Profile Management
- Audit Logging
- Employee Export
- PostgreSQL Database Integration
- RESTful APIs
- Interactive Swagger API Documentation

---

# Tech Stack

- **Backend:** FastAPI
- **Database:** PostgreSQL 17
- **ORM:** SQLAlchemy
- **Authentication:** JWT
- **Validation:** Pydantic
- **API Documentation:** Swagger UI
- **Testing:** Postman

---

# Project Structure

```text
hrms-backend/
│
├── app/
│   ├── auth/
│   ├── employees/
│   ├── attendance/
│   ├── recruitment/
│   ├── performance/
│   ├── payroll/
│   ├── leave/
│   ├── documents/
│   ├── departments/
│   ├── organization/
│   ├── dashboard/
│   └── ...
│
├── postman/
├── sql/
├── uploads/
├── tests/
├── requirements.txt
├── .env.example
├── README.md
└── main.py
```

---

# Prerequisites

- Python 3.12.6
- PostgreSQL 17
- Git

---

# Installation

## Clone Repository

```bash
git clone <BACKEND_REPOSITORY_URL>
cd hrms-backend
```

---

## Create Virtual Environment

Windows

```bash
python -m venv venv
```

Activate

```bash
venv\Scripts\activate
```

---

## Install Dependencies

```bash
pip install -r requirements.txt
```

---

# Database Setup

Create a PostgreSQL database named:

```
hrms_db
```

Restore the provided database dump:

```bash
psql -U postgres -d hrms_db -f sql/hrms_db.sql
```

---

# Environment Variables

Create a `.env` file in the project root.

Example:

```env
DATABASE_URL=postgresql://postgres:your_password@localhost:5432/hrms_db
SECRET_KEY=your_secret_key
```

---

# Run the Backend

```bash
uvicorn main:app --reload
```

Backend URL

```
http://127.0.0.1:8000
```

---

# API Documentation

Swagger UI

```
http://127.0.0.1:8000/docs
```

ReDoc

```
http://127.0.0.1:8000/redoc
```

---

# Authentication

The backend uses JWT Authentication.

Workflow:

```
Login
      ↓
JWT Access Token
      ↓
Authenticated APIs
      ↓
Role-Based Authorization
```

Employee-specific modules retrieve the employee identity using the authenticated JWT token instead of trusting employee IDs supplied by the client.

---

# Demo Login

Administrator

```
Username: admin
Password: admin123
```

The Administrator account has full access to all HRMS modules.

Additional employee accounts can be created using the **Create Employee** and **Create User** modules.

---

# Included Resources

- PostgreSQL Database Dump (`sql/hrms_db.sql`)
- Postman Collection
- SQL Schema
- Swagger API Documentation

---

# Modules

- Authentication
- Dashboard
- Employees
- User Management
- Recruitment
- Attendance
- Leave Management
- Payroll
- Performance
- Documents
- Organization
- Organization Policies
- Departments

---

# Security

- JWT Authentication
- Password Hashing using BCrypt
- Role-Based Access Control
- Protected API Endpoints
- Employee Ownership Validation

---

# Author

Developed as part of an Enterprise HRMS internship project.
