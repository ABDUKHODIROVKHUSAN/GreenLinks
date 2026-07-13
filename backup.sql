--
-- PostgreSQL database dump
--

\restrict TavZHSWbcvRQ5TyRp6py14bjKhw3pqziIgk6hpdy5GzT8qb3ziDub4ZeOsRUwVO

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


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
-- Name: catalog_products_source_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.catalog_products_source_enum AS ENUM (
    'CLUBS',
    'BALLS',
    'BAGS',
    'APPAREL',
    'ACCESSORIES',
    'SALE'
);


ALTER TYPE public.catalog_products_source_enum OWNER TO postgres;

--
-- Name: users_role_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.users_role_enum AS ENUM (
    'CUSTOMER',
    'ADMIN'
);


ALTER TYPE public.users_role_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: catalog_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.catalog_products (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    source public.catalog_products_source_enum NOT NULL,
    category character varying NOT NULL,
    brand character varying NOT NULL,
    name character varying NOT NULL,
    rating double precision DEFAULT 0 NOT NULL,
    price double precision NOT NULL,
    badge character varying,
    description text,
    "reviewCount" integer DEFAULT 0 NOT NULL,
    "originalPrice" double precision,
    "salePrice" double precision,
    "imageUrl" character varying,
    "isFeatured" boolean DEFAULT false NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.catalog_products OWNER TO postgres;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    name character varying NOT NULL
);


