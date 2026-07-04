--
-- PostgreSQL database dump
--

\restrict KHQxhUMi5l4Cym858wur0nJoi04XaC9jyMphJ6PZxcJS40GsCg9jkSCacpXNCp3

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
-- Name: attendance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.attendance (
    attendance_id integer NOT NULL,
    employee_id integer NOT NULL,
    attendance_date date NOT NULL,
    check_in_time timestamp without time zone,
    check_out_time timestamp without time zone,
    working_hours numeric(5,2),
    attendance_status character varying(20),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.attendance OWNER TO postgres;

--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.attendance_attendance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.attendance_attendance_id_seq OWNER TO postgres;

--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.attendance_attendance_id_seq OWNED BY public.attendance.attendance_id;


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
-- Name: candidates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.candidates (
    candidate_id integer NOT NULL,
    job_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(30),
    resume_path character varying(500),
    status character varying(30) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.candidates OWNER TO postgres;

--
-- Name: candidates_candidate_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.candidates_candidate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.candidates_candidate_id_seq OWNER TO postgres;

--
-- Name: candidates_candidate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.candidates_candidate_id_seq OWNED BY public.candidates.candidate_id;


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
-- Name: employee_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee_documents (
    id integer NOT NULL,
    employee_id integer NOT NULL,
    document_name character varying(255) NOT NULL,
    document_type character varying(100) NOT NULL,
    file_path text NOT NULL,
    uploaded_by integer,
    uploaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.employee_documents OWNER TO postgres;

--
-- Name: employee_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employee_documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employee_documents_id_seq OWNER TO postgres;

--
-- Name: employee_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employee_documents_id_seq OWNED BY public.employee_documents.id;


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
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    manager_id integer
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
-- Name: export_jobs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.export_jobs (
    id integer NOT NULL,
    report_type character varying(50) NOT NULL,
    file_name character varying(255),
    status character varying(20),
    created_at timestamp without time zone DEFAULT now(),
    completed_at timestamp without time zone
);


ALTER TABLE public.export_jobs OWNER TO postgres;

--
-- Name: export_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.export_jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.export_jobs_id_seq OWNER TO postgres;

--
-- Name: export_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.export_jobs_id_seq OWNED BY public.export_jobs.id;


--
-- Name: job_openings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.job_openings (
    job_id integer NOT NULL,
    title character varying(255) NOT NULL,
    department_id integer NOT NULL,
    description text,
    openings_count integer NOT NULL,
    status character varying(20) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.job_openings OWNER TO postgres;

--
-- Name: job_openings_job_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.job_openings_job_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.job_openings_job_id_seq OWNER TO postgres;

--
-- Name: job_openings_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.job_openings_job_id_seq OWNED BY public.job_openings.job_id;


--
-- Name: leave_balances; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leave_balances (
    leave_balance_id integer NOT NULL,
    employee_id integer NOT NULL,
    leave_type character varying(50) NOT NULL,
    total_leaves integer,
    used_leaves integer,
    remaining_leaves integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.leave_balances OWNER TO postgres;

--
-- Name: leave_balances_leave_balance_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.leave_balances_leave_balance_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.leave_balances_leave_balance_id_seq OWNER TO postgres;

--
-- Name: leave_balances_leave_balance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.leave_balances_leave_balance_id_seq OWNED BY public.leave_balances.leave_balance_id;


--
-- Name: leave_requests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leave_requests (
    leave_id integer NOT NULL,
    employee_id integer NOT NULL,
    leave_type character varying(50) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    reason text,
    status character varying(20),
    approved_by integer,
    lwp_days integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.leave_requests OWNER TO postgres;

--
-- Name: leave_requests_leave_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.leave_requests_leave_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.leave_requests_leave_id_seq OWNER TO postgres;

--
-- Name: leave_requests_leave_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.leave_requests_leave_id_seq OWNED BY public.leave_requests.leave_id;


--
-- Name: organization_policies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organization_policies (
    policy_id integer NOT NULL,
    organization_id integer NOT NULL,
    working_days character varying(100),
    office_start_time time without time zone,
    office_end_time time without time zone,
    late_mark_after time without time zone,
    half_day_after time without time zone,
    annual_leave_limit integer,
    casual_leave_limit integer,
    sick_leave_limit integer,
    probation_months integer,
    notice_period_days integer,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.organization_policies OWNER TO postgres;

--
-- Name: organization_policies_policy_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.organization_policies_policy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.organization_policies_policy_id_seq OWNER TO postgres;

--
-- Name: organization_policies_policy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.organization_policies_policy_id_seq OWNED BY public.organization_policies.policy_id;


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
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    company_code character varying(50),
    gst_number character varying(30),
    cin_number character varying(50),
    pan_number character varying(20),
    industry character varying(100),
    website character varying(255),
    city character varying(100),
    state character varying(100),
    country character varying(100),
    postal_code character varying(20),
    timezone character varying(100),
    employee_strength integer,
    organization_type character varying(100),
    logo_path character varying(255),
    establishment_date date,
    status character varying(20) DEFAULT 'ACTIVE'::character varying,
    hr_contact_email character varying(255)
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
-- Name: payroll_details; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payroll_details (
    payroll_detail_id integer NOT NULL,
    payroll_run_id integer NOT NULL,
    employee_id integer NOT NULL,
    basic_salary numeric(12,2) NOT NULL,
    hra numeric(12,2),
    gross_salary numeric(12,2),
    allowances numeric(12,2),
    deductions numeric(12,2),
    pf_deduction numeric(12,2),
    esic_deduction numeric(12,2),
    professional_tax numeric(12,2),
    tds numeric(12,2),
    lwp_deduction numeric(12,2),
    net_salary numeric(12,2) NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.payroll_details OWNER TO postgres;

--
-- Name: payroll_details_payroll_detail_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payroll_details_payroll_detail_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payroll_details_payroll_detail_id_seq OWNER TO postgres;

--
-- Name: payroll_details_payroll_detail_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payroll_details_payroll_detail_id_seq OWNED BY public.payroll_details.payroll_detail_id;


--
-- Name: payroll_runs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payroll_runs (
    payroll_run_id integer NOT NULL,
    pay_period character varying(20) NOT NULL,
    run_date timestamp without time zone DEFAULT now(),
    status character varying(20),
    remarks text,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.payroll_runs OWNER TO postgres;

--
-- Name: payroll_runs_payroll_run_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payroll_runs_payroll_run_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payroll_runs_payroll_run_id_seq OWNER TO postgres;

--
-- Name: payroll_runs_payroll_run_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payroll_runs_payroll_run_id_seq OWNED BY public.payroll_runs.payroll_run_id;


--
-- Name: performance_reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.performance_reviews (
    review_id integer NOT NULL,
    employee_id integer NOT NULL,
    reviewer_id integer NOT NULL,
    review_period character varying(100) NOT NULL,
    rating integer NOT NULL,
    strengths text,
    improvements text,
    goals text,
    status character varying(20) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.performance_reviews OWNER TO postgres;

--
-- Name: performance_reviews_review_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.performance_reviews_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.performance_reviews_review_id_seq OWNER TO postgres;

--
-- Name: performance_reviews_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.performance_reviews_review_id_seq OWNED BY public.performance_reviews.review_id;


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
-- Name: role_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_permissions (
    id integer NOT NULL,
    role_id integer NOT NULL,
    permission_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.role_permissions OWNER TO postgres;

--
-- Name: role_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.role_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.role_permissions_id_seq OWNER TO postgres;

--
-- Name: role_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.role_permissions_id_seq OWNED BY public.role_permissions.id;


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
-- Name: salary_structures; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salary_structures (
    salary_structure_id integer NOT NULL,
    employee_id integer NOT NULL,
    basic_salary numeric(12,2) NOT NULL,
    hra_percentage numeric(5,2),
    pf_percentage numeric(5,2),
    esic_percentage numeric(5,2),
    professional_tax numeric(12,2),
    tds numeric(12,2),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.salary_structures OWNER TO postgres;

--
-- Name: salary_structures_salary_structure_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.salary_structures_salary_structure_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.salary_structures_salary_structure_id_seq OWNER TO postgres;

--
-- Name: salary_structures_salary_structure_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.salary_structures_salary_structure_id_seq OWNED BY public.salary_structures.salary_structure_id;


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
-- Name: attendance attendance_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance ALTER COLUMN attendance_id SET DEFAULT nextval('public.attendance_attendance_id_seq'::regclass);


--
-- Name: audit_logs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs ALTER COLUMN id SET DEFAULT nextval('public.audit_logs_id_seq'::regclass);


--
-- Name: candidates candidate_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidates ALTER COLUMN candidate_id SET DEFAULT nextval('public.candidates_candidate_id_seq'::regclass);


--
-- Name: departments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments ALTER COLUMN id SET DEFAULT nextval('public.departments_id_seq'::regclass);


--
-- Name: employee_documents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_documents ALTER COLUMN id SET DEFAULT nextval('public.employee_documents_id_seq'::regclass);


--
-- Name: employees employee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees ALTER COLUMN employee_id SET DEFAULT nextval('public.employees_employee_id_seq'::regclass);


--
-- Name: export_jobs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.export_jobs ALTER COLUMN id SET DEFAULT nextval('public.export_jobs_id_seq'::regclass);


--
-- Name: job_openings job_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_openings ALTER COLUMN job_id SET DEFAULT nextval('public.job_openings_job_id_seq'::regclass);


--
-- Name: leave_balances leave_balance_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_balances ALTER COLUMN leave_balance_id SET DEFAULT nextval('public.leave_balances_leave_balance_id_seq'::regclass);


--
-- Name: leave_requests leave_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_requests ALTER COLUMN leave_id SET DEFAULT nextval('public.leave_requests_leave_id_seq'::regclass);


--
-- Name: organization_policies policy_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organization_policies ALTER COLUMN policy_id SET DEFAULT nextval('public.organization_policies_policy_id_seq'::regclass);


--
-- Name: organizations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organizations ALTER COLUMN id SET DEFAULT nextval('public.organizations_id_seq'::regclass);


--
-- Name: payroll_details payroll_detail_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payroll_details ALTER COLUMN payroll_detail_id SET DEFAULT nextval('public.payroll_details_payroll_detail_id_seq'::regclass);


--
-- Name: payroll_runs payroll_run_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payroll_runs ALTER COLUMN payroll_run_id SET DEFAULT nextval('public.payroll_runs_payroll_run_id_seq'::regclass);


--
-- Name: performance_reviews review_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.performance_reviews ALTER COLUMN review_id SET DEFAULT nextval('public.performance_reviews_review_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: role_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions ALTER COLUMN id SET DEFAULT nextval('public.role_permissions_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: salary_structures salary_structure_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salary_structures ALTER COLUMN salary_structure_id SET DEFAULT nextval('public.salary_structures_salary_structure_id_seq'::regclass);


--
-- Name: user_roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles ALTER COLUMN id SET DEFAULT nextval('public.user_roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: attendance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attendance (attendance_id, employee_id, attendance_date, check_in_time, check_out_time, working_hours, attendance_status, created_at, updated_at) FROM stdin;
2	3	2026-06-23	2026-06-23 14:07:52.923622	2026-06-23 14:09:22.267312	0.02	PRESENT	2026-06-23 14:07:52.923307	2026-06-23 14:09:22.265803
3	8	2026-06-23	2026-06-23 15:27:16.362581	2026-06-23 15:29:56.92883	0.04	PRESENT	2026-06-23 15:27:16.356415	2026-06-23 15:29:56.928214
4	8	2026-06-24	2026-06-24 14:08:26.012075	2026-06-24 14:22:34.632255	0.24	PRESENT	2026-06-24 14:08:26.02112	2026-06-24 14:22:34.634363
5	8	2026-07-01	2026-07-01 14:50:51.543055	2026-07-01 15:24:55.011478	0.57	PRESENT	2026-07-01 14:50:51.501712	2026-07-01 15:24:55.013694
6	3	2026-07-01	2026-07-01 15:26:13.778576	2026-07-01 15:26:19.869433	0.00	PRESENT	2026-07-01 15:26:13.782661	2026-07-01 15:26:19.870725
8	2	2026-07-01	2026-07-01 21:01:21.011376	2026-07-01 21:01:47.760446	0.01	PRESENT	2026-07-01 21:01:21.004049	2026-07-01 21:01:47.755665
\.


--
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audit_logs (id, user_id, action, entity_type, entity_id, "timestamp") FROM stdin;
1	1	CREATE	Employee	3	2026-06-19 00:18:10.258993
2	1	UPDATE	Employee	2	2026-06-19 00:31:31.492389
3	1	ASSIGN_ROLE	UserRole	2	2026-06-19 00:40:38.162
4	1	ASSIGN_PERMISSION	RolePermission	4	2026-06-19 00:41:38.257956
5	1	ASSIGN_ROLE	UserRole	3	2026-06-19 11:10:09.598313
6	1	CREATE	Employee	4	2026-06-19 11:12:20.530611
7	1	ASSIGN_PERMISSION	RolePermission	5	2026-06-19 16:06:00.510477
8	1	ASSIGN_PERMISSION	RolePermission	6	2026-06-19 16:06:43.546241
9	1	ASSIGN_PERMISSION	RolePermission	7	2026-06-19 16:07:01.838521
10	3	CREATE	Employee	5	2026-06-19 16:36:16.028636
11	3	UPDATE	Employee	2	2026-06-19 16:38:26.191001
12	3	ASSIGN_ROLE	UserRole	4	2026-06-19 16:41:10.163869
13	3	ASSIGN_PERMISSION	RolePermission	8	2026-06-19 16:41:33.067835
14	3	DEACTIVATE	Employee	2	2026-06-20 22:53:29.322487
15	3	LOGIN	Authentication	3	2026-06-21 23:30:32.741921
16	3	LOGIN	Authentication	3	2026-06-21 23:36:17.115307
17	3	LOGIN	Authentication	3	2026-06-21 23:45:25.471562
18	1	PASSWORD_RESET	Authentication	1	2026-06-21 23:56:48.617546
19	3	LOGIN	Authentication	3	2026-06-21 23:57:15.707575
20	3	LOGIN	Authentication	3	2026-06-22 00:47:44.364073
21	3	LOGIN	Authentication	3	2026-06-22 00:48:26.602088
22	3	UPDATE	Employee	5	2026-06-22 00:48:57.05714
23	3	UPDATE	Employee	5	2026-06-22 01:09:54.246707
24	3	LOGIN	Authentication	3	2026-06-22 01:11:31.470972
25	3	UPDATE	Employee	5	2026-06-22 01:11:48.13885
26	3	LOGIN	Authentication	3	2026-06-22 01:18:59.364693
27	3	UPDATE	Employee	5	2026-06-22 01:19:09.95367
28	3	UPDATE	Employee	5	2026-06-22 01:27:30.094388
29	3	UPDATE	Employee	5	2026-06-22 01:27:36.72743
30	3	LOGIN	Authentication	3	2026-06-22 01:47:01.080411
31	3	UPDATE	Employee	5	2026-06-22 01:47:16.507269
32	3	UPDATE	Employee	5	2026-06-22 01:48:17.856086
33	3	LOGIN	Authentication	3	2026-06-22 11:51:46.621809
34	3	LOGIN	Authentication	3	2026-06-22 11:52:03.842081
35	3	LOGIN	Authentication	3	2026-06-22 11:55:24.174656
36	3	LOGIN	Authentication	3	2026-06-22 11:56:16.66694
37	3	LOGIN	Authentication	3	2026-06-22 11:56:45.51371
38	3	LOGIN	Authentication	3	2026-06-22 12:01:50.403346
39	3	LOGIN	Authentication	3	2026-06-22 12:02:03.961802
40	3	LOGIN	Authentication	3	2026-06-22 12:02:57.623943
41	3	LOGIN	Authentication	3	2026-06-22 12:03:16.614758
42	3	LOGIN	Authentication	3	2026-06-22 12:03:57.340628
43	3	LOGIN	Authentication	3	2026-06-22 12:05:51.231589
44	3	LOGIN	Authentication	3	2026-06-22 12:06:04.239749
45	3	LOGIN	Authentication	3	2026-06-22 12:11:05.873063
46	3	LOGIN	Authentication	3	2026-06-22 12:11:21.845161
47	3	LOGIN	Authentication	3	2026-06-22 12:12:59.32738
48	3	LOGIN	Authentication	3	2026-06-22 12:13:11.824203
49	3	LOGIN	Authentication	3	2026-06-22 12:17:41.039084
50	3	LOGIN	Authentication	3	2026-06-22 12:17:54.199724
51	3	DELETE_DOCUMENT	EmployeeDocument	3	2026-06-22 12:18:01.767018
52	3	LOGIN	Authentication	3	2026-06-22 12:23:55.639103
53	3	LOGIN	Authentication	3	2026-06-22 12:24:06.791231
54	3	LOGIN	Authentication	3	2026-06-22 12:28:01.318467
55	3	LOGIN	Authentication	3	2026-06-22 12:28:13.374135
56	3	DELETE_DOCUMENT	EmployeeDocument	4	2026-06-22 12:29:25.449219
57	3	LOGIN	Authentication	3	2026-06-22 12:34:52.053939
58	3	LOGIN	Authentication	3	2026-06-22 12:35:05.868837
59	3	LOGIN	Authentication	3	2026-06-22 12:42:48.423535
60	3	LOGOUT	Authentication	3	2026-06-22 12:43:04.820531
61	3	LOGIN	Authentication	3	2026-06-22 12:52:30.219883
62	3	LOGIN	Authentication	3	2026-06-22 12:52:41.687211
63	3	LOGIN	Authentication	3	2026-06-22 15:32:17.287325
64	3	LOGIN	Authentication	3	2026-06-22 15:53:33.447965
65	3	LOGIN	Authentication	3	2026-06-22 15:53:34.465875
66	3	LOGIN	Authentication	3	2026-06-22 15:54:07.683894
67	3	LOGIN	Authentication	3	2026-06-22 16:02:33.904566
68	3	LOGIN	Authentication	3	2026-06-22 16:02:45.550299
69	3	CREATE	JobOpening	1	2026-06-22 16:04:21.187102
70	3	CREATE	Candidate	1	2026-06-22 16:04:43.57356
71	3	UPDATE	Candidate	1	2026-06-22 16:08:26.722999
72	3	LOGIN	Authentication	3	2026-06-22 16:27:18.489338
73	3	LOGIN	Authentication	3	2026-06-22 16:27:57.38527
74	3	CREATE	PerformanceReview	1	2026-06-22 16:31:09.537975
75	3	UPDATE	PerformanceReview	1	2026-06-22 16:34:06.440677
76	3	LOGIN	Authentication	3	2026-06-22 16:54:48.722877
77	3	LOGIN	Authentication	3	2026-06-22 16:56:12.713146
78	3	LOGIN	Authentication	3	2026-06-22 22:37:32.981265
79	3	LOGIN	Authentication	3	2026-06-22 22:42:52.378429
80	3	LOGIN	Authentication	3	2026-06-22 22:45:48.937112
81	3	LOGIN	Authentication	3	2026-06-22 22:46:16.24583
82	3	LOGIN	Authentication	3	2026-06-22 22:49:37.535456
83	3	LOGIN	Authentication	3	2026-06-22 23:22:53.745674
84	3	LOGIN	Authentication	3	2026-06-22 23:23:07.76791
85	3	LOGIN	Authentication	3	2026-06-22 23:26:57.684864
86	3	LOGIN	Authentication	3	2026-06-22 23:27:33.388203
87	3	LOGIN	Authentication	3	2026-06-23 10:02:54.652345
88	3	LOGIN	Authentication	3	2026-06-23 10:40:10.647326
89	3	CREATE	Employee	6	2026-06-23 10:58:23.303441
90	3	CREATE	Employee	7	2026-06-23 11:01:17.536944
91	3	CREATE	Employee	8	2026-06-23 11:03:28.833202
92	3	CREATE	Employee	9	2026-06-23 11:05:52.001809
93	3	UPDATE	Employee	8	2026-06-23 11:14:16.089499
94	3	UPDATE	Employee	8	2026-06-23 11:19:00.515603
95	3	DEACTIVATE	Employee	8	2026-06-23 11:19:51.071429
96	3	CREATE	JobOpening	2	2026-06-23 11:34:22.8411
97	3	CREATE	PerformanceReview	2	2026-06-23 11:40:02.293208
98	3	LOGIN	Authentication	3	2026-06-23 11:46:42.571078
99	3	CREATE	Candidate	2	2026-06-23 11:46:51.714811
100	3	UPDATE	Candidate	2	2026-06-23 11:54:16.739036
101	3	UPDATE	Candidate	2	2026-06-23 11:54:35.894678
102	3	UPDATE	PerformanceReview	1	2026-06-23 12:03:48.823535
103	3	UPDATE	Employee	8	2026-06-23 12:10:58.880234
104	3	CREATE	Employee	10	2026-06-23 12:13:25.535082
105	3	CREATE	Candidate	3	2026-06-23 12:25:00.156465
106	3	LOGIN	Authentication	3	2026-06-23 12:55:20.08374
107	3	CREATE	JobOpening	3	2026-06-23 12:55:30.141014
108	3	CREATE	Candidate	4	2026-06-23 12:55:47.916445
109	3	CREATE	PerformanceReview	3	2026-06-23 12:56:00.309496
110	3	LOGIN	Authentication	3	2026-06-23 13:37:17.199503
111	3	LOGIN	Authentication	3	2026-06-23 13:37:29.389377
112	3	LOGIN	Authentication	3	2026-06-23 13:51:11.584419
113	3	LOGIN	Authentication	3	2026-06-23 13:51:23.721069
114	3	LOGIN	Authentication	3	2026-06-23 15:47:49.225829
115	3	LOGIN	Authentication	3	2026-06-23 17:16:17.188137
116	3	LOGIN	Authentication	3	2026-06-24 10:46:09.256736
117	3	LOGIN	Authentication	3	2026-06-24 10:52:07.510382
118	3	LOGIN	Authentication	3	2026-06-24 10:52:24.866088
119	3	LOGIN	Authentication	3	2026-06-24 10:53:42.297384
120	3	LOGIN	Authentication	3	2026-06-24 11:04:28.971085
121	3	LOGIN	Authentication	3	2026-06-24 11:08:50.501146
122	3	LOGIN	Authentication	3	2026-06-24 11:13:25.298589
123	3	LOGIN	Authentication	3	2026-06-24 11:43:56.104726
124	3	CREATE	Employee	11	2026-06-24 12:15:02.47003
125	3	LOGIN	Authentication	3	2026-06-24 12:30:11.512447
126	3	UPDATE	Employee	3	2026-06-24 12:30:25.341176
127	3	UPDATE	Employee	3	2026-06-24 12:30:52.371145
128	3	LOGIN	Authentication	3	2026-06-24 12:33:02.479964
129	3	UPDATE	Employee	10	2026-06-24 12:41:05.951413
130	3	CREATE	Employee	12	2026-06-24 12:42:25.210577
131	3	UPDATE	Employee	10	2026-06-24 12:43:34.090408
132	3	UPDATE	Employee	10	2026-06-24 12:52:21.190325
133	3	LOGIN	Authentication	3	2026-06-24 12:53:51.54647
134	3	UPDATE	Employee	10	2026-06-24 12:55:11.966462
135	3	CREATE	Employee	13	2026-06-24 12:55:34.766731
136	3	UPDATE	Employee	10	2026-06-24 12:55:40.173662
137	3	LOGIN	Authentication	3	2026-06-24 13:09:42.159842
138	3	CREATE	JobOpening	4	2026-06-24 13:11:36.027201
139	3	CREATE	JobOpening	5	2026-06-24 13:15:32.057067
140	3	CREATE	Candidate	5	2026-06-24 13:23:15.55248
141	3	CREATE	Candidate	6	2026-06-24 13:28:50.6972
142	3	LOGIN	Authentication	3	2026-06-24 13:28:56.856524
143	3	UPDATE	Candidate	2	2026-06-24 13:40:51.29263
144	3	UPDATE	Candidate	4	2026-06-24 13:48:52.566899
145	3	LOGIN	Authentication	3	2026-06-24 14:17:56.393251
146	3	LOGIN	Authentication	3	2026-06-24 14:31:39.272391
147	3	LOGIN	Authentication	3	2026-06-24 14:39:01.615325
148	3	LOGIN	Authentication	3	2026-06-24 15:23:10.067033
149	3	LOGIN	Authentication	3	2026-06-24 15:33:47.705193
150	3	LOGIN	Authentication	3	2026-06-24 16:45:06.091528
151	3	LOGIN	Authentication	3	2026-06-24 16:53:01.448059
152	3	UPDATE	Candidate	5	2026-06-24 16:56:11.560113
153	3	UPDATE	Candidate	3	2026-06-24 16:56:22.441375
154	3	LOGIN	Authentication	3	2026-06-24 21:50:52.44546
155	3	LOGIN	Authentication	3	2026-06-29 12:26:35.656774
156	3	LOGIN	Authentication	3	2026-06-29 12:38:48.615906
157	3	LOGIN	Authentication	3	2026-06-29 12:45:55.373
158	3	LOGIN	Authentication	3	2026-06-29 12:49:12.421555
159	3	LOGIN	Authentication	3	2026-06-29 13:13:55.553654
160	3	LOGIN	Authentication	3	2026-06-29 13:17:36.34433
161	3	LOGIN	Authentication	3	2026-06-29 13:32:56.854262
162	3	LOGIN	Authentication	3	2026-06-29 13:42:23.907899
163	3	LOGIN	Authentication	3	2026-06-29 13:53:08.771233
164	3	LOGIN	Authentication	3	2026-06-29 13:54:26.220858
165	3	LOGIN	Authentication	3	2026-06-29 14:33:06.414633
166	3	LOGIN	Authentication	3	2026-06-29 14:40:26.415895
167	3	LOGIN	Authentication	3	2026-06-29 14:42:14.087788
168	3	LOGIN	Authentication	3	2026-06-29 15:26:35.169937
169	3	LOGIN	Authentication	3	2026-06-29 15:30:20.915282
170	3	LOGIN	Authentication	3	2026-06-29 15:34:15.174737
171	3	LOGIN	Authentication	3	2026-06-29 15:38:46.092317
172	3	LOGIN	Authentication	3	2026-06-29 15:44:25.646783
173	3	LOGIN	Authentication	3	2026-06-29 15:46:27.214122
174	3	LOGIN	Authentication	3	2026-06-29 15:48:32.566077
175	3	LOGIN	Authentication	3	2026-06-29 15:52:40.475735
176	3	LOGIN	Authentication	3	2026-06-29 16:23:50.30644
177	3	LOGIN	Authentication	3	2026-06-29 16:30:39.549255
178	3	LOGIN	Authentication	3	2026-06-29 22:02:27.755229
179	3	LOGIN	Authentication	3	2026-06-30 10:35:39.588636
180	3	LOGIN	Authentication	3	2026-06-30 10:48:44.586619
181	3	LOGIN	Authentication	3	2026-06-30 11:52:58.717332
182	3	LOGIN	Authentication	3	2026-06-30 11:58:14.585458
183	3	LOGIN	Authentication	3	2026-07-01 14:56:47.242263
184	3	LOGIN	Authentication	3	2026-07-01 20:03:09.313777
185	3	LOGIN	Authentication	3	2026-07-01 20:13:50.720266
186	4	LOGIN	Authentication	4	2026-07-01 20:20:30.263205
187	3	LOGIN	Authentication	3	2026-07-01 20:23:14.904074
188	4	LOGIN	Authentication	4	2026-07-01 20:46:45.084346
189	3	LOGIN	Authentication	3	2026-07-01 20:59:52.901684
190	4	LOGIN	Authentication	4	2026-07-01 21:00:01.650351
191	3	LOGIN	Authentication	3	2026-07-01 21:00:43.131795
192	4	LOGIN	Authentication	4	2026-07-01 21:01:15.757488
193	3	LOGIN	Authentication	3	2026-07-01 21:01:58.6895
194	3	LOGIN	Authentication	3	2026-07-01 21:24:01.199916
195	5	LOGIN	Authentication	5	2026-07-01 21:29:50.168567
\.


--
-- Data for Name: candidates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.candidates (candidate_id, job_id, first_name, last_name, email, phone, resume_path, status, created_at, updated_at) FROM stdin;
1	1	John	Doe	john@example.com	9876543210	uploads/john.pdf	INTERVIEW	2026-06-22 16:04:43.488484+05:30	2026-06-22 16:08:26.659843+05:30
2	2	Rahul	Sharma	rahul.sharma@gmail.com	9876543210	uploads/resumes/rahul_sharma.pdf	APPLIED	2026-06-23 11:46:51.687907+05:30	2026-06-23 11:54:35.874943+05:30
6	2	Rahul	Sharma	rahul.sharma@gmail.com	9876543210	uploads/resumes/rahul_sharma.pdf	APPLIED	2026-06-24 13:28:50.638196+05:30	2026-06-24 13:28:50.638196+05:30
4	2	Rahul	Sharma	rahul.sharma@gmail.com	9876543210	uploads/resumes/rahul_sharma.pdf	SCREENING	2026-06-23 12:55:47.882841+05:30	2026-06-24 13:48:52.509505+05:30
5	2	Rahul	Sharma	rahul.sharma@gmail.com	9876543210	uploads/resumes/rahul_sharma.pdf	SCREENING	2026-06-24 13:23:15.478723+05:30	2026-06-24 16:56:11.493803+05:30
3	2	Rahul	Sharma	rahul.sharma@gmail.com	9876543210	uploads/resumes/rahul_sharma.pdf	REJECTED	2026-06-23 12:25:00.144762+05:30	2026-06-24 16:56:22.384932+05:30
\.


--
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departments (id, organization_id, department_name, department_code, created_at, updated_at) FROM stdin;
3	1	Finance	FIN	2026-06-19 16:14:02.720396	2026-06-19 16:14:02.720396
1	1	Engineering Updated	ENGU	2026-06-18 15:57:27.998074	2026-06-19 16:15:12.279125
4	1	Human Resources	HR	2026-06-30 11:22:18.637023	2026-06-30 11:22:18.637023
5	1	Marketing	MKT	2026-06-30 11:22:28.472651	2026-06-30 11:22:28.472651
6	1	Quality Assurance	QA	2026-06-30 11:42:59.350378	2026-06-30 11:42:59.350378
2	1	People Operations	PO	2026-06-18 21:51:25.299046	2026-06-30 11:53:27.26915
8	1	People Operations Updated	QA2	2026-06-30 11:55:57.970909	2026-06-30 11:56:30.353238
\.


--
-- Data for Name: employee_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee_documents (id, employee_id, document_name, document_type, file_path, uploaded_by, uploaded_at, created_at) FROM stdin;
5	3	Resume  (1).pdf	RESUME	uploads/employee_documents\\3_Resume  (1).pdf	3	2026-06-22 12:35:28.082234	2026-06-22 12:35:28.082234
6	3	Resume  (1).pdf	RESUME	uploads/employee_documents\\3_Resume  (1).pdf	3	2026-06-22 16:54:56.409881	2026-06-22 16:54:56.409881
7	3	Resume  (1).pdf	RESUME	uploads/employee_documents\\3_Resume  (1).pdf	3	2026-06-22 16:56:22.958139	2026-06-22 16:56:22.958139
8	3	Resume  (1).pdf	RESUME	uploads/employee_documents\\3_Resume  (1).pdf	3	2026-06-22 23:23:15.989662	2026-06-22 23:23:15.989662
9	3	Resume  (1).pdf	RESUME	uploads/employee_documents\\3_Resume  (1).pdf	3	2026-06-22 23:38:29.851476	2026-06-22 23:38:29.851476
10	3	Resume  (1).pdf	contract	uploads/employee_documents\\3_Resume  (1).pdf	3	2026-06-23 10:45:00.047658	2026-06-23 10:45:00.047658
11	3	Resume  (1).pdf	contract	uploads/employee_documents\\3_Resume  (1).pdf	3	2026-06-24 14:34:13.352552	2026-06-24 14:34:13.352552
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employees (employee_id, organization_id, department_id, first_name, last_name, email, phone, designation, joining_date, status, created_at, updated_at, manager_id) FROM stdin;
4	1	1	RBAC	Success	rbacsuccess@test.com	9999999999	Developer	2026-06-19	ACTIVE	2026-06-19 11:12:20.440605	2026-06-19 11:12:20.440605	\N
2	1	1	Ayuvi	Chaudhary	ayuvi.hrms@test.com	8888888888	Lead Engineer	2026-06-18	INACTIVE	2026-06-18 15:58:06.913456	2026-06-20 22:53:29.222871	\N
5	1	1	Audit	Create	auditcreate@test.com	9999999999	Developer	2026-06-19	ACTIVE	2026-06-19 16:36:15.930735	2026-06-22 01:47:16.423691	2
6	1	1	Demo	Employee	demo.employee@hrms.com	9999999999	Software Engineer	2026-06-23	ACTIVE	2026-06-23 10:58:23.243585	2026-06-23 10:58:23.243585	\N
7	1	1	Demo	Employee	demo23jun2026@hrms.com	9999999999	Software Engineer	2026-06-23	ACTIVE	2026-06-23 11:01:17.483368	2026-06-23 11:01:17.483368	\N
9	1	1	Rohan	Verma	rohan23.verma@company.com	9876543215	Backend Developer	2026-06-23	ACTIVE	2026-06-23 11:05:51.934165	2026-06-23 11:05:51.934165	\N
8	1	1	Rohan	Verma	rohan.verma@company.com	8888888888	Senior Software Engineer	2026-06-23	ACTIVE	2026-06-23 11:03:28.778157	2026-06-23 12:10:58.856084	2
11	1	1	Demo	User	demo.user@company.com	9999999999	Software Engineer	2026-06-24	ACTIVE	2026-06-24 12:15:02.418317	2026-06-24 12:15:02.418317	\N
3	1	1	Rohan	Verma	rohan.verma.updated@company.com	8888888888	Senior Software Engineer	2026-06-19	ACTIVE	2026-06-19 00:18:10.193539	2026-06-24 12:30:25.281849	2
10	1	1	Rohan	Verma	rohan.verma.demo1@company.com	9876543210	Senior Backend Developer	2026-06-23	ACTIVE	2026-06-23 12:13:25.512918	2026-06-24 12:41:05.890336	2
12	1	1	Test	User	test.user@company.com	9999999999	Software Engineer	2026-06-24	ACTIVE	2026-06-24 12:42:25.152966	2026-06-24 12:42:25.152966	\N
13	1	1	Rohan	Verma	rohan.verma.5@company.com	9876543210	Backend Developer	2026-06-23	ACTIVE	2026-06-24 12:55:34.744277	2026-06-24 12:55:34.744277	\N
\.


--
-- Data for Name: export_jobs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.export_jobs (id, report_type, file_name, status, created_at, completed_at) FROM stdin;
1	EMPLOYEE	exports/employees_export_1.xlsx	COMPLETED	2026-06-21 00:02:00.510163	2026-06-20 18:32:00.559911
2	EMPLOYEE	exports/employees_export_2.xlsx	COMPLETED	2026-06-21 00:02:22.798128	2026-06-20 18:32:22.845262
3	EMPLOYEE	exports/employees_export_3.xlsx	COMPLETED	2026-06-22 23:44:33.411051	2026-06-22 18:14:33.421595
4	EMPLOYEE	exports/employees_export_4.xlsx	COMPLETED	2026-06-23 10:42:57.007498	2026-06-23 05:12:57.051539
5	EMPLOYEE	exports/employees_export_5.xlsx	COMPLETED	2026-06-23 10:54:17.706396	2026-06-23 05:24:17.752167
6	EMPLOYEE	exports/employees_export_6.xlsx	COMPLETED	2026-06-24 14:34:22.916623	2026-06-24 09:04:22.973285
\.


--
-- Data for Name: job_openings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_openings (job_id, title, department_id, description, openings_count, status, created_at, updated_at) FROM stdin;
1	Backend Developer	1	FastAPI Developer	2	OPEN	2026-06-22 16:04:21.139805+05:30	2026-06-22 16:04:21.139805+05:30
2	Senior Backend Developer	1	FastAPI and PostgreSQL Developer	2	OPEN	2026-06-23 11:34:22.774699+05:30	2026-06-23 11:34:22.774699+05:30
3	Senior Backend Developer	1	FastAPI and PostgreSQL Developer	2	OPEN	2026-06-23 12:55:30.096644+05:30	2026-06-23 12:55:30.096644+05:30
4	Senior Backend Developer	1	FastAPI and PostgreSQL Developer	2	OPEN	2026-06-24 13:11:35.962094+05:30	2026-06-24 13:11:35.962094+05:30
5	Frontend React Developer	1	React+Vite+AxiosDeveloper	3	OPEN	2026-06-24 13:15:32.038804+05:30	2026-06-24 13:15:32.038804+05:30
\.


--
-- Data for Name: leave_balances; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.leave_balances (leave_balance_id, employee_id, leave_type, total_leaves, used_leaves, remaining_leaves, created_at, updated_at) FROM stdin;
1	3	CASUAL	12	12	0	2026-06-23 14:12:51.538791	2026-06-24 14:23:52.775872
2	8	ANNUAL	20	12	8	2026-06-23 15:55:52.725807	2026-07-01 21:06:22.156224
\.


--
-- Data for Name: leave_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.leave_requests (leave_id, employee_id, leave_type, start_date, end_date, reason, status, approved_by, lwp_days, created_at, updated_at) FROM stdin;
3	8	ANNUAL	2026-07-01	2026-07-03	Family Event	APPROVED	0	0	2026-06-24 14:23:29.879652	2026-06-24 16:47:57.775871
1	3	CASUAL	2026-06-25	2026-06-27	Personal work	APPROVED	0	3	2026-06-23 14:14:09.337793	2026-07-01 15:47:37.047031
2	8	ANNUAL	2026-07-01	2026-07-03	Family Event	REJECTED	0	0	2026-06-23 15:45:48.856588	2026-07-01 21:06:26.616125
\.


--
-- Data for Name: organization_policies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organization_policies (policy_id, organization_id, working_days, office_start_time, office_end_time, late_mark_after, half_day_after, annual_leave_limit, casual_leave_limit, sick_leave_limit, probation_months, notice_period_days, created_at, updated_at) FROM stdin;
2	1	MONDAY-FRIDAY	09:00:00	18:00:00	09:15:00	11:00:00	24	12	12	6	90	2026-06-24 15:53:05.27398	2026-06-24 15:53:05.27398
1	1	MONDAY-FRIDAY	09:00:00	18:00:00	09:15:00	11:00:00	30	12	12	6	90	2026-06-24 15:40:41.510376	2026-06-30 10:40:04.752916
\.


--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organizations (id, name, email, phone, address, created_at, updated_at, company_code, gst_number, cin_number, pan_number, industry, website, city, state, country, postal_code, timezone, employee_strength, organization_type, logo_path, establishment_date, status, hr_contact_email) FROM stdin;
1	Nova Manufacturing Ltd	contact@apexinnovations.com	9123456789	Hinjewadi Phase 2, Pune	2026-06-18 15:55:04.141145	2026-06-18 15:55:04.141145	APIX001	27AAPCA1234K1Z9	U72900MH2025PTC456789	AAPCA1234K	Manufacturing	https://www.apexinnovations.com	Chennai	Tamil Nadu	India	411001	Asia/Kolkata	3199	Public Limited Company	uploads/organization/company_logo.jpg	2021-01-01	ACTIVE	hr@novamanufacturing.com
\.


--
-- Data for Name: payroll_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payroll_details (payroll_detail_id, payroll_run_id, employee_id, basic_salary, hra, gross_salary, allowances, deductions, pf_deduction, esic_deduction, professional_tax, tds, lwp_deduction, net_salary, created_at, updated_at) FROM stdin;
1	1	3	50000.00	20000.00	70000.00	0.00	7575.00	6000.00	375.00	200.00	1000.00	0.00	62425.00	2026-06-23 14:32:33.091214	2026-06-23 14:32:33.091214
2	1	3	50000.00	20000.00	70000.00	0.00	7575.00	6000.00	375.00	200.00	1000.00	0.00	62425.00	2026-06-23 14:34:23.447902	2026-06-23 14:34:23.447902
\.


--
-- Data for Name: payroll_runs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payroll_runs (payroll_run_id, pay_period, run_date, status, remarks, created_at, updated_at) FROM stdin;
1	JUNE-2026	2026-06-23 14:21:56.747775	COMPLETED	Monthly payroll	2026-06-23 14:21:56.747775	2026-06-23 14:21:56.747775
2	2026-06	2026-06-23 16:02:22.568316	COMPLETED	June Payroll Run	2026-06-23 16:02:22.568316	2026-06-23 16:02:22.568316
\.


--
-- Data for Name: performance_reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.performance_reviews (review_id, employee_id, reviewer_id, review_period, rating, strengths, improvements, goals, status, created_at, updated_at) FROM stdin;
2	8	1	Q2-2026	4	Good technical skills	Leadership and communication	Become Senior Engineer	DRAFT	2026-06-23 11:40:02.278452+05:30	2026-06-23 11:40:02.278452+05:30
1	4	1	Q2-2026	5	Excellent ownership and backend skills	Public speaking	Lead backend team	DRAFT	2026-06-22 16:31:09.47157+05:30	2026-06-23 12:03:48.801312+05:30
3	8	1	Q2-2026	4	Good technical skills	Leadership and communication	Become Senior Engineer	DRAFT	2026-06-23 12:56:00.26715+05:30	2026-06-23 12:56:00.26715+05:30
\.


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, permission_name, description, created_at, updated_at) FROM stdin;
1	create_employee	Can create employee	2026-06-17 16:34:10.63196	2026-06-17 16:34:10.63196
2	update_employee	Can update employee	2026-06-17 16:34:10.63196	2026-06-17 16:34:10.63196
3	delete_employee	Can delete employee	2026-06-17 16:34:10.63196	2026-06-17 16:34:10.63196
4	view_employee	Can view employee	2026-06-17 16:34:10.63196	2026-06-17 16:34:10.63196
5	approve_leave	Can approve leave	2026-06-17 16:34:10.63196	2026-06-17 16:34:10.63196
6	run_payroll	Can process payroll	2026-06-17 16:34:10.63196	2026-06-17 16:34:10.63196
7	manage_roles	Manage HRMS roles and assignments	2026-06-18 23:43:29.534449	2026-06-18 23:47:07.396306
8	create_department	Can create departments	2026-06-19 16:02:43.985706	2026-06-19 16:02:43.985706
9	update_department	Can update departments	2026-06-19 16:03:51.112417	2026-06-19 16:03:51.112417
10	manage_permissions	Can manage permissions	2026-06-19 16:04:04.669467	2026-06-19 16:04:04.669467
11	test_phase12	Phase 12 verification	2026-06-19 16:10:39.634245	2026-06-19 16:10:39.634245
12	phase12_final_test	RBAC verification	2026-06-19 16:17:09.865742	2026-06-19 16:17:09.865742
13	create_job_opening	Create job openings	2026-06-22 15:55:20.355178	2026-06-22 15:55:20.355178
15	view_job_openings	View Job Openings	2026-06-22 15:59:47.413645	2026-06-22 15:59:47.413645
16	create_candidate	Create Candidate	2026-06-22 15:59:47.413645	2026-06-22 15:59:47.413645
17	view_candidates	View Candidates	2026-06-22 15:59:47.413645	2026-06-22 15:59:47.413645
18	update_candidate_status	Update Candidate Status	2026-06-22 15:59:47.413645	2026-06-22 15:59:47.413645
20	create_performance_review	Create performance reviews	2026-06-22 16:17:42.368955	2026-06-22 16:17:42.368955
21	view_performance_reviews	View performance reviews	2026-06-22 16:17:42.368955	2026-06-22 16:17:42.368955
22	update_performance_review	Update performance reviews	2026-06-22 16:17:42.368955	2026-06-22 16:17:42.368955
\.


--
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permissions (id, role_id, permission_id, created_at) FROM stdin;
1	6	1	2026-06-19 00:02:33.26615
2	6	2	2026-06-19 00:03:04.974799
3	6	7	2026-06-19 00:03:13.386094
4	6	3	2026-06-19 00:41:38.220859
5	6	8	2026-06-19 16:06:00.449361
6	6	9	2026-06-19 16:06:43.537385
7	6	10	2026-06-19 16:07:01.78931
8	4	4	2026-06-19 16:41:33.011919
9	6	13	2026-06-22 15:59:35.10188
14	6	13	2026-06-22 16:01:55.341986
15	6	15	2026-06-22 16:01:55.341986
16	6	16	2026-06-22 16:01:55.341986
17	6	17	2026-06-22 16:01:55.341986
18	6	18	2026-06-22 16:01:55.341986
19	6	20	2026-06-22 16:17:51.810874
20	6	21	2026-06-22 16:17:51.810874
21	6	22	2026-06-22 16:17:51.810874
22	6	20	2026-06-22 16:23:55.138034
23	6	21	2026-06-22 16:23:55.138034
24	6	22	2026-06-22 16:23:55.138034
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, role_name, description, created_at, updated_at) FROM stdin;
1	Admin	System Administrator	2026-06-17 16:33:55.001244	2026-06-17 16:33:55.001244
2	HR Manager	Human Resources Manager	2026-06-17 16:33:55.001244	2026-06-17 16:33:55.001244
3	Employee	Regular Employee	2026-06-17 16:33:55.001244	2026-06-17 16:33:55.001244
4	Recruiter	Recruitment Team	2026-06-17 16:33:55.001244	2026-06-17 16:33:55.001244
5	Payroll Manager	Payroll Processing	2026-06-17 16:33:55.001244	2026-06-17 16:33:55.001244
6	HR_ADMIN	Human Resources Administrator	2026-06-18 22:23:38.506991	2026-06-18 22:37:02.286175
\.


--
-- Data for Name: salary_structures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.salary_structures (salary_structure_id, employee_id, basic_salary, hra_percentage, pf_percentage, esic_percentage, professional_tax, tds, created_at, updated_at) FROM stdin;
1	3	50000.00	40.00	12.00	0.75	200.00	1000.00	2026-06-23 14:21:24.453428	2026-06-23 14:21:24.453428
2	8	50000.00	40.00	12.00	0.75	200.00	0.00	2026-06-23 16:17:05.784161	2026-06-23 16:17:05.784161
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (id, user_id, role_id, created_at) FROM stdin;
1	1	6	2026-06-19 00:10:27.742912
2	2	4	2026-06-19 00:40:38.094168
3	3	6	2026-06-19 11:10:09.526223
4	3	4	2026-06-19 16:41:10.102096
5	4	3	2026-07-01 20:19:16.890571
6	5	1	2026-07-01 21:29:35.267917
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, employee_id, username, email, password_hash, is_active, created_at, updated_at) FROM stdin;
2	\N	ayuvi2	ayuvi2@test.com	$2b$12$FgWcbNWpLkbSssssDy49GO426EqeGkf62jmtV1cIlA8Pe/MuotKpC	t	2026-06-18 15:19:51.204284	2026-06-18 15:19:51.204284
3	\N	rbacuser	rbacuser@test.com	$2b$12$eCDPMpfWVARTIeNP9HA0yOzEbKPwW3gMBuyA1uaDIWUIpyYBOifNW	t	2026-06-19 10:41:29.284149	2026-06-19 10:41:29.284149
1	\N	ayuvi	ayuvi@test.com	$2b$12$GohZphjLkbUQ5KLa3aClHezVLVW2IwH5R8qDBUJt8i.A1wfvoEq4q	t	2026-06-18 11:45:26.674477	2026-06-18 11:45:26.674477
4	2	@ayuvi	ayuvi.hrms@test.com	$2b$12$60y1T387A43VNEViUFt7QuLszAV27CjIWMHyQQl1i.ww/UirIQYfa	t	\N	\N
5	10	admin	rohan.verma.demo1@company.com	$2b$12$FbvAtPs8E6WeA.tISCBGJOgEVJyknQULUz2BsJ9/7S7.9Y6Zwg3WS	t	\N	\N
\.


--
-- Name: attendance_attendance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attendance_attendance_id_seq', 10, true);


--
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.audit_logs_id_seq', 195, true);


--
-- Name: candidates_candidate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.candidates_candidate_id_seq', 6, true);


--
-- Name: departments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departments_id_seq', 8, true);


--
-- Name: employee_documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employee_documents_id_seq', 11, true);


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employees_employee_id_seq', 13, true);


--
-- Name: export_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.export_jobs_id_seq', 6, true);


--
-- Name: job_openings_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.job_openings_job_id_seq', 5, true);


--
-- Name: leave_balances_leave_balance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.leave_balances_leave_balance_id_seq', 2, true);


--
-- Name: leave_requests_leave_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.leave_requests_leave_id_seq', 3, true);


--
-- Name: organization_policies_policy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.organization_policies_policy_id_seq', 2, true);


--
-- Name: organizations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.organizations_id_seq', 2, true);


--
-- Name: payroll_details_payroll_detail_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payroll_details_payroll_detail_id_seq', 2, true);


--
-- Name: payroll_runs_payroll_run_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payroll_runs_payroll_run_id_seq', 2, true);


--
-- Name: performance_reviews_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.performance_reviews_review_id_seq', 3, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_seq', 24, true);


--
-- Name: role_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_permissions_id_seq', 24, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 6, true);


--
-- Name: salary_structures_salary_structure_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.salary_structures_salary_structure_id_seq', 2, true);


--
-- Name: user_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_roles_id_seq', 6, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: attendance attendance_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_pkey PRIMARY KEY (attendance_id);


--
-- Name: audit_logs audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_logs
    ADD CONSTRAINT audit_logs_pkey PRIMARY KEY (id);


--
-- Name: candidates candidates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidates
    ADD CONSTRAINT candidates_pkey PRIMARY KEY (candidate_id);


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
-- Name: employee_documents employee_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_documents
    ADD CONSTRAINT employee_documents_pkey PRIMARY KEY (id);


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
-- Name: export_jobs export_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.export_jobs
    ADD CONSTRAINT export_jobs_pkey PRIMARY KEY (id);


--
-- Name: job_openings job_openings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_openings
    ADD CONSTRAINT job_openings_pkey PRIMARY KEY (job_id);


--
-- Name: leave_balances leave_balances_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_balances
    ADD CONSTRAINT leave_balances_pkey PRIMARY KEY (leave_balance_id);


--
-- Name: leave_requests leave_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_requests
    ADD CONSTRAINT leave_requests_pkey PRIMARY KEY (leave_id);


--
-- Name: organization_policies organization_policies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organization_policies
    ADD CONSTRAINT organization_policies_pkey PRIMARY KEY (policy_id);


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
-- Name: payroll_details payroll_details_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payroll_details
    ADD CONSTRAINT payroll_details_pkey PRIMARY KEY (payroll_detail_id);


--
-- Name: payroll_runs payroll_runs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payroll_runs
    ADD CONSTRAINT payroll_runs_pkey PRIMARY KEY (payroll_run_id);


--
-- Name: performance_reviews performance_reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.performance_reviews
    ADD CONSTRAINT performance_reviews_pkey PRIMARY KEY (review_id);


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
-- Name: role_permissions role_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT role_permissions_pkey PRIMARY KEY (id);


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
-- Name: salary_structures salary_structures_employee_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salary_structures
    ADD CONSTRAINT salary_structures_employee_id_key UNIQUE (employee_id);


--
-- Name: salary_structures salary_structures_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salary_structures
    ADD CONSTRAINT salary_structures_pkey PRIMARY KEY (salary_structure_id);


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
-- Name: idx_candidates_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_candidates_email ON public.candidates USING btree (email);


--
-- Name: idx_candidates_job; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_candidates_job ON public.candidates USING btree (job_id);


--
-- Name: idx_candidates_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_candidates_status ON public.candidates USING btree (status);


--
-- Name: idx_employee_documents_employee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_employee_documents_employee ON public.employee_documents USING btree (employee_id);


--
-- Name: idx_employee_documents_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_employee_documents_type ON public.employee_documents USING btree (document_type);


--
-- Name: idx_job_openings_department; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_job_openings_department ON public.job_openings USING btree (department_id);


--
-- Name: idx_review_employee; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_review_employee ON public.performance_reviews USING btree (employee_id);


--
-- Name: idx_review_reviewer; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_review_reviewer ON public.performance_reviews USING btree (reviewer_id);


--
-- Name: idx_review_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_review_status ON public.performance_reviews USING btree (status);


--
-- Name: ix_attendance_attendance_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_attendance_attendance_id ON public.attendance USING btree (attendance_id);


--
-- Name: ix_candidates_candidate_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_candidates_candidate_id ON public.candidates USING btree (candidate_id);


--
-- Name: ix_export_jobs_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_export_jobs_id ON public.export_jobs USING btree (id);


--
-- Name: ix_job_openings_job_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_job_openings_job_id ON public.job_openings USING btree (job_id);


--
-- Name: ix_leave_balances_leave_balance_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_leave_balances_leave_balance_id ON public.leave_balances USING btree (leave_balance_id);


--
-- Name: ix_leave_requests_leave_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_leave_requests_leave_id ON public.leave_requests USING btree (leave_id);


--
-- Name: ix_payroll_details_payroll_detail_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_payroll_details_payroll_detail_id ON public.payroll_details USING btree (payroll_detail_id);


--
-- Name: ix_payroll_runs_payroll_run_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_payroll_runs_payroll_run_id ON public.payroll_runs USING btree (payroll_run_id);


--
-- Name: ix_performance_reviews_review_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_performance_reviews_review_id ON public.performance_reviews USING btree (review_id);


--
-- Name: ix_salary_structures_salary_structure_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX ix_salary_structures_salary_structure_id ON public.salary_structures USING btree (salary_structure_id);


--
-- Name: attendance attendance_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.attendance
    ADD CONSTRAINT attendance_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: candidates candidates_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.candidates
    ADD CONSTRAINT candidates_job_id_fkey FOREIGN KEY (job_id) REFERENCES public.job_openings(job_id);


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
-- Name: employee_documents fk_employee_documents_employee; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_documents
    ADD CONSTRAINT fk_employee_documents_employee FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id) ON DELETE CASCADE;


--
-- Name: employee_documents fk_employee_documents_uploaded_by; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee_documents
    ADD CONSTRAINT fk_employee_documents_uploaded_by FOREIGN KEY (uploaded_by) REFERENCES public.users(id);


--
-- Name: employees fk_employee_org; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT fk_employee_org FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: role_permissions fk_role_permission_permission; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT fk_role_permission_permission FOREIGN KEY (permission_id) REFERENCES public.permissions(id);


--
-- Name: role_permissions fk_role_permission_role; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_permissions
    ADD CONSTRAINT fk_role_permission_role FOREIGN KEY (role_id) REFERENCES public.roles(id);


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


--
-- Name: job_openings job_openings_department_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_openings
    ADD CONSTRAINT job_openings_department_id_fkey FOREIGN KEY (department_id) REFERENCES public.departments(id);


--
-- Name: leave_balances leave_balances_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_balances
    ADD CONSTRAINT leave_balances_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: leave_requests leave_requests_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leave_requests
    ADD CONSTRAINT leave_requests_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: organization_policies organization_policies_organization_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organization_policies
    ADD CONSTRAINT organization_policies_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: payroll_details payroll_details_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payroll_details
    ADD CONSTRAINT payroll_details_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: payroll_details payroll_details_payroll_run_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payroll_details
    ADD CONSTRAINT payroll_details_payroll_run_id_fkey FOREIGN KEY (payroll_run_id) REFERENCES public.payroll_runs(payroll_run_id);


--
-- Name: performance_reviews performance_reviews_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.performance_reviews
    ADD CONSTRAINT performance_reviews_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: performance_reviews performance_reviews_reviewer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.performance_reviews
    ADD CONSTRAINT performance_reviews_reviewer_id_fkey FOREIGN KEY (reviewer_id) REFERENCES public.users(id);


--
-- Name: salary_structures salary_structures_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salary_structures
    ADD CONSTRAINT salary_structures_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- PostgreSQL database dump complete
--

\unrestrict KHQxhUMi5l4Cym858wur0nJoi04XaC9jyMphJ6PZxcJS40GsCg9jkSCacpXNCp3

