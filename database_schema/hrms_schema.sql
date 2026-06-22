--
-- PostgreSQL database dump
--

\restrict sRfFnjLufTQVutUgZYXbewKz4IQGxgoFQODwUnaN65YBOP03kVQX7PfSL7wYsE8

-- Dumped from database version 17.10
-- Dumped by pg_dump version 17.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.audit_logs (
    id integer NOT NULL,
    user_id integer,
    action character varying(255) NOT NULL,
    entity_type character varying(100),
    entity_id integer,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.audit_logs OWNER TO postgres;

--
-- Name: audit_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.audit_logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.audit_logs_id_seq OWNER TO postgres;

--
-- Name: audit_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.audit_logs_id_seq OWNED BY public.audit_logs.id;


--
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    id integer NOT NULL,
    organization_id integer NOT NULL,
    department_name character varying(100) NOT NULL,
    department_code character varying(20),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- Name: departments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.departments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.departments_id_seq OWNER TO postgres;

--
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.departments_id_seq OWNED BY public.departments.id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    employee_id integer NOT NULL,
    organization_id integer NOT NULL,
    department_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    phone character varying(20),
    designation character varying(100),
    joining_date date,
    status character varying(20) DEFAULT 'ACTIVE'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_employee_id_seq OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employees_employee_id_seq OWNED BY public.employees.employee_id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organizations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(100),
    phone character varying(20),
    address text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.organizations OWNER TO postgres;

--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.organizations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.organizations_id_seq OWNER TO postgres;

--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.organizations_id_seq OWNED BY public.organizations.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permissions (
    id integer NOT NULL,
    permission_name character varying(100) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.permissions OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permissions_id_seq OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    role_name character varying(100) NOT NULL,
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    id integer NOT NULL,
    user_id integer NOT NULL,
    role_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- Name: user_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_roles_id_seq OWNER TO postgres;

--
-- Name: user_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_roles_id_seq OWNED BY public.user_roles.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    employee_id integer,
    username character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash text NOT NULL,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);


--
-- Name: departments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments ALTER COLUMN id SET DEFAULT nextval('public.departments_id_seq'::regclass);


--
-- Name: employees employee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees ALTER COLUMN employee_id SET DEFAULT nextval('public.employees_employee_id_seq'::regclass);


--
-- Name: organizations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations ALTER COLUMN id SET DEFAULT nextval('public.organizations_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: user_roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles ALTER COLUMN id SET DEFAULT nextval('public.user_roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: departments departments_department_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_department_code_key UNIQUE (department_code);


--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- Name: employees employees_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_email_key UNIQUE (email);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: organizations organizations_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_email_key UNIQUE (email);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_permission_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_permission_name_key UNIQUE (permission_name);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: roles roles_role_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_role_name_key UNIQUE (role_name);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_employee_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_employee_id_key UNIQUE (employee_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: audit_logs fk_audit_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT fk_audit_user FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: departments fk_department_org; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT fk_department_org FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: employees fk_employee_department; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT fk_employee_department FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- Name: employees fk_employee_org; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT fk_employee_org FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: users fk_user_employee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk_user_employee FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: user_roles fk_userrole_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fk_userrole_role FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- Name: user_roles fk_userrole_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fk_userrole_user FOREIGN KEY (user_id) REFERENCES public.users(id);


CREATE TABLE public.attendance (
    attendance_id SERIAL PRIMARY KEY,

    employee_id INTEGER NOT NULL,

    attendance_date DATE NOT NULL,

    check_in_time TIMESTAMP,
    check_out_time TIMESTAMP,

    working_hours DECIMAL(5,2),

    attendance_status VARCHAR(20) DEFAULT 'PRESENT',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_attendance_employee
        FOREIGN KEY (employee_id)
        REFERENCES public.employees(employee_id),

    CONSTRAINT uq_attendance_employee_date
        UNIQUE (employee_id, attendance_date)
);


CREATE TABLE public.leave_requests (
    leave_id SERIAL PRIMARY KEY,

    employee_id INTEGER NOT NULL,

    leave_type VARCHAR(50) NOT NULL,

    start_date DATE NOT NULL,
    end_date DATE NOT NULL,

    total_days INTEGER,

    reason TEXT,

    status VARCHAR(20) DEFAULT 'PENDING',

    approved_by INTEGER,

    approved_at TIMESTAMP,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_leave_employee
        FOREIGN KEY (employee_id)
        REFERENCES public.employees(employee_id),

    CONSTRAINT fk_leave_approver
        FOREIGN KEY (approved_by)
        REFERENCES public.users(id),

    CONSTRAINT chk_leave_dates
        CHECK (end_date >= start_date)
);

CREATE TABLE public.payroll_runs (
    payroll_run_id SERIAL PRIMARY KEY,

    pay_period VARCHAR(20) NOT NULL,

    run_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    status VARCHAR(20) DEFAULT 'COMPLETED',

    remarks TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE public.payroll_details (
    payroll_detail_id SERIAL PRIMARY KEY,

    payroll_run_id INTEGER NOT NULL,

    employee_id INTEGER NOT NULL,

    basic_salary DECIMAL(12,2) NOT NULL DEFAULT 0,

    allowances DECIMAL(12,2) DEFAULT 0,

    deductions DECIMAL(12,2) DEFAULT 0,

    net_salary DECIMAL(12,2) NOT NULL DEFAULT 0,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_payroll_run
        FOREIGN KEY (payroll_run_id)
        REFERENCES public.payroll_runs(payroll_run_id),

    CONSTRAINT fk_payroll_employee
        FOREIGN KEY (employee_id)
        REFERENCES public.employees(employee_id)
);


--
-- PostgreSQL database dump complete
--

\unrestrict sRfFnjLufTQVutUgZYXbewKz4IQGxgoFQODwUnaN65YBOP03kVQX7PfSL7wYsE8