ALTER TABLE public.migrations OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.migrations_id_seq OWNER TO postgres;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: support_tickets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.support_tickets (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name character varying NOT NULL,
    email character varying NOT NULL,
    topic character varying NOT NULL,
    message text NOT NULL,
    status character varying DEFAULT 'OPEN'::character varying NOT NULL,
    "referenceNumber" character varying NOT NULL,
    "orderNumber" character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.support_tickets OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    email character varying NOT NULL,
    phone character varying NOT NULL,
    first_name character varying,
    last_name character varying,
    password_hash character varying NOT NULL,
    role public.users_role_enum DEFAULT 'CUSTOMER'::public.users_role_enum NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Data for Name: catalog_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.catalog_products (id, source, category, brand, name, rating, price, badge, description, "reviewCount", "originalPrice", "salePrice", "imageUrl", "isFeatured", "isActive", created_at, updated_at) FROM stdin;
b7a125aa-6cfb-447d-ad32-6b76437a28a6	BALLS	Golf Balls	Titleist	Pro V1	4.9	54.99	\N	Tour-proven premium golf ball.	0	\N	\N	\N	f	t	2026-04-01 20:32:06.017445	2026-04-01 20:32:06.017445
8cdb488e-2bde-4f25-80a2-a8daa5dd9c3b	BALLS	BALLS	Titleist	Titleist Pro V1	0	49.99	\N	\N	0	\N	\N	\N	f	t	2026-04-01 21:31:55.359596	2026-04-01 21:31:55.359596
92826d0e-2a48-49fb-889f-fb746cf47a6d	BALLS	BALLS	Titleist	Titleist Pro Magic V4	0	39.99	\N	\N	0	\N	\N	https://images.unsplash.com/photo-1599058917765-a780eda07a3e	f	t	2026-04-01 21:38:33.11425	2026-04-01 21:38:33.11425
fde81582-7acd-4dd4-8366-407da192caf1	BALLS	BALLS	Smoke	Smoldering Tit 009	0	69.99	\N	Premium golf ball with exceptional distance and control.	0	\N	\N	https://upload.wikimedia.org/wikipedia/commons/7/7a/Golf_ball_2.jpg	t	t	2026-04-01 21:43:13.423043	2026-04-01 21:43:13.423043
768bb66f-039d-40cc-ad74-d125654f90cb	BALLS	BALLS	TaylorMade	TaylorMade TP5	0	47.99	\N	Tour-level golf ball with 5-layer construction for maximum performance.	0	\N	\N	https://upload.wikimedia.org/wikipedia/commons/0/0b/Golf_ball_on_grass.jpg	t	t	2026-04-01 21:43:51.407963	2026-04-01 21:43:51.407963
c86bd9e6-73fe-4a84-a680-6190bb36364d	BALLS	BALLS	Srixon	Srixon Z-Star	0	42.99	\N	Premium golf ball with exceptional greenside spin and control.	0	\N	\N	https://upload.wikimedia.org/wikipedia/commons/3/3e/Golf_ball_closeup.jpg	f	t	2026-04-01 21:44:16.580586	2026-04-01 21:44:16.580586
450c4ebe-bb72-4000-b4c7-9a4e001f5f92	BALLS	BALLS	Callaway	Callaway Supersoft	0	29.99	\N	Ultra-soft feel with low compression for longer distance.	0	\N	\N	https://images.unsplash.com/photo-1592919505780-303950717480	t	t	2026-04-01 21:45:06.849014	2026-04-01 21:45:06.849014
55758b86-03e0-42f8-911b-17d8a853834d	BAGS	BAGS	Ghost	Anyday Golf Stand Bags	0	229.99	\N	Lightweight stand bag with premium materials and ample storage.	0	\N	\N	https://ghostgolf.com/cdn/shop/files/8_2c911e60-9862-4ec3-a32d-b5d92b450387.jpg?v=1762272436&width=1080	t	t	2026-04-01 21:48:02.21637	2026-04-01 21:48:02.21637
17f49f25-0ec4-4214-989b-8174b99fbf29	BAGS	BAGS	Srixon	Srixon Premium Stand Bag	0	214.99	\N	Lightweight premium stand bag with durable construction and comfort straps.	0	\N	\N	https://dealpang.mwerp.kr/goods/26/02/07/1000078899/1000078899_detail_065.jpg	t	t	2026-04-01 22:20:31.013786	2026-04-01 22:20:31.013786
52aba5dc-b7c2-4625-9fbc-b1ffab4365a3	BAGS	BAGS	Srixon	Srixon Premium Stand Bag	0	214.99	\N	Lightweight premium stand bag with durable construction and comfort straps.	0	\N	\N	https://cdn.shoplightspeed.com/shops/617927/files/51816181/cleveland-srixon-srixon-americana-limited-edition.jpg	t	t	2026-04-01 22:20:30.138533	2026-04-01 22:20:30.138533
f9f12b0f-5cfe-4317-8e50-439270428a40	BAGS	BAGS	Titleist	Titleist Cart 15 Bag	0	299.99	\N	Premium cart bag with 15-way top and maximum storage capacity.	0	\N	\N	https://golf360.co.nz/cdn/shop/files/Titleist-Cart-15-Golf-Bag-Eucalyptus-Golf360-7.png?v=1765596017&width=1920	t	t	2026-04-01 21:59:16.210671	2026-04-01 21:59:16.210671
f91730b8-e75e-4df4-ac0d-5578a944027a	BAGS	BAGS	Nike	Nike Performance Golf Bag	0	189.99	\N	Sport-inspired golf bag with modern styling and comfort.	0	\N	\N	https://cdn11.bigcommerce.com/s-p4e2op94ll/images/stencil/1280x1280/products/3496/25836/N1002004061_SP22_NIKE_PERFORMANCE_CART_GB_A_PHSRP001__14601.1741394437.jpg?c=2?imbypass=on	t	t	2026-04-01 22:15:40.122283	2026-04-01 22:15:40.122283
6487fed2-5d26-458c-a79c-9b7831aeba92	APPAREL	APPAREL	Callaway	Callaway Lightweight Golf Jacket	0	119.99	\N	Wind-resistant jacket ideal for cool weather on the course.	0	\N	\N	https://golfbase.co.uk/media/catalog/product/cache/354f0e492e74c2a10953811d52938581/c/g/cgrfc0n0_410_1_new_7603.jpg	t	t	2026-04-01 22:42:42.625068	2026-04-01 22:42:42.625068
36dc0909-2abe-4712-b0bf-7dc5c9ac4bc6	BAGS	BAGS	Wilson	Wilson Staff EXO Lite Cart Bag	0	239.99	\N	Cart bag with excellent storage and lightweight design for easy handling.	0	\N	\N	https://cdn11.bigcommerce.com/s-uotidv742a/images/stencil/1280x1280/products/82323/282521/wilson%20exo%20lite%20red-white-black__29168.1747159912.jpg?c=2	f	t	2026-04-01 22:20:42.805114	2026-04-01 22:20:42.805114
bafa1d03-dc75-48a7-8f70-c0d751ebba7b	BAGS	Carry Bags	Vessel	Player V Pro Stand Bag	4.7	429.99	\N	Premium stand bag with modern storage layout.	0	\N	\N	https://vesselgolf.com/cdn/shop/files/ironbrew3.png?v=1757520280&width=2048	f	t	2026-04-01 20:32:06.017445	2026-04-01 20:32:06.017445
358a531f-d0fa-464d-85ae-e0a02e7c2c31	BAGS	BAGS	Ogio	Ogio Fuse Stand Bag	0	199.99	\N	Modern stand bag with bold design and smart storage compartments.	0	\N	\N	https://ggcgolf.com/cdn/shop/files/OgioFuseStandBagBayside1.jpg?v=1739545886&width=1946	t	t	2026-04-01 22:20:54.21729	2026-04-01 22:20:54.21729
c9172739-b6cb-400c-9ae9-4d91cdbe90f8	APPAREL	APPAREL	Nike	Nike Dri-FIT Golf Polo	0	64.99	\N	Moisture-wicking golf polo designed for comfort and performance.	0	\N	\N	https://www.merchology.com/cdn/shop/products/637167_blustery_flat_front_1024x1024.jpg?v=1571267406	t	t	2026-04-01 22:37:47.06961	2026-04-01 22:37:47.06961
acd9bd2a-9756-49b1-84bb-6483f842bbb7	APPAREL	APPAREL	Adidas	Adidas Ultimate365 Polo Shirt	0	59.99	\N	Stretchable polo shirt built for flexibility and all-day comfort.	0	\N	\N	https://img.shopstyle-cdn.com/sim/f4/8f/f48fbae116222ac81832e742fc82efb1_best/ultimate365-polo-shirt.jpg	t	t	2026-04-01 22:38:53.464581	2026-04-01 22:38:53.464581
29789196-3dd3-4f3f-96fa-7143c6cc70b6	APPAREL	APPAREL	Under Armour	Under Armour Playoff Polo	0	69.99	\N	Lightweight and breathable polo with sweat-wicking fabric.	0	\N	\N	https://www.merchology.com/cdn/shop/products/1376904-301-F_1024x1024.jpg?v=1696955000	f	t	2026-04-01 22:39:41.910843	2026-04-01 22:39:41.910843
066504cc-956a-43bb-923d-cdb96f20307e	APPAREL	APPAREL	Puma	Puma Jackpot Golf Pants	0	89.99	\N	Comfortable stretch golf pants with modern athletic fit.	0	\N	\N	https://www.henrilloyd.com/cdn/shop/files/Untitled_design_-_2026-02-09T082639.773.jpg?v=1770625613	f	t	2026-04-01 22:41:39.715631	2026-04-01 22:41:39.715631
9c167fcf-ff42-4b95-90ad-105bece920a3	APPAREL	APPAREL	Titleist	Titleist Tour Performance Cap	0	29.99	\N	Classic golf cap with breathable fabric and adjustable fit.	0	\N	\N	https://golfparadise.net.au/cdn/shop/files/2023_TourPerformance_Reef_Blue_White_01.webp?v=1741740775	f	t	2026-04-01 22:43:56.918939	2026-04-01 22:43:56.918939
e167e500-57bb-4045-8a39-9db8229750a9	APPAREL	APPAREL	Titleist	Titleist Tour Performance Cap	0	29.99	\N	Classic golf cap with breathable fabric and adjustable fit.	0	\N	\N	https://www.bizpromo.co.nz/cdn/shop/files/118398-0_1400x.jpg?v=1740837709	f	t	2026-04-01 22:43:14.878087	2026-04-01 22:43:14.878087
59799f0b-10db-4b4c-9410-0556a0d26ffd	ACCESSORIES	ACCESSORIES	FootJoy	FootJoy WeatherSof Golf Glove	0	19.99	\N	Comfortable and durable golf glove with excellent grip.	0	\N	\N	https://zl3k0ly8.aerocdn.com/image-factory/53453cbce9d996868af38726dd055aa106dccef4~350x350/images/products/2VeZalE2RqNVmu07AyeeGwP35ia1AVCMrahnbOUM.jpg	t	t	2026-04-01 22:51:29.775936	2026-04-01 22:51:29.775936
e02ebe0e-6779-4c99-a1e7-b9d5194b3b82	ACCESSORIES	ACCESSORIES	Pride	Pride Professional Golf Tees (50 Pack)	0	9.99	\N	High-quality wooden tees for consistent performance.	0	\N	\N	https://drummondgolf.com.au/cdn/shop/files/53-9711_cpev23450_6f82f863-8d7d-4cc7-b69b-6d4733b4c6ff.jpg?v=1762492034&width=1920	f	t	2026-04-01 22:52:50.219302	2026-04-01 22:52:50.219302
1f45ee3b-6f26-45e2-8568-0ef363446ba1	ACCESSORIES	ACCESSORIES	Callaway	Callaway 4-in-1 Divot Repair Tool	0	14.99	\N	Multi-functional divot repair tool with ball marker.	0	\N	\N	https://m.media-amazon.com/images/I/71+4A6HgYSL.jpg	t	t	2026-04-01 22:54:43.022004	2026-04-01 22:54:43.022004
6cb96c72-f7b3-44a0-8c76-4cb7dced1fca	ACCESSORIES	ACCESSORIES	Nike	Nike Classic99 Golf Cap	0	29.99	\N	Lightweight golf cap with adjustable strap and breathable fabric.	0	\N	\N	https://www.anygivensunday.shop/1778-home_default/nike-mens-cap-legacy-vapor-swoosh-flex-nfl-giants.jpg	f	t	2026-04-01 22:56:39.116409	2026-04-01 22:56:39.116409
395ceca2-6e98-445b-922c-2d844bf031aa	ACCESSORIES	ACCESSORIES	Grooveit	Grooveit Golf Club Cleaner Brush	0	24.99	\N	Water brush cleaner to keep your clubs in top condition.	0	\N	\N	https://vesselgolf.com/cdn/shop/products/Product-Groove-Brush-03_grande.jpg?v=1757520521	t	t	2026-04-01 22:57:15.305992	2026-04-01 22:57:15.305992
585fa674-664e-4e55-95a8-70f7a61fcc56	ACCESSORIES	ACCESSORIES	Titleist	Titleist Valuables Pouch	0	34.99	\N	Compact pouch for storing golf accessories and valuables.	0	\N	\N	https://acushnet.scene7.com/is/image/titleist/TA23NGVPK-1-00-1200x1100-01?wid=600&fmt=png-alpha	f	t	2026-04-01 22:57:20.678362	2026-04-01 22:57:20.678362
46c7e599-073b-4a2c-9002-c034062a0a5e	CLUBS	CLUBS	Callaway	Callaway Paradym Driver	0	579.99	\N	Advanced driver designed for speed, forgiveness, and distance.	0	\N	\N	https://cdn.media.amplience.net/i/pgatss/2000000035887-01_pc?$large$&fmt=auto	t	t	2026-04-01 23:00:44.500477	2026-04-01 23:00:44.500477
853eee5c-ee85-48cc-bf42-ce1216288de1	CLUBS	CLUBS	TaylorMade	TaylorMade Stealth 2 Driver	0	599.99	\N	High-performance driver with carbon face for explosive distance.	0	\N	\N	https://cdn.media.amplience.net/i/pgatss/2000000033749-06_pc?$large$&fmt=auto	t	t	2026-04-01 23:01:39.593171	2026-04-01 23:01:39.593171
636b3e70-c5a5-4ee8-991e-8d50cddbdb14	CLUBS	CLUBS	Titleist	Titleist T-Series Irons Set	0	1199.99	\N	Precision-engineered irons delivering control and consistency.	0	\N	\N	https://acushnet.scene7.com/is/image/titleist/2025_Titleist_T250_Catalog02_RGB-20250626?wid=1540	t	t	2026-04-01 23:03:11.121539	2026-04-01 23:03:11.121539
19728195-8a45-4e95-97b3-eed05cbdc025	CLUBS	CLUBS	Ping	Ping G430 Irons	0	1099.99	\N	Game-improvement irons with high forgiveness and distance.	0	\N	\N	https://m.media-amazon.com/images/I/61mSRSyZE8L.jpg_BO30,255,255,255_UF750,750_SR1910,1000,0,C_QL100_.jpg	f	t	2026-04-01 23:04:01.51869	2026-04-01 23:04:01.51869
49f557f5-6f57-46ac-9248-bbf1f0bf615a	CLUBS	CLUBS	Cleveland	Cleveland RTX ZipCore Wedge	0	149.99	\N	Tour-level wedge with exceptional spin and control.	0	\N	\N	https://image.globalgolf.com/dynamic/1058427/aad/sole-view/cleveland-rtx-full-face-zipcore-tour-satin-wedge.jpg?s=1240	f	t	2026-04-01 23:05:16.230287	2026-04-01 23:05:16.230287
6e18ca17-8e7d-43c6-9189-6d9853bf4565	CLUBS	CLUBS	Titleist	Titleist Vokey SM9 Wedge	0	179.99	\N	Premium wedge designed for maximum spin and shot versatility.	0	\N	\N	https://www.expressgolf.co.uk/wp-content/uploads/2022/01/Vokey_SM9_54_10_S_TC_Catalog_1_RGB.jpg	t	t	2026-04-01 23:05:56.980877	2026-04-01 23:05:56.980877
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migrations (id, "timestamp", name) FROM stdin;
1	1710000000000	InitialSchema1710000000000
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (id, order_number, user_id, subtotal, shipping_cost, tax, total, currency, payment_method, shipping_method, contact_email, contact_phone, delivery_name, delivery_address_line1, delivery_address_line2, delivery_city, delivery_region, delivery_postal_code, delivery_country, items, created_at) FROM stdin;
\.


--
-- Data for Name: support_tickets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.support_tickets (id, name, email, topic, message, status, "referenceNumber", "orderNumber", created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, email, phone, first_name, last_name, password_hash, role, created_at) FROM stdin;
800b8ce8-7894-41d7-918c-c5a0e820f90a	admin@golfecommerce.dev	+1 555 111 2222	\N	\N	$2b$12$m/gBtF6U.LtnTQgCrTbUUe3Jb1dEAZVt1K/MYf44Lpt0eBDNdIR6y	ADMIN	2026-04-01 20:32:06.017445
5b1d016b-a64c-4622-8c71-ecfb1263ae9a	test@gmail.com	111111111111	\N	\N	$2b$12$APESGieM5h85kSq3C9Hxv.yfS.qwLjk3JKp9LxHCD3H2LVt7AhaJi	ADMIN	2026-04-01 20:32:06.017445
5df59704-9517-44e6-9a1b-da50618805a5	officialabdukhodirov@gmail.com	01056917262	\N	\N	$2b$10$4SuYfawdMHDvEXNY1TPR1eRox1k7yK.oojCphv2bX6se2JfSyxNZ6	CUSTOMER	2026-04-01 20:46:14.066331
e4a76629-12c8-44ea-a81c-c2a9aa459e3e	officia2labdukhodirov@gmail.com	01056918778	\N	\N	node	ADMIN	2026-04-01 20:50:07.962985
\.


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.migrations_id_seq', 1, true);


--
-- Name: migrations PK_8c82d7f526340ab734260ea46be; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT "PK_8c82d7f526340ab734260ea46be" PRIMARY KEY (id);


--
-- Name: support_tickets UQ_0b84943dd5c2c7bee468c6e1b7d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT "UQ_0b84943dd5c2c7bee468c6e1b7d" UNIQUE ("referenceNumber");


--
-- Name: catalog_products catalog_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.catalog_products
    ADD CONSTRAINT catalog_products_pkey PRIMARY KEY (id);


--
-- Name: orders orders_order_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_order_number_key UNIQUE (order_number);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: support_tickets support_tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.support_tickets
    ADD CONSTRAINT support_tickets_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: idx_orders_contact_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_contact_email ON public.orders USING btree (contact_email);


--
-- Name: idx_orders_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_created_at ON public.orders USING btree (created_at);


--
-- Name: idx_orders_order_number; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_order_number ON public.orders USING btree (order_number);


--
-- Name: idx_orders_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_orders_user_id ON public.orders USING btree (user_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

\unrestrict TavZHSWbcvRQ5TyRp6py14bjKhw3pqziIgk6hpdy5GzT8qb3ziDub4ZeOsRUwVO

