--
-- PostgreSQL database dump
--

-- Dumped from database version 15.13 (Debian 15.13-1.pgdg120+1)
-- Dumped by pg_dump version 15.13 (Debian 15.13-1.pgdg120+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
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
    penname character varying,
    confirmation_token character varying,
    confirmed_at timestamp(6) without time zone,
    confirmation_sent_at timestamp(6) without time zone,
    unconfirmed_email character varying
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: works; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.works (
    id bigint NOT NULL,
    title character varying,
    body text,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.works OWNER TO postgres;

--
-- Name: works_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.works_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.works_id_seq OWNER TO postgres;

--
-- Name: works_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.works_id_seq OWNED BY public.works.id;


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: works id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.works ALTER COLUMN id SET DEFAULT nextval('public.works_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2025-07-01 14:54:29.019349	2025-07-01 14:54:29.019353
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20250630051710
20250702040400
20250703061157
20250923074325
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at, penname, confirmation_token, confirmed_at, confirmation_sent_at, unconfirmed_email) FROM stdin;
2	old@example.com	$2a$12$l.5X/4YUNVqBMc5xI28mbe/NqB7kFo7Te8awUbDckeeN02runKgMG	\N	\N	\N	2025-09-23 07:51:56.37988	2025-09-23 07:51:56.37988	\N	\N	2025-09-23 07:51:56.187881	\N	\N
1	tukomogami@gmail.com	$2a$12$t7PE6DM12LKzC3PpI..h8OnxKNoIfFFLIFSFSt2f9Rd8x8QqhQDAG	\N	\N	\N	2025-07-02 05:24:17.084865	2025-09-23 07:58:15.090879	まいご	_QwMtNfjPjePWeLiFXYU	2025-07-03 08:32:25.537425	2025-09-23 07:58:15.091082	koikanadurai@gmail.com
3	resettest@example.com	$2a$12$9zofWoMmRuyUACUNO.Tm8.61f5mq5XXsbLA81k5csXmwcZYAonCJC	3b3523ae1fefc2f15026388a76c6400734333d4e06e83b39a4552e5fbd63d478	2025-09-23 08:07:40.27377	\N	2025-09-23 08:07:40.223996	2025-09-23 08:07:40.273846	\N	\N	2025-09-23 08:07:40.042747	\N	\N
\.


--
-- Data for Name: works; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.works (id, title, body, user_id, created_at, updated_at) FROM stdin;
2	テスト	あの〜〜〜〜あああ	1	2025-07-03 06:56:28.932948	2025-07-03 07:38:27.26329
30		あああ「」……——　[newpage][[rb: > ]][[NAME:>]]	1	2025-07-03 07:56:48.502767	2025-07-03 08:04:00.462294
31	あああ	「」……——　[newpage][[rb: > ]][[NAME:>]]	1	2025-07-03 08:04:15.433593	2025-07-03 08:04:15.433593
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- Name: works_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.works_id_seq', 31, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: works works_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.works
    ADD CONSTRAINT works_pkey PRIMARY KEY (id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_unconfirmed_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_users_on_unconfirmed_email ON public.users USING btree (unconfirmed_email);


--
-- Name: index_works_on_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX index_works_on_user_id ON public.works USING btree (user_id);


--
-- Name: works fk_rails_2d4237af37; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.works
    ADD CONSTRAINT fk_rails_2d4237af37 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

