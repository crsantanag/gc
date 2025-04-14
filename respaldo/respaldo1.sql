--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8 (Debian 16.8-1.pgdg120+1)
-- Dumped by pg_dump version 16.8 (Ubuntu 16.8-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: mysite
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO mysite;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: apartments; Type: TABLE; Schema: public; Owner: mysite
--

CREATE TABLE public.apartments (
    id bigint NOT NULL,
    number character varying,
    description character varying,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.apartments OWNER TO mysite;

--
-- Name: apartments_id_seq; Type: SEQUENCE; Schema: public; Owner: mysite
--

CREATE SEQUENCE public.apartments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.apartments_id_seq OWNER TO mysite;

--
-- Name: apartments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mysite
--

ALTER SEQUENCE public.apartments_id_seq OWNED BY public.apartments.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: mysite
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO mysite;

--
-- Name: bills; Type: TABLE; Schema: public; Owner: mysite
--

CREATE TABLE public.bills (
    id bigint NOT NULL,
    date date,
    tipo_egreso integer,
    comment character varying,
    amount integer,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.bills OWNER TO mysite;

--
-- Name: bills_id_seq; Type: SEQUENCE; Schema: public; Owner: mysite
--

CREATE SEQUENCE public.bills_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bills_id_seq OWNER TO mysite;

--
-- Name: bills_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mysite
--

ALTER SEQUENCE public.bills_id_seq OWNED BY public.bills.id;


--
-- Name: deposits; Type: TABLE; Schema: public; Owner: mysite
--

CREATE TABLE public.deposits (
    id bigint NOT NULL,
    date date,
    tipo_ingreso integer,
    comment character varying,
    amount integer,
    mes integer,
    ano integer,
    user_id bigint NOT NULL,
    apartment_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.deposits OWNER TO mysite;

--
-- Name: deposits_id_seq; Type: SEQUENCE; Schema: public; Owner: mysite
--

CREATE SEQUENCE public.deposits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.deposits_id_seq OWNER TO mysite;

--
-- Name: deposits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mysite
--

ALTER SEQUENCE public.deposits_id_seq OWNED BY public.deposits.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: mysite
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO mysite;

--
-- Name: users; Type: TABLE; Schema: public; Owner: mysite
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    name_community character varying,
    type_community character varying,
    saldo_inicial integer DEFAULT 0,
    name character varying,
    role integer DEFAULT 0
);


ALTER TABLE public.users OWNER TO mysite;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: mysite
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO mysite;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: mysite
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: apartments id; Type: DEFAULT; Schema: public; Owner: mysite
--

ALTER TABLE ONLY public.apartments ALTER COLUMN id SET DEFAULT nextval('public.apartments_id_seq'::regclass);


--
-- Name: bills id; Type: DEFAULT; Schema: public; Owner: mysite
--

ALTER TABLE ONLY public.bills ALTER COLUMN id SET DEFAULT nextval('public.bills_id_seq'::regclass);


--
-- Name: deposits id; Type: DEFAULT; Schema: public; Owner: mysite
--

ALTER TABLE ONLY public.deposits ALTER COLUMN id SET DEFAULT nextval('public.deposits_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: mysite
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: apartments; Type: TABLE DATA; Schema: public; Owner: mysite
--

COPY public.apartments (id, number, description, user_id, created_at, updated_at) FROM stdin;
21	D101	Verónica del Valle	3	2025-04-14 03:00:52.271467	2025-04-14 03:00:52.271467
22	D102	Jaime Alvarado	3	2025-04-14 03:00:52.28909	2025-04-14 03:00:52.28909
23	D201	Rosa Alarcón	3	2025-04-14 03:00:52.303936	2025-04-14 03:00:52.303936
24	D202		3	2025-04-14 03:00:52.317261	2025-04-14 03:00:52.317261
25	D301	Carlos Santana	3	2025-04-14 03:00:52.326985	2025-04-14 03:00:52.326985
26	D302	Máximo Fierro	3	2025-04-14 03:00:52.333947	2025-04-14 03:00:52.333947
27	D401	Paulina Díaz	3	2025-04-14 03:00:52.345642	2025-04-14 03:00:52.345642
28	D402		3	2025-04-14 03:00:52.354478	2025-04-14 03:00:52.354478
29	D501		3	2025-04-14 03:00:52.363162	2025-04-14 03:00:52.363162
30	D502		3	2025-04-14 03:00:52.369739	2025-04-14 03:00:52.369739
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: mysite
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	production	2025-04-14 01:05:05.978862	2025-04-14 01:05:05.978866
\.


--
-- Data for Name: bills; Type: TABLE DATA; Schema: public; Owner: mysite
--

COPY public.bills (id, date, tipo_egreso, comment, amount, user_id, created_at, updated_at) FROM stdin;
1	2025-04-14	1	Sandra Canales	306000	3	2025-04-14 03:20:04.132511	2025-04-14 03:20:04.132511
2	2025-04-14	1	Comisión BancoEstado	300	3	2025-04-14 03:20:25.652003	2025-04-14 03:20:25.652003
\.


--
-- Data for Name: deposits; Type: TABLE DATA; Schema: public; Owner: mysite
--

COPY public.deposits (id, date, tipo_ingreso, comment, amount, mes, ano, user_id, apartment_id, created_at, updated_at) FROM stdin;
5	2025-04-14	1	SC	40000	1	2025	3	21	2025-04-14 03:18:06.162487	2025-04-14 03:18:06.162487
6	2025-04-14	1	SC	40000	2	2025	3	21	2025-04-14 03:18:40.871777	2025-04-14 03:18:40.871777
7	2025-04-14	2	Cuota 1/2 extraordinaria	250000	\N	\N	3	21	2025-04-14 03:19:16.972155	2025-04-14 03:19:16.972155
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: mysite
--

COPY public.schema_migrations (version) FROM stdin;
20250409150742
20250409150743
20250409155520
20250409155820
20250409155933
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: mysite
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at, name_community, type_community, saldo_inicial, name, role) FROM stdin;
3	carlos.santana@gmail.com	$2a$12$zHx1cJbNRs3Q8W3/Nc4gseeba3mQbVp5nr9btbPPKhm86udD8SG/C	\N	\N	\N	2025-04-14 03:00:52.188486	2025-04-14 03:00:52.188486	Edificio La Providencia	Departamento	0	Carlos Santana	1
\.


--
-- Name: apartments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mysite
--

SELECT pg_catalog.setval('public.apartments_id_seq', 30, true);


--
-- Name: bills_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mysite
--

SELECT pg_catalog.setval('public.bills_id_seq', 2, true);


--
-- Name: deposits_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mysite
--

SELECT pg_catalog.setval('public.deposits_id_seq', 7, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: mysite
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: apartments apartments_pkey; Type: CONSTRAINT; Schema: public; Owner: mysite
--

ALTER TABLE ONLY public.apartments
    ADD CONSTRAINT apartments_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: mysite
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: bills bills_pkey; Type: CONSTRAINT; Schema: public; Owner: mysite
--

ALTER TABLE ONLY public.bills
    ADD CONSTRAINT bills_pkey PRIMARY KEY (id);


--
-- Name: deposits deposits_pkey; Type: CONSTRAINT; Schema: public; Owner: mysite
--

ALTER TABLE ONLY public.deposits
    ADD CONSTRAINT deposits_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: mysite
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: mysite
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_apartments_on_user_id; Type: INDEX; Schema: public; Owner: mysite
--

CREATE INDEX index_apartments_on_user_id ON public.apartments USING btree (user_id);


--
-- Name: index_bills_on_user_id; Type: INDEX; Schema: public; Owner: mysite
--

CREATE INDEX index_bills_on_user_id ON public.bills USING btree (user_id);


--
-- Name: index_deposits_on_apartment_id; Type: INDEX; Schema: public; Owner: mysite
--

CREATE INDEX index_deposits_on_apartment_id ON public.deposits USING btree (apartment_id);


--
-- Name: index_deposits_on_user_id; Type: INDEX; Schema: public; Owner: mysite
--

CREATE INDEX index_deposits_on_user_id ON public.deposits USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: mysite
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: mysite
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: deposits fk_rails_0eee5954c5; Type: FK CONSTRAINT; Schema: public; Owner: mysite
--

ALTER TABLE ONLY public.deposits
    ADD CONSTRAINT fk_rails_0eee5954c5 FOREIGN KEY (apartment_id) REFERENCES public.apartments(id);


--
-- Name: deposits fk_rails_88307c7ed2; Type: FK CONSTRAINT; Schema: public; Owner: mysite
--

ALTER TABLE ONLY public.deposits
    ADD CONSTRAINT fk_rails_88307c7ed2 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: apartments fk_rails_ce3cb81433; Type: FK CONSTRAINT; Schema: public; Owner: mysite
--

ALTER TABLE ONLY public.apartments
    ADD CONSTRAINT fk_rails_ce3cb81433 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: bills fk_rails_f5fcc78f42; Type: FK CONSTRAINT; Schema: public; Owner: mysite
--

ALTER TABLE ONLY public.bills
    ADD CONSTRAINT fk_rails_f5fcc78f42 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON SEQUENCES TO mysite;


--
-- Name: DEFAULT PRIVILEGES FOR TYPES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TYPES TO mysite;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON FUNCTIONS TO mysite;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: -; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres GRANT ALL ON TABLES TO mysite;


--
-- PostgreSQL database dump complete
--

