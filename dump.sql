--
-- PostgreSQL database dump
--

\restrict CZREildFdjkK2thSWoHT4XAvRqKhpzDc5GyKwotY9Z9ST8ZQ7DjYvqRxZxSoSaa

-- Dumped from database version 18.3 (Homebrew)
-- Dumped by pg_dump version 18.3 (Homebrew)

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

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: catalog_products_source_enum; Type: TYPE; Schema: public; Owner: marvel
--

CREATE TYPE public.catalog_products_source_enum AS ENUM (
    'CLUBS',
    'BALLS',
    'BAGS',
    'APPAREL',
    'ACCESSORIES',
    'SALE'
);


ALTER TYPE public.catalog_products_source_enum OWNER TO marvel;

--
-- Name: users_role_enum; Type: TYPE; Schema: public; Owner: marvel
--

CREATE TYPE public.users_role_enum AS ENUM (
    'CUSTOMER',
    'ADMIN'
);


ALTER TYPE public.users_role_enum OWNER TO marvel;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: catalog_products; Type: TABLE; Schema: public; Owner: marvel
--

CREATE TABLE public.catalog_products (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    source public.catalog_products_source_enum NOT NULL,
    category character varying NOT NULL,
    brand character varying NOT NULL,
    name character varying NOT NULL,
    rating double precision DEFAULT 0 NOT NULL,
    review_count integer DEFAULT 0 NOT NULL,
    price double precision NOT NULL,
    original_price double precision,
    sale_price double precision,
    badge character varying,
    image_url character varying,
    description text,
    is_featured boolean DEFAULT false NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.catalog_products OWNER TO marvel;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: marvel
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.migrations OWNER TO marvel;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: marvel
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO marvel;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: marvel
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: marvel
--

CREATE TABLE public.orders (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    order_number character varying NOT NULL,
    user_id character varying,
    subtotal double precision NOT NULL,
    shipping_cost double precision NOT NULL,
    tax double precision NOT NULL,
    total double precision NOT NULL,
    currency character varying NOT NULL,
    payment_method character varying NOT NULL,
    shipping_method character varying NOT NULL,
    contact_email character varying NOT NULL,
    contact_phone character varying NOT NULL,
    delivery_name character varying NOT NULL,
    delivery_address_line1 character varying NOT NULL,
    delivery_address_line2 character varying,
    delivery_city character varying NOT NULL,
    delivery_region character varying NOT NULL,
    delivery_postal_code character varying NOT NULL,
    delivery_country character varying NOT NULL,
    items jsonb DEFAULT '[]'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.orders OWNER TO marvel;

--
-- Name: support_tickets; Type: TABLE; Schema: public; Owner: marvel
--

CREATE TABLE public.support_tickets (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    reference_number character varying NOT NULL,
    name character varying NOT NULL,
    email character varying NOT NULL,
    topic character varying NOT NULL,
    order_number character varying,
    message text NOT NULL,
    status character varying DEFAULT 'OPEN'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.support_tickets OWNER TO marvel;

--
-- Name: users; Type: TABLE; Schema: public; Owner: marvel
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    email character varying NOT NULL,
    phone character varying NOT NULL,
    first_name character varying,
    last_name character varying,
    password_hash character varying NOT NULL,
    refresh_token_hash character varying,
    role public.users_role_enum DEFAULT 'CUSTOMER'::public.users_role_enum NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO marvel;

--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: marvel
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Data for Name: catalog_products; Type: TABLE DATA; Schema: public; Owner: marvel
--

COPY public.catalog_products (id, source, category, brand, name, rating, review_count, price, original_price, sale_price, badge, image_url, description, is_featured, is_active, created_at, updated_at) FROM stdin;
9813b61b-3278-4f44-a66d-4c754513b2ad	CLUBS	Drivers	TaylorMade	Qi10 Max Driver	4.8	94	599.99	\N	\N	\N	https://res.cloudinary.com/demo/image/upload/golf/qi10-max-driver.jpg	Forgiving premium driver for high-launch distance.	t	t	2026-03-30 11:58:19.391762+09	2026-03-30 11:58:19.391762+09
b7a125aa-6cfb-447d-ad32-6b76437a28a6	BALLS	Golf Balls	Titleist	Pro V1	4.9	213	54.99	\N	\N	\N	https://res.cloudinary.com/demo/image/upload/golf/pro-v1.jpg	Tour-proven premium golf ball.	t	t	2026-03-30 11:58:19.397342+09	2026-03-30 11:58:19.397342+09
bafa1d03-dc75-48a7-8f70-c0d751ebba7b	BAGS	Carry Bags	Vessel	Player V Pro Stand Bag	4.7	41	429.99	\N	\N	\N	https://res.cloudinary.com/demo/image/upload/golf/player-v-pro-stand-bag.jpg	Premium stand bag with modern storage layout.	f	t	2026-03-30 11:58:19.399228+09	2026-03-30 11:58:19.399228+09
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: marvel
--

COPY public.migrations (id, "timestamp", name) FROM stdin;
1	1710000000000	InitialSchema1710000000000
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: marvel
--

COPY public.orders (id, order_number, user_id, subtotal, shipping_cost, tax, total, currency, payment_method, shipping_method, contact_email, contact_phone, delivery_name, delivery_address_line1, delivery_address_line2, delivery_city, delivery_region, delivery_postal_code, delivery_country, items, created_at) FROM stdin;
\.


--
-- Data for Name: support_tickets; Type: TABLE DATA; Schema: public; Owner: marvel
--

COPY public.support_tickets (id, reference_number, name, email, topic, order_number, message, status, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: marvel
--

COPY public.users (id, email, phone, first_name, last_name, password_hash, refresh_token_hash, role, created_at) FROM stdin;
800b8ce8-7894-41d7-918c-c5a0e820f90a	admin@golfecommerce.dev	+1 555 111 2222	\N	\N	$2b$12$m/gBtF6U.LtnTQgCrTbUUe3Jb1dEAZVt1K/MYf44Lpt0eBDNdIR6y	\N	ADMIN	2026-03-30 11:57:55.633856+09
5b1d016b-a64c-4622-8c71-ecfb1263ae9a	test@gmail.com	111111111111	\N	\N	$2b$12$APESGieM5h85kSq3C9Hxv.yfS.qwLjk3JKp9LxHCD3H2LVt7AhaJi	$2b$12$lWyfJTfJRk2K0xK9XXtfZeMVOWo2tCzlMLeezJHp29BWcmBhbLqVK	ADMIN	2026-03-30 12:02:15.942535+09
\.


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: marvel
--

SELECT pg_catalog.setval('public.migrations_id_seq', 1, true);


--
-- Name: migrations PK_8c82d7f526340ab734260ea46be; Type: CONSTRAINT; Schema: public; Owner: marvel
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT "PK_8c82d7f526340ab734260ea46be" PRIMARY KEY (id);


--
-- Name: catalog_products catalog_products_pkey; Type: CONSTRAINT; Schema: public; Owner: marvel
--

ALTER TABLE ONLY public.catalog_products
    ADD CONSTRAINT catalog_products_pkey PRIMARY KEY (id);


--
-- Name: orders orders_order_number_key; Type: CONSTRAINT; Schema: public; Owner: marvel
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_order_number_key UNIQUE (order_number);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: marvel
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: support_tickets support_tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: marvel
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT support_tickets_pkey PRIMARY KEY (id);


--
-- Name: support_tickets support_tickets_reference_number_key; Type: CONSTRAINT; Schema: public; Owner: marvel
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT support_tickets_reference_number_key UNIQUE (reference_number);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: marvel
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: marvel
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_catalog_products_category; Type: INDEX; Schema: public; Owner: marvel
--

CREATE INDEX idx_catalog_products_category ON public.catalog_products USING btree (category);


--
-- Name: idx_catalog_products_source_active_created; Type: INDEX; Schema: public; Owner: marvel
--

CREATE INDEX idx_catalog_products_source_active_created ON public.catalog_products USING btree (source, is_active, created_at);


--
-- Name: idx_orders_contact_email; Type: INDEX; Schema: public; Owner: marvel
--

CREATE INDEX idx_orders_contact_email ON public.orders USING btree (contact_email);


--
-- Name: idx_orders_created_at; Type: INDEX; Schema: public; Owner: marvel
--

CREATE INDEX idx_orders_created_at ON public.orders USING btree (created_at);


--
-- Name: idx_orders_order_number; Type: INDEX; Schema: public; Owner: marvel
--

CREATE INDEX idx_orders_order_number ON public.orders USING btree (order_number);


--
-- Name: idx_orders_user_id; Type: INDEX; Schema: public; Owner: marvel
--

CREATE INDEX idx_orders_user_id ON public.orders USING btree (user_id);


--
-- Name: idx_support_tickets_email_created; Type: INDEX; Schema: public; Owner: marvel
--

CREATE INDEX idx_support_tickets_email_created ON public.support_tickets USING btree (email, created_at);


--
-- Name: idx_support_tickets_order_number; Type: INDEX; Schema: public; Owner: marvel
--

CREATE INDEX idx_support_tickets_order_number ON public.support_tickets USING btree (order_number);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: marvel
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- PostgreSQL database dump complete
--

\unrestrict CZREildFdjkK2thSWoHT4XAvRqKhpzDc5GyKwotY9Z9ST8ZQ7DjYvqRxZxSoSaa

