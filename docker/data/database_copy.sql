--
-- PostgreSQL database dump
--

-- Dumped from database version 14.5
-- Dumped by pg_dump version 14.3

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
-- Name: app_coviddata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_coviddata (
    id uuid NOT NULL,
    infected integer NOT NULL,
    deceased integer NOT NULL,
    recovered integer NOT NULL,
    quarantined integer NOT NULL,
    tested integer NOT NULL,
    date date NOT NULL,
    "time" time without time zone NOT NULL,
    "sourceWeb" character varying(100),
    "activeInfected" integer NOT NULL,
    CONSTRAINT "app_coviddata_activeInfected_e77eb50c_check" CHECK (("activeInfected" >= 0)),
    CONSTRAINT app_coviddata_deceased_check CHECK ((deceased >= 0)),
    CONSTRAINT app_coviddata_infected_check CHECK ((infected >= 0)),
    CONSTRAINT app_coviddata_quarantined_check CHECK ((quarantined >= 0)),
    CONSTRAINT app_coviddata_recovered_check CHECK ((recovered >= 0)),
    CONSTRAINT app_coviddata_tested_check CHECK ((tested >= 0))
);


ALTER TABLE public.app_coviddata OWNER TO postgres;

--
-- Name: app_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_user (
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    id uuid NOT NULL,
    email character varying(254) NOT NULL,
    "firstName" text NOT NULL,
    "lastName" text NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    is_superuser boolean NOT NULL,
    valid boolean NOT NULL,
    "dateJoined" timestamp with time zone NOT NULL
);


ALTER TABLE public.app_user OWNER TO postgres;

--
-- Name: app_user_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_user_groups (
    id bigint NOT NULL,
    user_id uuid NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.app_user_groups OWNER TO postgres;

--
-- Name: app_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.app_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_user_groups_id_seq OWNER TO postgres;

--
-- Name: app_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.app_user_groups_id_seq OWNED BY public.app_user_groups.id;


--
-- Name: app_user_user_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.app_user_user_permissions (
    id bigint NOT NULL,
    user_id uuid NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.app_user_user_permissions OWNER TO postgres;

--
-- Name: app_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.app_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.app_user_user_permissions_id_seq OWNER TO postgres;

--
-- Name: app_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.app_user_user_permissions_id_seq OWNED BY public.app_user_user_permissions.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO postgres;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO postgres;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO postgres;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id uuid NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO postgres;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO postgres;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO postgres;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO postgres;

--
-- Name: app_user_groups id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user_groups ALTER COLUMN id SET DEFAULT nextval('public.app_user_groups_id_seq'::regclass);


--
-- Name: app_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.app_user_user_permissions_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Data for Name: app_coviddata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_coviddata (id, infected, deceased, recovered, quarantined, tested, date, "time", "sourceWeb", "activeInfected") FROM stdin;
77e04a52-9828-4533-83e2-1bb723a51b27	32	0	1	159	1236	2020-03-15	11:46:00	https://apify.com/tugkan/covid-hu	0
f6580b0d-4a85-40e3-8e82-e430f5182037	0	0	0	0	0	2020-03-15	12:30:00	https://apify.com/tugkan/covid-hu	0
ca160723-95b9-4770-94bd-052bf0a9eefb	32	0	1	159	1236	2020-03-15	12:35:00	https://apify.com/tugkan/covid-hu	0
8c5a403e-3f7e-4237-8993-92194e9b9cde	32	1	1	159	1236	2020-03-15	14:25:00	https://apify.com/tugkan/covid-hu	0
2d66b30e-654f-4234-9594-360de6045eac	0	0	0	0	0	2020-03-15	16:25:00	https://apify.com/tugkan/covid-hu	0
beca1841-3cf3-476b-a643-6e215fc4578c	39	1	1	159	1236	2020-03-16	08:35:00	https://apify.com/tugkan/covid-hu	0
3c3a2231-4cbf-406f-a65f-716ef1dc24a3	39	1	1	159	1436	2020-03-16	08:45:00	https://apify.com/tugkan/covid-hu	0
ca36c77b-b7f1-43f2-8708-bf5b9348ea5d	39	1	1	136	1436	2020-03-16	09:10:00	https://apify.com/tugkan/covid-hu	0
48261484-3a34-49b5-bc67-5b712c99749e	30	0	1	136	1436	2020-03-16	12:05:00	https://apify.com/tugkan/covid-hu	0
ecea3569-1831-4f22-8d93-f03d10ba3880	39	1	1	136	1436	2020-03-16	13:05:00	https://apify.com/tugkan/covid-hu	0
66ad9489-a08b-4934-aed9-0117d54f32d1	39	1	1	137	1470	2020-03-16	18:35:00	https://apify.com/tugkan/covid-hu	0
b6551b73-ca4b-4c30-acb7-96dbb8a5dcd0	39	1	2	137	1470	2020-03-16	21:40:00	https://apify.com/tugkan/covid-hu	0
769d7d0f-250d-4e98-b608-0afd9e1ff375	50	1	2	137	1587	2020-03-17	07:35:00	https://apify.com/tugkan/covid-hu	0
52ed625c-5d95-427a-b9fe-c4081a87093a	58	1	2	137	1587	2020-03-18	06:10:00	https://apify.com/tugkan/covid-hu	0
39163aef-84ff-4416-af8f-a3be73bfc414	58	1	2	122	1803	2020-03-18	06:15:00	https://apify.com/tugkan/covid-hu	0
bb12f8d9-1d0a-4cd3-9c0d-015ba8adc771	73	1	2	124	2322	2020-03-19	06:50:00	https://apify.com/tugkan/covid-hu	0
7ee9c8d9-d8a2-497d-b8be-dd745df57148	85	1	2	124	2322	2020-03-20	05:50:00	https://apify.com/tugkan/covid-hu	0
4234bd48-8f0a-48bc-a7f5-2f5c3e41e320	85	1	2	124	3007	2020-03-20	06:00:00	https://apify.com/tugkan/covid-hu	0
94ccb1c6-ef61-4879-a47f-f04dc0da4357	85	1	7	116	3007	2020-03-20	07:15:00	https://apify.com/tugkan/covid-hu	0
c3337c2b-6e80-4409-b097-3075aef14575	85	3	7	116	3007	2020-03-20	10:20:00	https://apify.com/tugkan/covid-hu	0
0e62ffa4-b545-4770-b82a-e941a121c0e6	85	4	7	116	3007	2020-03-20	18:35:00	https://apify.com/tugkan/covid-hu	0
3ba8979d-161e-47be-bd1d-4176d5084b62	103	4	7	117	3447	2020-03-21	07:10:00	https://apify.com/tugkan/covid-hu	0
c2db831a-a08b-4304-a0db-cd7d419fc137	0	0	0	0	0	2020-03-21	23:05:00	https://apify.com/tugkan/covid-hu	0
e6b663de-a897-43c0-bd50-27df2af9eadb	103	4	7	117	3447	2020-03-21	23:20:00	https://apify.com/tugkan/covid-hu	0
422c8e9c-bb22-44b7-9cc0-e231c8fc03b2	103	4	7	115	4443	2020-03-22	07:40:00	https://apify.com/tugkan/covid-hu	0
a61bb725-7c0f-405f-a58e-d0870497c371	131	4	7	115	4443	2020-03-22	07:45:00	https://apify.com/tugkan/covid-hu	0
5b5754cb-f7ef-4a5e-ac7e-273fb197f525	131	6	12	115	4443	2020-03-22	09:35:00	https://apify.com/tugkan/covid-hu	0
2c028f35-c5aa-4781-837e-b25ae6c5c139	131	6	16	115	4443	2020-03-22	10:45:00	https://apify.com/tugkan/covid-hu	0
148984cc-298e-494a-9fba-651904e49b9e	167	7	16	101	5515	2020-03-23	06:00:00	https://apify.com/tugkan/covid-hu	0
d65af25a-1278-4b3e-a55d-f2d848f396c0	167	8	21	101	5515	2020-03-23	18:15:00	https://apify.com/tugkan/covid-hu	0
126d1378-8d90-4f54-a188-b5dfd3bd57bd	187	8	21	92	6113	2020-03-24	06:10:00	https://apify.com/tugkan/covid-hu	0
94a00d1e-7446-4f2c-a052-fe38786b1575	187	9	21	92	6113	2020-03-24	10:15:00	https://apify.com/tugkan/covid-hu	0
05e62a73-5160-4890-bf17-df0a451cc8f0	226	10	21	85	6817	2020-03-25	05:50:00	https://apify.com/tugkan/covid-hu	0
e6ef620e-98fd-4b13-84d4-7dc42449d640	261	10	28	100	8005	2020-03-26	05:35:00	https://apify.com/tugkan/covid-hu	0
c89cbbb7-6046-42d6-a2e5-47e885ae3db4	300	10	34	100	9275	2020-03-27	05:45:00	https://apify.com/tugkan/covid-hu	0
5d7bd171-182a-452c-8e57-3efa5331a6a1	300	10	34	84	9275	2020-03-27	06:25:00	https://apify.com/tugkan/covid-hu	0
c6d5de6a-1534-4836-ba37-02d05a0c3ff6	343	11	34	84	9275	2020-03-28	06:00:00	https://apify.com/tugkan/covid-hu	0
ba061d28-f740-4e15-bd02-1258f1190cfe	343	11	34	87	10303	2020-03-28	06:05:00	https://apify.com/tugkan/covid-hu	0
5576324a-45ec-407f-8da6-ee1a9244cba4	408	13	34	71	12148	2020-03-29	05:35:00	https://apify.com/tugkan/covid-hu	0
99780307-daf6-40a6-9ae3-651c43c79333	447	15	34	73	13301	2020-03-30	04:40:00	https://apify.com/tugkan/covid-hu	0
bc120a28-fd73-48ab-ab7d-08c30ad482bb	492	16	37	61	14146	2020-03-31	06:45:00	https://apify.com/tugkan/covid-hu	0
225fdf70-0c58-4216-ad80-4ee81f7a597d	0	0	0	0	0	2020-03-31	08:15:00	https://apify.com/tugkan/covid-hu	0
3c5796ec-bb07-47c1-b8ba-1177e3119dba	492	16	37	61	14146	2020-03-31	08:20:00	https://apify.com/tugkan/covid-hu	0
c77ccbbd-f94a-4aad-ba67-b339cff79db7	492	0	37	61	14146	2020-03-31	09:05:00	https://apify.com/tugkan/covid-hu	0
56aee126-adf5-41c3-82b1-f95e882ff619	525	0	40	61	15208	2020-04-01	04:50:00	https://apify.com/tugkan/covid-hu	0
072e26c7-3f50-423f-baac-1a8a6c2cc339	585	0	42	59	16401	2020-04-02	05:05:00	https://apify.com/tugkan/covid-hu	0
ac638c29-af14-4e53-a126-2e5063beb095	585	0	42	10668	16401	2020-04-02	20:05:00	https://apify.com/tugkan/covid-hu	0
c63f8c63-2be7-4582-872a-1671f1289eff	623	0	43	10668	17769	2020-04-03	04:45:00	https://apify.com/tugkan/covid-hu	0
658058df-c0c2-443d-8f06-b3e441012c17	623	0	43	10668	17769	2020-04-03	06:08:00	https://apify.com/tugkan/covid-hu	0
5085ecb4-f08b-48eb-bc30-cbd3db67db88	623	0	43	11399	17769	2020-04-03	07:05:00	https://apify.com/tugkan/covid-hu	0
9769a227-34c2-4c3b-901c-ce37f2ad1bd8	623	0	43	11399	17769	2020-04-03	07:10:00	https://apify.com/tugkan/covid-hu	0
9e30fe73-8e2b-481f-aed8-c6f6a429fe65	678	0	58	11399	19424	2020-04-04	05:15:00	https://apify.com/tugkan/covid-hu	0
76845d6d-562c-4a5d-9ab0-9225c09d42f2	678	0	58	11399	19424	2020-04-04	05:25:00	https://apify.com/tugkan/covid-hu	0
0fc15f1c-8243-4fbf-8f16-438c5761e914	678	0	58	12492	19424	2020-04-04	08:20:00	https://apify.com/tugkan/covid-hu	0
9c3848a7-be45-4f2f-8bc7-a063ea1c1eff	733	0	58	12492	21250	2020-04-05	05:15:00	https://apify.com/tugkan/covid-hu	0
22ea62e2-7f37-48f4-b95a-f8c10bbf29a2	733	0	66	13435	21250	2020-04-05	05:20:00	https://apify.com/tugkan/covid-hu	0
ff3e7ac8-8176-4526-971b-a20c8feb2bc1	744	0	67	14325	22282	2020-04-06	04:35:00	https://apify.com/tugkan/covid-hu	0
8a5b43e6-2f1b-43f2-b4ce-ddb72c026caf	817	0	71	14997	23746	2020-04-07	05:15:00	https://apify.com/tugkan/covid-hu	0
dca859cf-07aa-4c23-92b0-c0d8d1f72729	895	0	94	15481	25748	2020-04-08	04:15:00	https://apify.com/tugkan/covid-hu	0
ba77b784-a26d-4645-9364-90389c615647	895	0	94	15481	25748	2020-04-08	04:20:00	https://apify.com/tugkan/covid-hu	0
0a9538d3-c6cf-434e-861f-1c94278f5f12	895	0	94	15481	25748	2020-04-08	13:37:00	https://apify.com/tugkan/covid-hu	0
20eeddc5-6435-4c1a-8c32-ef0df48f75d8	980	0	96	15481	25748	2020-04-09	04:40:00	https://apify.com/tugkan/covid-hu	0
8f1d57b7-3228-4f7f-b6aa-fef9a7aae755	980	0	96	16006	27826	2020-04-09	04:45:00	https://apify.com/tugkan/covid-hu	0
8d9f93b5-68c6-4553-95ca-ca70e100f420	980	0	96	16006	27826	2020-04-09	04:50:00	https://apify.com/tugkan/covid-hu	0
1c1881b9-aa78-4eb3-a88f-39cd68d192eb	1190	0	112	16006	27826	2020-04-10	04:55:00	https://apify.com/tugkan/covid-hu	0
e8887878-bee7-4f1c-aa47-305bea60fe7b	1190	0	112	16006	29948	2020-04-10	05:00:00	https://apify.com/tugkan/covid-hu	0
0b61e7fd-aa7d-46db-ad55-54fb489a873b	1190	0	112	16006	29948	2020-04-10	05:05:00	https://apify.com/tugkan/covid-hu	0
0335798b-2a92-4a3d-b619-d12a6e5c356e	1310	0	115	17490	31961	2020-04-11	05:55:00	https://apify.com/tugkan/covid-hu	0
d5cb36b9-e40a-4eb2-a29a-e6b338179720	1310	0	115	17490	31961	2020-04-11	07:26:00	https://apify.com/tugkan/covid-hu	0
62bdc015-d526-4b04-8b89-6a938287e95c	1410	0	118	15333	33532	2020-04-12	05:40:00	https://apify.com/tugkan/covid-hu	0
7b020c30-32e5-4435-b6d2-2f068eae53af	1458	0	120	15333	34819	2020-04-13	05:35:00	https://apify.com/tugkan/covid-hu	0
8f453e5b-c685-475a-8aef-672dadd9f84c	1458	0	120	15333	34819	2020-04-13	05:40:00	https://apify.com/tugkan/covid-hu	0
095dc3fa-6d47-43e2-a8ae-665c64656c95	1512	0	122	14355	35825	2020-04-14	04:45:00	https://apify.com/tugkan/covid-hu	0
23961720-7072-44a7-ab16-ddb746a817d5	1579	0	192	13360	37326	2020-04-15	04:50:00	https://apify.com/tugkan/covid-hu	0
59a3280b-d288-4c77-a49a-ca6657d894f8	1579	0	192	13360	37326	2020-04-15	05:00:00	https://apify.com/tugkan/covid-hu	0
5bcc8e8b-a221-4275-844c-43da743aae69	1579	0	192	13360	37326	2020-04-15	10:45:00	https://apify.com/tugkan/covid-hu	0
a5f7ccde-6211-459b-8ea7-69b838fc1289	1652	0	192	13360	37326	2020-04-16	05:35:00	https://apify.com/tugkan/covid-hu	0
aa183de6-4bc4-4742-9716-b632f3f26c40	1652	0	199	12737	38489	2020-04-16	05:40:00	https://apify.com/tugkan/covid-hu	0
7b3be11b-b251-4154-ab26-df6c5b1f7e46	1652	0	199	12737	38489	2020-04-16	05:45:00	https://apify.com/tugkan/covid-hu	0
bc6f974e-a256-4e78-90d4-89a99b4b9251	1763	0	207	12401	41590	2020-04-17	05:20:00	https://apify.com/tugkan/covid-hu	0
074ab416-b1dc-4711-8fb2-6b3766d45446	1763	0	207	12401	41590	2020-04-17	05:35:00	https://apify.com/tugkan/covid-hu	0
73290ebd-47cf-4303-a91e-90833c667a7b	1834	0	231	12150	43901	2020-04-18	05:30:00	https://apify.com/tugkan/covid-hu	0
0dce4004-533f-4bc0-b9af-dadcb9ccdaf4	1834	0	231	12150	43901	2020-04-18	05:40:00	https://apify.com/tugkan/covid-hu	0
ea3cd054-b185-4f96-b95a-860ebf9f6670	1916	0	250	11959	46353	2020-04-19	06:30:00	https://apify.com/tugkan/covid-hu	0
503bc72d-24a2-4519-9f68-cb77aaf60f87	1984	0	267	11240	48057	2020-04-20	05:00:00	https://apify.com/tugkan/covid-hu	0
bf28c995-24d5-4da8-92c8-caa573bbe384	1984	0	267	11240	48057	2020-04-20	05:05:00	https://apify.com/tugkan/covid-hu	0
2b159aca-3f7c-4efa-af15-1c14a4f0de99	1984	0	267	11240	48057	2020-04-20	15:20:00	https://apify.com/tugkan/covid-hu	0
1b2ea457-8882-4a14-b79d-63aa0e58a96c	2098	0	287	11172	50052	2020-04-21	05:00:00	https://apify.com/tugkan/covid-hu	0
31a248b7-339e-4e3e-8f37-c01d4bc506da	2098	0	287	11172	50052	2020-04-21	05:10:00	https://apify.com/tugkan/covid-hu	0
94523867-984e-4a84-bce8-5552b9437dcb	2168	0	295	11049	52702	2020-04-22	04:35:00	https://apify.com/tugkan/covid-hu	0
7edf935e-5d29-4131-a24f-153a13ad51ac	2168	0	295	11049	52702	2020-04-22	04:45:00	https://apify.com/tugkan/covid-hu	0
1c902276-3a9b-4af1-b034-e9af35baf1b0	2168	0	295	11049	52702	2020-04-22	15:50:00	https://apify.com/tugkan/covid-hu	0
f30f1c00-0652-4272-aa2f-b4a6be6e3ac6	2284	0	390	10942	55390	2020-04-23	05:15:00	https://apify.com/tugkan/covid-hu	0
c151b395-647d-4b31-95b5-6ac76b4b7270	2284	0	390	10942	55390	2020-04-23	05:25:00	https://apify.com/tugkan/covid-hu	0
6efcc836-dee7-4130-a4d6-d5632c0fd2de	2383	0	401	10942	58251	2020-04-24	05:15:00	https://apify.com/tugkan/covid-hu	0
634757b9-ae2d-4337-80c0-59b5d3801d9e	2383	0	401	10942	58251	2020-04-24	05:25:00	https://apify.com/tugkan/covid-hu	0
3582f359-78dd-49b9-bb8a-bc9647adea51	2443	0	458	10942	60801	2020-04-25	05:05:00	https://apify.com/tugkan/covid-hu	0
88e6343f-b3ec-49c8-bc2d-57f052191a70	2443	0	458	10942	60801	2020-04-25	05:10:00	https://apify.com/tugkan/covid-hu	0
d411fbad-f40c-4e1c-b141-a1975067f046	2500	0	485	9589	63505	2020-04-26	04:40:00	https://apify.com/tugkan/covid-hu	0
c73579d0-2d6a-4b7b-b2c7-12ea9f508eb9	2500	0	485	9589	63505	2020-04-26	04:45:00	https://apify.com/tugkan/covid-hu	0
8d1f3ede-72b6-4510-9bd8-bf410ef4fd1c	2583	0	498	9829	65625	2020-04-27	04:55:00	https://apify.com/tugkan/covid-hu	0
94c85ba7-b4df-4a02-92c9-ae33ff34778e	2583	0	498	9829	65625	2020-04-27	05:00:00	https://apify.com/tugkan/covid-hu	0
721b5c37-5599-48ba-b091-c3a62ade13e6	2649	0	516	9829	65625	2020-04-28	05:10:00	https://apify.com/tugkan/covid-hu	0
b95bed04-4dab-43db-9624-4430a85234d6	2649	0	516	9889	67172	2020-04-28	05:15:00	https://apify.com/tugkan/covid-hu	0
49fc92d5-bed5-4915-ba35-ad9c57324d70	2649	0	516	9889	67172	2020-04-28	05:20:00	https://apify.com/tugkan/covid-hu	0
eb8d7d98-fdd4-4b09-8d76-1a343fb87e03	2727	0	536	9889	67172	2020-04-29	04:30:00	https://apify.com/tugkan/covid-hu	0
0e985c49-3311-447d-9452-19b67f99bdbb	2727	0	536	10071	70300	2020-04-29	04:35:00	https://apify.com/tugkan/covid-hu	0
8c6a61c0-be3a-4d88-8af3-d9277170748a	2727	0	536	10071	70300	2020-04-29	04:45:00	https://apify.com/tugkan/covid-hu	0
415115a9-3e81-4aca-b4d6-77009e38b831	2775	0	581	10199	72951	2020-04-30	04:50:00	https://apify.com/tugkan/covid-hu	0
4d5866d4-7b20-44cd-8bbf-4fbf91897fcf	2775	0	581	10199	72951	2020-04-30	04:55:00	https://apify.com/tugkan/covid-hu	0
0f2caffe-992f-4842-9000-a6db0fd2fdc6	2863	0	609	10384	76331	2020-05-01	05:05:00	https://apify.com/tugkan/covid-hu	0
abc737a1-9b66-4663-9de3-0e0040b7ae72	2863	0	609	10384	76331	2020-05-01	05:15:00	https://apify.com/tugkan/covid-hu	0
b048eb77-95fd-4202-a2d8-4759f05a5616	2863	0	609	10384	76331	2020-05-01	12:35:00	https://apify.com/tugkan/covid-hu	0
53a6b209-fc54-4f0d-8d25-488f5b429f6d	2942	0	625	10754	79551	2020-05-02	05:05:00	https://apify.com/tugkan/covid-hu	0
9bc01070-29ae-4125-a54f-cb728fcf07b4	2942	0	625	10754	79551	2020-05-02	05:15:00	https://apify.com/tugkan/covid-hu	0
538a6fda-e447-425b-9afb-bf459aa8d418	2998	0	629	10786	82010	2020-05-03	05:20:00	https://apify.com/tugkan/covid-hu	0
50332773-9316-4c94-8bac-e5997ee6c07a	2998	0	629	10786	82010	2020-05-03	05:25:00	https://apify.com/tugkan/covid-hu	0
2f01a7c2-2708-4fe4-9386-ff3248e9e766	0	0	0	0	0	2020-05-03	22:25:00	https://apify.com/tugkan/covid-hu	0
d048b8ad-47da-498e-8774-440bc9b44509	0	0	0	0	0	2020-05-04	04:45:00	https://apify.com/tugkan/covid-hu	0
b8621387-799f-4837-abcd-695506a94139	0	0	0	0	0	2020-05-04	07:30:00	https://apify.com/tugkan/covid-hu	0
c8e981e0-789c-461e-88c0-3573770c299a	0	0	0	0	0	2020-05-05	05:00:00	https://apify.com/tugkan/covid-hu	0
729a9509-20e9-40ae-9b5c-01a7e0e8bd22	0	0	0	0	0	2020-05-06	04:35:00	https://apify.com/tugkan/covid-hu	0
9b2fc8f6-17ba-441b-981a-924282e888c4	0	0	0	0	0	2020-05-06	09:00:00	https://apify.com/tugkan/covid-hu	0
8a583997-00c3-4dc4-bfcc-d411259849f0	0	0	0	0	0	2020-05-07	04:50:00	https://apify.com/tugkan/covid-hu	0
6215670e-bdd3-42c1-9e13-dbe1a55b21ae	0	0	0	0	0	2020-05-08	04:55:00	https://apify.com/tugkan/covid-hu	0
e980db5b-4ea6-40e5-b38e-18acdb16155f	1921	392	865	11036	99058	2020-05-08	15:55:00	https://apify.com/tugkan/covid-hu	0
3f51d11f-f03c-4099-b31d-d2533e7fa332	1904	405	904	10927	103258	2020-05-09	05:00:00	https://apify.com/tugkan/covid-hu	0
7adca7cd-ca9a-4d1a-866c-055c040c1916	1917	413	933	10356	108257	2020-05-10	05:05:00	https://apify.com/tugkan/covid-hu	0
2cf346ff-f0cc-4c25-afae-db82ac643780	1905	421	958	10955	112165	2020-05-11	04:35:00	https://apify.com/tugkan/covid-hu	0
d100c1e4-ca87-43ab-b86d-e45240c00074	1881	425	1007	11016	114719	2020-05-12	04:45:00	https://apify.com/tugkan/covid-hu	0
491c1f2f-d382-485e-9f45-8e62ff46265c	1809	430	1102	11053	118500	2020-05-13	05:20:00	https://apify.com/tugkan/covid-hu	0
95c0eecf-21f7-4812-8de8-80f27686c9d7	1775	436	1169	11084	123258	2020-05-14	04:50:00	https://apify.com/tugkan/covid-hu	0
5174243b-032b-43cc-886e-6aa7335a1aa9	1775	436	1169	11084	123258	2020-05-14	07:25:00	https://apify.com/tugkan/covid-hu	0
d748a9c5-2376-4bef-a606-1049169f54b8	1688	442	1287	10954	127237	2020-05-15	05:15:00	https://apify.com/tugkan/covid-hu	0
6c5a57a8-1c2d-47a9-9ab7-21844a80d474	1654	448	1371	10742	131429	2020-05-16	05:35:00	https://apify.com/tugkan/covid-hu	0
cd4cc201-73b0-45c7-a7c9-e16ee5f3de1b	1662	451	1396	10470	135137	2020-05-17	05:00:00	https://apify.com/tugkan/covid-hu	0
fa86d429-20fe-4cc0-865e-ac7caff49abb	1673	462	1400	10388	137243	2020-05-18	04:55:00	https://apify.com/tugkan/covid-hu	0
dd5642ac-3658-4d33-b33f-6757ea1991d5	1673	462	1400	10388	137243	2020-05-18	07:45:00	https://apify.com/tugkan/covid-hu	0
0a5b1ac8-a1a2-4bbd-9541-b5213303e599	1677	467	1412	10394	138697	2020-05-19	05:10:00	https://apify.com/tugkan/covid-hu	0
f2212c97-bd78-4742-9aba-b3348e88a579	1674	470	1454	10931	142729	2020-05-20	05:10:00	https://apify.com/tugkan/covid-hu	0
72c970d2-150b-457e-9150-fa6335336de0	1674	470	1454	10931	142729	2020-05-20	05:15:00	https://apify.com/tugkan/covid-hu	0
e0f14ddd-bf25-4d88-8ad8-7aab16163073	1674	470	1454	10931	142729	2020-05-20	05:30:00	https://apify.com/tugkan/covid-hu	0
a174a523-c2a5-4b3e-bee7-ae896a5e2f65	1659	473	1509	11103	147511	2020-05-21	04:50:00	https://apify.com/tugkan/covid-hu	0
931fb392-e565-4abf-b417-2f292ad33ebd	1615	476	1587	11668	155801	2020-05-22	04:45:00	https://apify.com/tugkan/covid-hu	0
c2cee84e-6ef5-4542-9138-748580f33fb3	1576	482	1655	11704	159260	2020-05-23	05:05:00	https://apify.com/tugkan/covid-hu	0
af817fd7-17d6-4e4c-94ce-42b98e71fc91	1565	486	1690	11934	162925	2020-05-24	05:00:00	https://apify.com/tugkan/covid-hu	0
7d426d2f-d30f-478a-b731-a3849eb96bdf	1554	491	1711	11810	164619	2020-05-25	04:50:00	https://apify.com/tugkan/covid-hu	0
24d5e329-be49-4b26-931d-e3adf802aeb1	1554	491	1711	11810	164619	2020-05-25	12:35:00	https://apify.com/tugkan/covid-hu	0
3662a6bd-80b1-4051-8376-9445ae55453c	1436	499	1836	11611	166263	2020-05-26	05:10:00	https://apify.com/tugkan/covid-hu	0
82a743f3-c0f4-460d-8dd1-495e6b57f813	1432	505	1856	11616	169960	2020-05-27	05:00:00	https://apify.com/tugkan/covid-hu	0
1bfd0158-37eb-4a70-a761-9d652e594aed	1311	509	1996	11525	174011	2020-05-28	05:00:00	https://apify.com/tugkan/covid-hu	0
f9e6002b-e09e-486a-9056-b5c982adefc5	1300	517	2024	10763	180152	2020-05-29	05:20:00	https://apify.com/tugkan/covid-hu	0
9ce28338-aa79-475c-87b0-4676eebf8dbc	1300	517	2024	10763	180152	2020-05-29	05:25:00	https://apify.com/tugkan/covid-hu	0
4742ad49-b525-4aaf-bf33-ff795442dadf	3841	517	2024	10763	180152	2020-05-29	07:40:00	https://apify.com/tugkan/covid-hu	1300
4a32cfc8-e882-45a0-9d61-066fb86fb46a	3867	524	2142	11408	183562	2020-05-30	06:35:00	https://apify.com/tugkan/covid-hu	1201
3891eb40-53d4-4eed-a451-6a455fb2f051	3876	526	2147	11540	185980	2020-05-31	06:50:00	https://apify.com/tugkan/covid-hu	1203
55b4f011-055f-4d20-b07d-00b38764ef03	3892	527	2156	11226	187965	2020-06-01	06:20:00	https://apify.com/tugkan/covid-hu	1209
4dcf061e-b53f-455c-8cac-3f090dfa1999	3892	527	2156	11226	187965	2020-06-01	07:55:00	https://apify.com/tugkan/covid-hu	1209
220230fd-0741-46d8-8c5b-c4a3d69511fd	3921	532	2160	11159	189969	2020-06-02	06:45:00	https://apify.com/tugkan/covid-hu	1229
79c585ff-6f73-46dc-b41a-721d64da0148	3931	534	2190	11172	191572	2020-06-03	06:45:00	https://apify.com/tugkan/covid-hu	1207
c4093b23-5746-45be-90af-2cf801f78d69	3954	539	2205	10985	195894	2020-06-04	07:25:00	https://apify.com/tugkan/covid-hu	1210
7f400a20-1539-43c4-b2b3-ae38f0badeac	3954	539	2205	10985	195894	2020-06-04	08:30:00	https://apify.com/tugkan/covid-hu	1210
9bed30b0-b1bd-45fe-a5b3-8de31f7b401f	3970	542	2245	9693	202606	2020-06-05	06:25:00	https://apify.com/tugkan/covid-hu	1183
3aeeb2d8-a9a3-4670-bab2-275c930ba791	3990	545	2279	10133	206853	2020-06-06	07:10:00	https://apify.com/tugkan/covid-hu	1166
90ee35e5-732c-4e96-a0e8-a5452f7df72f	4008	546	2279	9916	210202	2020-06-07	08:00:00	https://apify.com/tugkan/covid-hu	1183
f276039a-c71e-4e5e-86e7-7e518051e629	4014	548	2284	9665	210749	2020-06-08	06:30:00	https://apify.com/tugkan/covid-hu	1182
1b147f3f-2747-4dac-9de7-cf0f8470e67a	4017	550	2324	9523	214468	2020-06-09	06:30:00	https://apify.com/tugkan/covid-hu	1143
14ead77e-b3e8-4762-81bd-95409df9d75a	4027	551	2355	8805	217689	2020-06-10	06:35:00	https://apify.com/tugkan/covid-hu	1121
ac1b8060-6111-4394-b6c1-9ea4afe33e61	4039	553	2391	9167	222247	2020-06-11	06:50:00	https://apify.com/tugkan/covid-hu	1095
6849fc8c-cf54-4c51-ac01-540643664882	4053	555	2447	8834	226669	2020-06-12	06:30:00	https://apify.com/tugkan/covid-hu	1051
d1d671e6-6620-4ba3-aa24-10c422c284d1	4064	559	2476	8472	230139	2020-06-13	06:45:00	https://apify.com/tugkan/covid-hu	1029
60f5a4be-e095-475f-87d1-ffe11295e2e6	4069	562	2482	7287	233742	2020-06-14	07:00:00	https://apify.com/tugkan/covid-hu	1025
1a458ec1-fb28-4ba5-98f0-ff04b15ff1e9	4076	563	2485	7707	235377	2020-06-15	06:10:00	https://apify.com/tugkan/covid-hu	1028
dfb8b07a-d0ee-48ff-88e7-56aa9454d8ee	4077	565	2516	7545	236828	2020-06-16	06:35:00	https://apify.com/tugkan/covid-hu	996
9e93ca0a-534b-4ad9-86eb-5f7ad93fa7b2	4078	567	2547	7545	242139	2020-06-17	06:50:00	https://apify.com/tugkan/covid-hu	964
18201809-5873-44d6-b85b-84f57111bda4	4079	568	2564	7092	245598	2020-06-18	06:40:00	https://apify.com/tugkan/covid-hu	947
f46881db-5a93-4c5f-ba4d-2e706a3acdbd	4081	568	2581	6310	249391	2020-06-19	06:55:00	https://apify.com/tugkan/covid-hu	932
0a8dec22-9a99-4cfc-9550-039be997ba23	4086	570	2585	3944	253100	2020-06-20	06:35:00	https://apify.com/tugkan/covid-hu	931
11a32da8-9a08-4e1d-8c3c-b455b5c94c8d	4094	570	2589	4490	256326	2020-06-21	07:00:00	https://apify.com/tugkan/covid-hu	935
939a82bb-17d5-4207-b642-69a189408474	4094	570	2589	4490	256326	2020-06-21	07:05:00	https://apify.com/tugkan/covid-hu	935
2c533b86-3309-4554-a4f3-2157c3d6d92a	4102	572	2590	3528	258115	2020-06-22	06:45:00	https://apify.com/tugkan/covid-hu	940
3ea36bbf-547f-4d46-bbfb-e736de9003ca	4107	573	2600	4193	258861	2020-06-23	05:55:00	https://apify.com/tugkan/covid-hu	934
9a881465-a994-4153-9dee-f31b317d6512	4114	576	2618	3705	261420	2020-06-24	07:30:00	https://apify.com/tugkan/covid-hu	920
d8974e31-c643-45a7-be6d-bce614221ffb	4123	577	2640	3041	265129	2020-06-25	06:00:00	https://apify.com/tugkan/covid-hu	906
f4ceb653-ef7e-4fc7-b164-198127196943	4127	578	2663	2801	267056	2020-06-26	06:55:00	https://apify.com/tugkan/covid-hu	886
5902bc55-d9e4-408a-bb19-35893742d14a	4138	578	2681	2681	270263	2020-06-27	07:25:00	https://apify.com/tugkan/covid-hu	879
9a01a328-feb4-44f0-8b0e-8edbc447d38c	4142	581	2685	2551	271194	2020-06-28	07:25:00	https://apify.com/tugkan/covid-hu	876
3ded425f-2981-410d-8d5a-f9bb233e7943	4145	585	2685	1763	273897	2020-06-29	06:50:00	https://apify.com/tugkan/covid-hu	875
7ac15f65-a207-4f0b-b039-15c9f4dd48a6	4155	585	2692	1763	274945	2020-06-30	06:30:00	https://apify.com/tugkan/covid-hu	878
51a1750f-5372-403a-a5e1-48f513843822	4155	585	2692	1783	274945	2020-06-30	06:35:00	https://apify.com/tugkan/covid-hu	878
be398658-11e7-46d4-907b-608202fb379f	4157	586	2714	1412	277750	2020-07-01	07:30:00	https://apify.com/tugkan/covid-hu	857
9cc7d91a-a7ce-45bf-999c-b36ceeee04b9	4166	587	2721	1201	279690	2020-07-02	07:15:00	https://apify.com/tugkan/covid-hu	858
5e608148-910c-4941-a37b-52acd1143d03	4172	588	2752	1217	281628	2020-07-03	07:25:00	https://apify.com/tugkan/covid-hu	832
383d835f-92f7-464f-b455-583134237c7b	4174	589	2784	1252	283508	2020-07-04	06:55:00	https://apify.com/tugkan/covid-hu	801
6eca10c6-dc4e-4ae3-9bee-daef51aaf0c3	4183	589	2811	1348	285590	2020-07-05	06:20:00	https://apify.com/tugkan/covid-hu	783
701879ae-4225-4687-9941-0b3742b02ff2	4189	589	2860	1675	286083	2020-07-06	07:15:00	https://apify.com/tugkan/covid-hu	740
5273cbac-8c5e-4f68-8ffb-7a021b7b17e0	4205	589	2874	1658	286983	2020-07-07	07:20:00	https://apify.com/tugkan/covid-hu	742
943695d5-14f2-4c8b-9abc-26a9f53c0644	4210	589	2885	1909	288693	2020-07-08	05:55:00	https://apify.com/tugkan/covid-hu	736
daf80a37-bf31-4baf-bbd1-8d040d242ca9	4220	591	2887	2123	289602	2020-07-09	07:20:00	https://apify.com/tugkan/covid-hu	742
14c807b3-c35b-4380-8c7f-ee1fbb2ca602	4223	593	2941	2196	292032	2020-07-10	06:50:00	https://apify.com/tugkan/covid-hu	689
38209697-bb94-4c8b-a64f-dc6ce4068a6d	4229	595	2974	2409	293220	2020-07-11	06:20:00	https://apify.com/tugkan/covid-hu	660
203e3270-0800-4959-9f21-728a7ffb7e57	4229	595	2974	2409	293220	2020-07-11	06:25:00	https://apify.com/tugkan/covid-hu	660
a6383adf-1501-4a40-941c-6961aee10ea0	4234	595	3036	2322	294425	2020-07-12	06:50:00	https://apify.com/tugkan/covid-hu	603
0846b9f2-a1cc-4089-afc2-405bf9a190e7	4247	595	3073	2453	295561	2020-07-13	06:45:00	https://apify.com/tugkan/covid-hu	579
b3683f9a-caae-4cc7-b9e5-e8ff6becea69	4247	595	3073	2453	295561	2020-07-13	06:50:00	https://apify.com/tugkan/covid-hu	579
af890363-7cc7-4483-85af-0b2a30b5899b	4258	595	3106	2782	296358	2020-07-14	07:10:00	https://apify.com/tugkan/covid-hu	557
6171a942-ac23-4adc-af61-89bf0f68fdb6	4263	595	3127	2979	299185	2020-07-15	06:45:00	https://apify.com/tugkan/covid-hu	541
767782a2-03bb-4b80-a759-13ef9694805c	4263	595	3127	2979	299185	2020-07-15	06:50:00	https://apify.com/tugkan/covid-hu	541
49e99bd8-3e16-46d3-80af-d21a6174a032	4279	595	3156	3701	300632	2020-07-16	06:40:00	https://apify.com/tugkan/covid-hu	528
aa4eb965-8acb-4aa5-a589-adcc4b492002	4293	595	3220	4213	302749	2020-07-17	07:05:00	https://apify.com/tugkan/covid-hu	478
d2cf5814-6cd9-48c1-ad7e-0b17ea59abb2	4315	596	3222	4953	305133	2020-07-18	07:15:00	https://apify.com/tugkan/covid-hu	497
f7d5970f-ac35-4cd4-9e47-6f13e5deea8e	4333	596	3223	5486	307846	2020-07-19	06:55:00	https://apify.com/tugkan/covid-hu	514
900ab174-dffb-47ad-9da1-87dbc31451a3	4339	596	3232	5710	310070	2020-07-20	06:30:00	https://apify.com/tugkan/covid-hu	511
977e39a2-e579-487d-922a-82859af4737b	4347	596	3257	6388	310930	2020-07-21	06:15:00	https://apify.com/tugkan/covid-hu	494
ebe35234-fd72-49ed-a3ab-f2951061dba6	4366	596	3283	6553	312988	2020-07-22	06:40:00	https://apify.com/tugkan/covid-hu	487
20123fdb-3da6-4746-adc2-0ac7db3575ac	4380	596	3300	7001	316120	2020-07-23	07:15:00	https://apify.com/tugkan/covid-hu	484
d13a9526-abaf-48b8-81e3-4b1a1e33943b	4398	596	3312	7318	319854	2020-07-24	06:25:00	https://apify.com/tugkan/covid-hu	490
be751e47-6a59-440b-862e-a90ee35f1532	4424	596	3324	7453	323673	2020-07-25	06:50:00	https://apify.com/tugkan/covid-hu	504
c03c4298-2bde-44e7-b7ac-9064b740a28c	4424	596	3324	7453	323673	2020-07-25	06:55:00	https://apify.com/tugkan/covid-hu	504
033872ac-31a6-4bef-9272-72d9945cab4f	4435	596	3329	7824	326554	2020-07-26	06:45:00	https://apify.com/tugkan/covid-hu	510
589fca12-c30d-48a9-8eb0-5992701750f7	4448	596	3329	8490	328583	2020-07-27	06:35:00	https://apify.com/tugkan/covid-hu	523
c63937e7-f5b5-4537-9094-cc5b3e6283e8	4456	596	3331	8970	330239	2020-07-28	07:25:00	https://apify.com/tugkan/covid-hu	529
c96eb75b-43c0-48bb-a03a-f64623aa5a65	4465	596	3339	8683	333446	2020-07-29	06:50:00	https://apify.com/tugkan/covid-hu	530
067b9b8a-0066-47e8-bb98-faa339015344	4484	596	3346	7819	336461	2020-07-30	07:20:00	https://apify.com/tugkan/covid-hu	542
ab05c0df-50ba-4a3e-b7e0-b4dffad42f44	4505	596	3353	8083	339163	2020-07-31	07:45:00	https://apify.com/tugkan/covid-hu	556
1bdce930-29c1-411e-839c-6315ba1c144e	4526	597	3364	7782	342887	2020-08-01	06:35:00	https://apify.com/tugkan/covid-hu	565
9f1f834d-d9e2-4f0d-b191-6fbcabd4fde7	4535	597	3389	7436	344997	2020-08-02	07:15:00	https://apify.com/tugkan/covid-hu	549
93b4091e-e826-42c9-8f5f-706b6d60d155	4544	597	3413	7657	346962	2020-08-03	06:20:00	https://apify.com/tugkan/covid-hu	534
616dd551-044e-4e0b-a243-edb406bf2a1b	4553	598	3415	7742	348132	2020-08-04	07:00:00	https://apify.com/tugkan/covid-hu	540
3cdcbe98-77a0-4b93-92bc-76ce4d778859	4564	599	3431	6858	350108	2020-08-05	08:50:00	https://apify.com/tugkan/covid-hu	534
5003e0cf-62e9-4870-88fb-e011257896ae	4597	600	3463	7227	352546	2020-08-06	06:55:00	https://apify.com/tugkan/covid-hu	534
71d81bcd-b256-4b81-a6b4-8c7f63a4d0f4	4621	602	3464	7092	355467	2020-08-07	07:58:00	https://apify.com/tugkan/covid-hu	555
4eb879f7-8627-40b2-b73e-552536843e15	4653	602	3491	7092	358437	2020-08-08	07:10:00	https://apify.com/tugkan/covid-hu	560
3c3b7be3-8829-49f6-8189-3b8f4e617b96	4653	602	3491	6783	358437	2020-08-08	07:20:00	https://apify.com/tugkan/covid-hu	560
f71ea914-10cf-47f7-afe3-242b55614088	4696	602	3499	7184	360772	2020-08-09	07:20:00	https://apify.com/tugkan/covid-hu	595
47797778-527e-4ae0-86e1-b6f1b93551f0	4731	605	3525	7574	362660	2020-08-10	07:25:00	https://apify.com/tugkan/covid-hu	601
a8424ca9-2e4f-48f4-abeb-87fab544b419	4746	605	3527	7492	363459	2020-08-11	07:10:00	https://apify.com/tugkan/covid-hu	614
157f6e89-c407-43ca-8882-ca5796db5a60	4746	605	3527	7492	363459	2020-08-11	11:10:00	https://apify.com/tugkan/covid-hu	614
7449ddbd-4de9-4c0c-a61a-19e7f652bfb2	4768	605	3529	7730	366356	2020-08-12	07:20:00	https://apify.com/tugkan/covid-hu	634
7d4177d2-dddb-4bb1-a50d-fd28270fcafd	4813	607	3561	7613	369545	2020-08-13	07:20:00	https://apify.com/tugkan/covid-hu	645
6e2e2e4c-e206-43fe-b1c5-28a83b3f04c6	4853	607	3590	7707	372687	2020-08-14	07:10:00	https://apify.com/tugkan/covid-hu	656
e9e206bc-53c9-4e69-8ccf-fbd9851b9934	4877	607	3606	8526	375685	2020-08-15	07:10:00	https://apify.com/tugkan/covid-hu	664
82f8c97f-942d-4f06-9152-e976b1fa3a68	4916	608	3623	8104	378608	2020-08-16	07:35:00	https://apify.com/tugkan/covid-hu	685
0b4e6c9b-b3aa-4efb-ae7d-e4673298f549	4946	608	3630	8188	380932	2020-08-17	06:45:00	https://apify.com/tugkan/covid-hu	708
b7ac37cc-b78b-4547-8889-dd2c4dc1b281	4970	609	3631	8098	383411	2020-08-18	06:45:00	https://apify.com/tugkan/covid-hu	730
f93f2084-eea2-43db-b58a-cdf13b535e0c	5002	609	3665	7806	387111	2020-08-19	06:55:00	https://apify.com/tugkan/covid-hu	728
1bc4e5b9-699c-41f2-9444-8f370ed9073c	5046	609	3678	7663	390079	2020-08-20	06:45:00	https://apify.com/tugkan/covid-hu	759
cc216eac-fda6-4dfd-8b07-c0c9c9f5038c	5098	611	3681	7543	393431	2020-08-21	07:00:00	https://apify.com/tugkan/covid-hu	806
d304389b-2f0b-4544-989e-b641a2789bb1	5133	611	3692	7118	394911	2020-08-22	06:55:00	https://apify.com/tugkan/covid-hu	830
6028f446-be9f-4c98-8ed2-d4065cfba0c3	5155	613	3695	7420	397092	2020-08-23	07:15:00	https://apify.com/tugkan/covid-hu	847
e5289ffb-c4a0-441b-8a5c-e9e4767d335d	5191	613	3695	7917	398550	2020-08-24	06:57:00	https://apify.com/tugkan/covid-hu	883
be0c25eb-a5c5-40b9-aab3-7570f744cd68	5215	614	3716	7284	400442	2020-08-25	07:00:00	https://apify.com/tugkan/covid-hu	885
9543a5d1-eab4-453b-af96-2d285aff69ae	5288	614	3734	7707	405067	2020-08-26	06:55:00	https://apify.com/tugkan/covid-hu	940
74252f33-ed76-40aa-a8b2-2037044b82a1	5379	614	3757	7707	405067	2020-08-27	07:05:00	https://apify.com/tugkan/covid-hu	1008
846dbd7a-f4f4-43bf-b59b-4999084d81ac	5379	614	3757	7654	408799	2020-08-27	16:25:00	https://apify.com/tugkan/covid-hu	1008
97ccdfca-3d72-4601-bf90-d68e0c4d162a	5511	614	3759	8008	414645	2020-08-28	06:55:00	https://apify.com/tugkan/covid-hu	1138
af3aeb07-6266-406d-836e-0e2f86e2000d	5669	614	3759	8191	417890	2020-08-29	07:35:00	https://apify.com/tugkan/covid-hu	1296
eed36062-2a74-406a-9d7b-0a1c6fcec106	5961	614	3759	8633	424270	2020-08-30	07:45:00	https://apify.com/tugkan/covid-hu	1588
b6b632d6-5554-4c6d-9fbd-0b04dd849a15	6139	615	3761	8982	428150	2020-08-31	06:20:00	https://apify.com/tugkan/covid-hu	1763
b90fd866-4bed-4e43-b8c9-6770f83f098b	6139	615	3761	8982	428150	2020-08-31	06:25:00	https://apify.com/tugkan/covid-hu	1763
6fcca3be-4438-4cb2-8747-6720b5b10468	6257	616	3821	10124	429942	2020-09-01	06:40:00	https://apify.com/tugkan/covid-hu	1820
37582240-b21e-4f4d-990d-e83723f2aa5a	6622	619	3903	11485	437531	2020-09-02	06:30:00	https://apify.com/tugkan/covid-hu	2100
744324e1-6924-44f5-acad-a280a738afb6	6923	620	3930	12608	445047	2020-09-03	06:30:00	https://apify.com/tugkan/covid-hu	2373
0570732c-0bc2-4ade-b3c1-b5bee4088687	7382	621	3944	14619	452138	2020-09-04	07:15:00	https://apify.com/tugkan/covid-hu	2817
ad61a308-1ff2-425f-950a-3c9591fa9cac	7892	624	3952	16438	460235	2020-09-05	06:15:00	https://apify.com/tugkan/covid-hu	3316
c38249be-5e15-40f3-aa65-65ec2d2691ba	8387	624	3952	18480	470000	2020-09-06	07:40:00	https://apify.com/tugkan/covid-hu	3811
6023f618-a2fa-40a2-8363-f9d268bdbfef	8963	625	3961	21756	481424	2020-09-07	07:20:00	https://apify.com/tugkan/covid-hu	4377
6d9a5a47-d253-4f49-8cef-3e44d4df0d7d	9304	626	3972	23318	487146	2020-09-08	06:50:00	https://apify.com/tugkan/covid-hu	4706
e502a0fa-6864-4630-9476-85b76e035187	9715	628	3984	23461	495481	2020-09-09	06:35:00	https://apify.com/tugkan/covid-hu	5103
116e0901-a71e-4da9-9883-6ca10ebb5caf	10191	630	3990	25043	505585	2020-09-10	06:45:00	https://apify.com/tugkan/covid-hu	5571
b04d32e7-0afa-4dde-b8a2-2ce191a414d5	10191	630	3990	25043	505585	2020-09-10	06:50:00	https://apify.com/tugkan/covid-hu	5571
9efb7c74-65a4-4de6-9ca5-a18012afa345	10909	631	4014	25117	517222	2020-09-11	06:55:00	https://apify.com/tugkan/covid-hu	6264
9293ad26-3985-4e26-a60f-5f3884e60d3d	11825	633	4058	25569	529063	2020-09-12	06:45:00	https://apify.com/tugkan/covid-hu	7134
1ded52cd-b16b-4511-988b-662a1f44cb5f	12309	637	4069	26531	537897	2020-09-13	07:25:00	https://apify.com/tugkan/covid-hu	7603
4390fe4a-a547-4a0e-8210-6b50abdaebdf	13153	642	4117	26668	549211	2020-09-14	07:05:00	https://apify.com/tugkan/covid-hu	8394
e26b6c92-2c99-44a3-a85f-93a9cf45c553	13879	646	4130	28584	557864	2020-09-15	06:55:00	https://apify.com/tugkan/covid-hu	9103
5600c0a8-d10d-40ea-ba29-d5f02fb18c5a	14460	654	4153	29005	567691	2020-09-16	06:40:00	https://apify.com/tugkan/covid-hu	9653
aed59a75-0205-4f63-b24e-35adca9dcdcd	14460	654	4153	29005	567691	2020-09-16	11:00:00	https://apify.com/tugkan/covid-hu	9653
f1ec7d89-ee91-412c-b549-f8d18f96882b	15170	663	4227	28920	580072	2020-09-17	07:25:00	https://apify.com/tugkan/covid-hu	10280
c973b55e-3f22-417a-977d-631af1e9ac74	16111	669	4240	27866	591618	2020-09-18	06:45:00	https://apify.com/tugkan/covid-hu	11202
9f87c2fd-1b8a-468d-bd5c-356aba435fec	16920	675	4382	28527	604122	2020-09-19	07:00:00	https://apify.com/tugkan/covid-hu	11863
a06061a4-552d-4143-a97b-0ff48e426fbb	17990	683	4391	25583	615999	2020-09-20	06:55:00	https://apify.com/tugkan/covid-hu	12916
9fab606c-e4b8-4e37-8377-60babc417054	18866	686	4401	26750	626021	2020-09-21	07:35:00	https://apify.com/tugkan/covid-hu	13779
9acf6b84-863a-4f45-a785-9c55c737fe2a	19499	694	4559	25212	632031	2020-09-22	07:20:00	https://apify.com/tugkan/covid-hu	14246
9a9914d7-fb83-4637-84a2-13c1c794fbd8	20450	702	4644	27449	645492	2020-09-23	07:10:00	https://apify.com/tugkan/covid-hu	15104
d865c259-21fb-4c46-98e9-20951c270075	21200	709	4818	27403	657437	2020-09-24	06:35:00	https://apify.com/tugkan/covid-hu	15673
98209c53-e684-4022-bd9c-f15cbc1ab172	22127	718	4945	25374	668553	2020-09-25	06:50:00	https://apify.com/tugkan/covid-hu	16464
68cba16f-52cf-4010-aeea-44e39e1ce598	23077	730	5099	25017	680335	2020-09-26	07:00:00	https://apify.com/tugkan/covid-hu	17248
ea5f16f6-6315-485c-9045-1ec610d3a167	24014	736	5141	24538	690408	2020-09-27	07:30:00	https://apify.com/tugkan/covid-hu	18137
69506619-04d1-40e9-a461-92e073dd74b1	24716	749	5152	24017	697473	2020-09-28	05:42:00	https://apify.com/tugkan/covid-hu	18815
5a270cf9-2c96-4bf6-b068-f9e5d8f1f96a	25567	757	5173	23740	704510	2020-09-29	06:55:00	https://apify.com/tugkan/covid-hu	19637
61d9cfbd-e43f-4af9-b118-77516a798187	26461	765	5890	24121	715677	2020-09-30	07:20:00	https://apify.com/tugkan/covid-hu	19806
8340ad59-18f1-445b-9940-c35240e88c1a	27309	781	6118	21930	727649	2020-10-01	07:00:00	https://apify.com/tugkan/covid-hu	20410
66e43a08-2fd5-4a76-b918-5df8f6f83ab4	28631	798	6349	22906	740043	2020-10-02	06:40:00	https://apify.com/tugkan/covid-hu	21484
0f6c39a5-1673-4f20-8490-24c5a8efb7a4	29717	812	6824	22749	751217	2020-10-03	07:10:00	https://apify.com/tugkan/covid-hu	22081
a28a981a-1bb3-4c6d-8c6f-07ece232a747	30575	822	7470	19923	759174	2020-10-04	07:30:00	https://apify.com/tugkan/covid-hu	22283
593e576e-7c34-4ef1-b5a2-105a660b1b1f	30575	822	7470	19923	759174	2020-10-04	07:42:00	https://apify.com/tugkan/covid-hu	22283
688e413d-942a-4207-ba5d-2ad2b4b3b6e6	31480	833	8165	20199	765598	2020-10-05	06:45:00	https://apify.com/tugkan/covid-hu	22482
93d03f8d-3bd5-44a0-ae60-d1a27a96a35f	32298	853	8723	20088	771297	2020-10-06	06:40:00	https://apify.com/tugkan/covid-hu	22722
878f99d0-6246-43b0-8369-67819d32d4ba	33114	877	9149	20319	781023	2020-10-07	07:30:00	https://apify.com/tugkan/covid-hu	23088
5569c9be-92da-4d6c-bff0-b3d2f9707e07	34046	898	9187	20217	792485	2020-10-08	07:05:00	https://apify.com/tugkan/covid-hu	23961
89860597-39a0-45d0-a0b0-f911f134116a	35222	913	9202	22385	803648	2020-10-09	07:00:00	https://apify.com/tugkan/covid-hu	25107
aa06e943-3a94-43a0-bb55-12f1c45d4ff4	36596	933	9683	22780	815367	2020-10-10	06:50:00	https://apify.com/tugkan/covid-hu	25980
5b59717c-32b5-4cd4-bd57-b4416ccd3593	37664	954	10848	22215	825570	2020-10-11	07:00:00	https://apify.com/tugkan/covid-hu	25862
3f3c0138-6a86-4bbb-b3ab-f12819f54f9b	38837	968	11037	21491	834097	2020-10-12	06:41:00	https://apify.com/tugkan/covid-hu	26832
5574991d-25e7-489a-9618-e20763dd915b	39862	996	11753	21990	841220	2020-10-13	06:35:00	https://apify.com/tugkan/covid-hu	27113
72962bc5-b45c-449f-bd2b-561a3648aa5f	39862	996	11753	21990	841220	2020-10-13	06:40:00	https://apify.com/tugkan/covid-hu	27113
6cd5db33-8517-488f-9c4b-36d68834a672	40782	1023	12164	23815	850878	2020-10-14	06:45:00	https://apify.com/tugkan/covid-hu	27595
69967d7e-873e-472a-8233-b4f95c4a8151	40782	1023	12164	23815	850878	2020-10-14	06:50:00	https://apify.com/tugkan/covid-hu	27595
6231098d-77ec-4fae-8511-9cbf676ba872	41732	1052	12628	24710	861620	2020-10-15	06:55:00	https://apify.com/tugkan/covid-hu	28052
39ac1731-9088-4847-b640-cdf4ddd99fee	43025	1085	13134	22656	871417	2020-10-16	06:55:00	https://apify.com/tugkan/covid-hu	28806
47c8857d-1cb8-42f2-8f1c-15619c6cf7c2	44816	1109	13580	25647	884388	2020-10-17	07:25:00	https://apify.com/tugkan/covid-hu	30127
9a520c9e-4628-4627-ade3-29c346542cb3	46290	1142	14088	25734	894385	2020-10-18	07:10:00	https://apify.com/tugkan/covid-hu	31060
e9f86f9f-7583-48c3-9e4c-b4ce8687af04	47768	1173	14312	24929	904036	2020-10-19	06:45:00	https://apify.com/tugkan/covid-hu	32283
db6b9c48-740b-4892-9088-301738517259	48757	1211	14637	24780	910368	2020-10-20	07:05:00	https://apify.com/tugkan/covid-hu	32909
69d4dd9d-150f-4750-a52c-3c7779dab89c	50180	1259	14905	25203	919481	2020-10-21	07:20:00	https://apify.com/tugkan/covid-hu	34016
66053a7a-2592-4cb4-9bd2-da1d1c88bd3f	52212	1305	15254	24764	935842	2020-10-22	06:50:00	https://apify.com/tugkan/covid-hu	35653
0d513b4c-fe4e-4d16-9339-029003aac80c	54278	1352	15655	28261	949470	2020-10-23	07:05:00	https://apify.com/tugkan/covid-hu	37271
2bb0b61f-67ca-4791-a085-8bb8fb986872	56098	1390	16007	27859	961441	2020-10-24	07:30:00	https://apify.com/tugkan/covid-hu	38701
3d442a20-320e-45f6-8d01-2de9edf2cb8f	56098	1390	16007	27859	961441	2020-10-24	07:35:00	https://apify.com/tugkan/covid-hu	38701
b98b1ec8-b924-4c04-93b1-69f33dbddcec	59247	1425	16242	27883	980373	2020-10-25	08:35:00	https://apify.com/tugkan/covid-hu	41580
dd3c7946-6471-40a0-9002-913194d20b21	61563	1472	16491	28070	990383	2020-10-26	07:50:00	https://apify.com/tugkan/covid-hu	43600
c730fe5a-83c7-43bb-b4b4-5484469d3124	63642	1535	16646	27050	1002093	2020-10-27	08:15:00	https://apify.com/tugkan/covid-hu	45461
2f265121-83b0-4cd1-84f9-69b046bd96ff	65933	1578	17098	36678	1017689	2020-10-28	07:55:00	https://apify.com/tugkan/covid-hu	47257
bd71fb5b-302d-4463-9468-ccd58bfba421	65933	1578	17098	26678	1017689	2020-10-28	09:40:00	https://apify.com/tugkan/covid-hu	47257
20629b28-2728-4881-961c-0bac51104e8c	68127	1634	17469	25585	1032942	2020-10-29	07:50:00	https://apify.com/tugkan/covid-hu	49024
445aabbc-71e4-41a1-babc-802118ae4954	71413	1699	17953	26396	1048580	2020-10-30	07:35:00	https://apify.com/tugkan/covid-hu	51761
96440a97-cb64-49f4-aea9-1d8c6a83311b	75321	1750	19032	28596	1065143	2020-10-31	09:40:00	https://apify.com/tugkan/covid-hu	54539
34219828-ec93-4ad0-85b6-727edd819990	79199	1819	20078	29635	1083743	2020-11-01	08:05:00	https://apify.com/tugkan/covid-hu	57302
c981f6d4-2b1a-4c3b-a162-1c70814e7f75	82780	1889	20476	29750	1097371	2020-11-02	07:50:00	https://apify.com/tugkan/covid-hu	60415
7dd654ce-cfe8-4316-9e95-143f220e8959	86769	1973	20856	30984	1111991	2020-11-03	08:15:00	https://apify.com/tugkan/covid-hu	63940
caa11e9d-3ecd-4488-a3aa-14f70b616d29	90988	2063	21232	32743	1129648	2020-11-04	08:15:00	https://apify.com/tugkan/covid-hu	67693
c6c2ded1-2733-495a-b3b2-92cc10db36a7	94916	2147	22823	34603	1147616	2020-11-05	08:05:00	https://apify.com/tugkan/covid-hu	69946
c15030c6-d42c-44a9-8efa-cbd57bd6338a	94916	2147	22823	34603	1147616	2020-11-05	08:10:00	https://apify.com/tugkan/covid-hu	69946
b4284f36-d747-40c4-af6c-d0e0113edb1e	99625	2250	23213	34603	1167641	2020-11-06	08:20:00	https://apify.com/tugkan/covid-hu	74162
93374df2-9ce3-4fef-bbe0-8971ef1b0abe	99625	2250	23213	30741	1167641	2020-11-06	09:05:00	https://apify.com/tugkan/covid-hu	74162
d5d94dfd-3cf4-41a5-a1d9-9b3e39dfa716	104943	2357	24847	36911	1189962	2020-11-07	08:25:00	https://apify.com/tugkan/covid-hu	77739
a3c31120-75d5-45e5-a916-98b205f6078c	109616	2438	25070	34287	1209151	2020-11-08	08:30:00	https://apify.com/tugkan/covid-hu	82108
53c27195-d55a-4a74-b34c-7b7becdb26f3	114778	2493	26151	36356	1225399	2020-11-09	07:55:00	https://apify.com/tugkan/covid-hu	86134
bf5223b5-fc25-4482-aba4-6975d871d5e3	118918	2596	27585	36078	1238467	2020-11-10	08:25:00	https://apify.com/tugkan/covid-hu	88737
ad67a50f-78be-4d80-aa42-fffa377b584b	122863	2697	28808	36492	1259454	2020-11-11	08:25:00	https://apify.com/tugkan/covid-hu	91358
4be3a39c-ec0b-4548-aa8c-c4e54a358fcf	126790	2784	29302	34040	1282975	2020-11-12	08:20:00	https://apify.com/tugkan/covid-hu	94704
653e3ce3-4457-4c0f-a05a-fb46a8d344de	131887	2883	29802	36166	1306887	2020-11-13	08:25:00	https://apify.com/tugkan/covid-hu	99202
4a894860-3880-48c6-b018-29bd92466741	136723	2990	31126	36166	1326027	2020-11-14	08:20:00	https://apify.com/tugkan/covid-hu	102607
57063ad5-cbad-4300-a251-6730478b8c89	136723	2990	31126	38028	1326027	2020-11-14	09:15:00	https://apify.com/tugkan/covid-hu	102607
fe2cd74d-63e1-4b42-9f28-c1e406cc403f	140961	3097	31599	36411	1354742	2020-11-15	08:20:00	https://apify.com/tugkan/covid-hu	106265
399389f3-d658-4e14-a4ab-9d8d37aa3e57	147456	3190	34010	35090	1360840	2020-11-16	07:55:00	https://apify.com/tugkan/covid-hu	110256
528ba374-c1e1-438b-804d-977eb8ffe812	152659	3281	34185	35042	1388132	2020-11-17	08:10:00	https://apify.com/tugkan/covid-hu	115193
9ae03e14-ca61-44ce-b710-9086762fdf0f	156949	3380	34846	35804	1409651	2020-11-18	08:10:00	https://apify.com/tugkan/covid-hu	118723
8f2bf80c-4e89-4201-9056-876c3b5306c6	161461	3472	36345	38610	1433008	2020-11-19	08:05:00	https://apify.com/tugkan/covid-hu	121644
802639e8-aeb6-457d-bd8e-7ab4ec87a970	161461	3472	36345	38610	1433008	2020-11-19	08:10:00	https://apify.com/tugkan/covid-hu	121644
6f3920f3-148f-4d59-b876-fbaac2dfe915	165901	3568	38074	42241	1455868	2020-11-20	08:10:00	https://apify.com/tugkan/covid-hu	124259
e3ebfa68-bd26-4fd4-80bd-5b7e92abcc28	170298	3689	40820	40359	1480674	2020-11-21	08:10:00	https://apify.com/tugkan/covid-hu	125789
b2f76565-4ed9-4438-96e0-a7c976cbd01e	174618	3800	42915	42370	1502847	2020-11-22	08:20:00	https://apify.com/tugkan/covid-hu	127903
c2db27fc-bc30-4462-a7b9-5dea508874d5	174618	3800	42915	42370	1502847	2020-11-22	08:25:00	https://apify.com/tugkan/covid-hu	127903
953c9191-bf28-4854-8128-723f128dbb9d	177952	3891	43339	42071	1518158	2020-11-23	08:10:00	https://apify.com/tugkan/covid-hu	130722
b05d8e70-88af-4900-b7d7-890caf19b0ca	181881	4008	44020	41557	1528302	2020-11-24	08:30:00	https://apify.com/tugkan/covid-hu	133853
a7f43bd2-3692-4960-ac00-9773297407be	185687	4114	44020	41558	1548318	2020-11-25	08:20:00	https://apify.com/tugkan/covid-hu	137553
d2105955-6490-47ea-b27b-2ba3d859d1b5	192047	4229	49616	45750	1566619	2020-11-26	08:20:00	https://apify.com/tugkan/covid-hu	138202
ff942f3e-740d-47c9-bca9-d5e34887da03	192047	4229	49616	45750	1580197	2020-11-26	11:25:00	https://apify.com/tugkan/covid-hu	138202
138f793a-ceb0-416f-a002-9b6493f8b10d	198440	4364	52126	49549	1601203	2020-11-27	08:15:00	https://apify.com/tugkan/covid-hu	141950
9a9e6f6c-8b46-416c-bf33-afff8a9f535c	204708	4516	54021	51142	1622765	2020-11-28	08:00:00	https://apify.com/tugkan/covid-hu	146171
fa7773c7-f5b5-4fcc-a25a-a027949ebe2a	211527	4672	55637	50227	1639076	2020-11-29	08:25:00	https://apify.com/tugkan/covid-hu	151218
92cc5a68-c35d-42d5-91f3-d996fc70cb37	217122	4823	63860	48796	1648022	2020-11-30	08:00:00	https://apify.com/tugkan/covid-hu	148439
472b7366-006f-4bfb-8431-d9b18667d2a4	221073	4977	64802	48171	1653780	2020-12-01	08:00:00	https://apify.com/tugkan/covid-hu	151294
3e709263-3489-4f25-8a93-68eb5ddc6ac6	221073	4977	64802	48171	1653780	2020-12-01	08:05:00	https://apify.com/tugkan/covid-hu	151294
4643df03-9951-42cc-9918-abd240ba02fb	221073	4977	64802	48171	1835286	2020-12-01	11:05:00	https://apify.com/tugkan/covid-hu	151294
0f3a0cfa-5650-4727-8ebb-f65a546599e4	225209	5142	65888	44318	1850230	2020-12-02	08:00:00	https://apify.com/tugkan/covid-hu	154179
7e24cfd1-2708-4d23-bfa8-74f958c9aeca	231844	5324	67033	50430	1876274	2020-12-03	08:10:00	https://apify.com/tugkan/covid-hu	159487
6375366d-dcf1-4429-802e-418eceabffaf	231844	5324	67033	50430	1876274	2020-12-03	08:15:00	https://apify.com/tugkan/covid-hu	159487
d3f4601d-5a91-4057-95f3-b2416114c471	238056	5513	68525	53238	1894753	2020-12-04	08:15:00	https://apify.com/tugkan/covid-hu	164018
bbefd164-d8ee-4ecd-b859-0b9c6292302a	243581	5706	70396	53315	1918043	2020-12-05	08:10:00	https://apify.com/tugkan/covid-hu	167479
5a391a33-96ec-4f20-a915-b2bdd3c6d0f3	250278	5868	71682	50283	1941724	2020-12-06	07:55:00	https://apify.com/tugkan/covid-hu	172728
7a202d68-9c76-4d27-b0bc-af2a8a650758	254148	5984	74283	51485	1963148	2020-12-07	07:45:00	https://apify.com/tugkan/covid-hu	173881
90f2df00-eb6d-44c7-87fe-82796022a040	254148	5984	74283	51485	2149291	2020-12-07	10:45:00	https://apify.com/tugkan/covid-hu	173881
e0e2e683-cdcf-46b0-80bf-b6d0273e7ed7	256367	6120	75281	45542	2158818	2020-12-08	07:45:00	https://apify.com/tugkan/covid-hu	174966
6ed4ce89-f4b9-485a-b8af-d9345aeb4038	259588	6280	76270	45957	2187555	2020-12-09	07:50:00	https://apify.com/tugkan/covid-hu	177038
3270a8b9-b1fc-4eeb-beca-d3d23f0f8758	265003	6451	77362	43923	2216880	2020-12-10	07:55:00	https://apify.com/tugkan/covid-hu	181190
975c9da5-4ee4-4608-b99a-a3ce3fc99a5b	271200	6622	78700	49524	2245483	2020-12-11	08:05:00	https://apify.com/tugkan/covid-hu	185878
13ea7647-46c6-44f0-9b90-47accd6bb4eb	276247	6784	79769	49365	2275935	2020-12-12	07:30:00	https://apify.com/tugkan/covid-hu	189694
bf9daa9b-23ac-4506-b1df-4cb8ce392392	280400	6965	80752	47486	2301174	2020-12-13	08:05:00	https://apify.com/tugkan/covid-hu	192683
9123d09d-290f-4fd0-80ee-fce113106ba1	283870	7130	82546	43966	2320419	2020-12-14	08:00:00	https://apify.com/tugkan/covid-hu	194194
af55eefd-07c8-4660-bc45-3e59351ae4b5	283870	7130	82546	43966	2382632	2020-12-14	10:25:00	https://apify.com/tugkan/covid-hu	194194
a9565f42-b4e7-42b8-98eb-c3e8cd9f8ac0	285763	7237	83115	42752	2393535	2020-12-15	07:52:00	https://apify.com/tugkan/covid-hu	195411
c065f9ef-837c-4811-826d-3f75631257ae	288567	7381	83940	42467	2406171	2020-12-16	07:45:00	https://apify.com/tugkan/covid-hu	197246
3cd2008d-44a9-4e24-87a3-90ee093ab75e	291549	7538	86954	44248	2424533	2020-12-17	08:10:00	https://apify.com/tugkan/covid-hu	197057
f9438850-0a44-4aa6-a3c4-8391c4c9dc7f	295977	7725	89814	45075	2456600	2020-12-18	07:55:00	https://apify.com/tugkan/covid-hu	198438
0a5274fd-b7b5-4cfd-bca9-74de041f3075	295977	7725	89814	45075	2456600	2020-12-18	08:00:00	https://apify.com/tugkan/covid-hu	198438
845368c0-400b-465b-9723-15d40282b2d6	295977	7725	89814	45075	2456600	2020-12-19	00:55:00	https://apify.com/tugkan/covid-hu	198438
92d8fc6b-f3b8-497a-9905-9a590d574539	300022	7914	93323	44010	2480804	2020-12-19	09:30:00	https://apify.com/tugkan/covid-hu	198785
36da3ffe-816b-4940-8af9-6f7e8d079895	302989	8099	97443	41445	2504837	2020-12-20	07:55:00	https://apify.com/tugkan/covid-hu	197447
b01a8c1b-9bd0-4e99-ab9e-ac78f028176d	305130	8282	102962	32486	2520288	2020-12-21	08:00:00	https://apify.com/tugkan/covid-hu	193886
24be988b-3d90-4ddc-933e-e7f28284e1d1	305130	8282	102962	32486	2520288	2020-12-21	15:05:00	https://apify.com/tugkan/covid-hu	193886
df2bd64b-8035-4602-a1ca-a48e6e394e07	306368	8462	108676	35624	2528225	2020-12-22	08:05:00	https://apify.com/tugkan/covid-hu	189230
044c10b6-8dc5-4831-91bd-105dc7e0ff68	308262	8616	114631	29316	2549464	2020-12-23	07:55:00	https://apify.com/tugkan/covid-hu	185015
f09765c7-0e74-48e7-9aab-4a847971e5a5	311554	8729	120529	29019	2575650	2020-12-24	08:20:00	https://apify.com/tugkan/covid-hu	182296
74d325ef-f089-40cb-85eb-ecae01da48f3	311554	8729	120529	29019	2575650	2020-12-24	08:25:00	https://apify.com/tugkan/covid-hu	182296
a9a07905-7d27-4cf5-abd7-d0ca3e13330e	314164	8833	123989	29961	2597804	2020-12-25	08:06:00	https://apify.com/tugkan/covid-hu	181342
ca592b4a-49a3-4bb2-a709-8672188636a5	315362	8951	126482	24878	2607298	2020-12-26	08:30:00	https://apify.com/tugkan/covid-hu	179929
ff7f0440-5634-430d-98f0-fef592029342	316060	9047	130420	24327	2610590	2020-12-27	07:55:00	https://apify.com/tugkan/covid-hu	176593
1b71e08e-d06e-4eaa-856b-9ccd5305438f	316669	9161	134344	22779	2615237	2020-12-28	07:50:00	https://apify.com/tugkan/covid-hu	173164
423bf918-ad10-466d-be13-caed8aed406a	317571	9292	138365	21667	2621427	2020-12-29	07:45:00	https://apify.com/tugkan/covid-hu	169914
a4d4e49c-b36c-4e39-bf6c-78ad4fccbde3	319543	9429	144234	19496	2639729	2020-12-30	07:50:00	https://apify.com/tugkan/covid-hu	165880
48ee2c0c-c035-4a0f-8784-4029fec2095d	322514	9537	150102	17704	2657119	2020-12-31	08:25:00	https://apify.com/tugkan/covid-hu	162875
c59cdad3-b04e-4ce9-94a7-1dd8b3baeb62	325278	9667	157063	20057	2675247	2021-01-01	08:05:00	https://apify.com/tugkan/covid-hu	158548
92c79931-b26b-4163-9304-6cffa1436acd	326688	9781	163403	18239	2685944	2021-01-02	07:45:00	https://apify.com/tugkan/covid-hu	153504
82638796-ef4d-4dd3-a411-65b8b7618632	327995	9884	168381	16537	2691904	2021-01-03	08:25:00	https://apify.com/tugkan/covid-hu	149730
9433614c-21ff-4afd-8969-0a76c27506a1	328851	9977	174070	18794	2700631	2021-01-04	07:50:00	https://apify.com/tugkan/covid-hu	144804
7c8a0f5d-459e-4324-b76b-b655bf70346f	328851	9977	174070	18794	2721375	2021-01-04	10:45:00	https://apify.com/tugkan/covid-hu	144804
d40270ac-4eef-469d-b918-652f93a6c4a9	329721	10080	176576	20272	2727896	2021-01-05	07:55:00	https://apify.com/tugkan/covid-hu	143065
5e2a7dbd-c086-4eee-841e-8e34feaf729a	331768	10198	179541	20657	2729881	2021-01-06	08:15:00	https://apify.com/tugkan/covid-hu	142029
ea4ffc8a-fe57-4c21-a7da-889421640824	331768	10198	179541	20657	2750625	2021-01-06	09:31:00	https://apify.com/tugkan/covid-hu	142029
f0c4d331-2032-4835-85c6-0619c7d29c02	334836	10325	179541	21627	2774915	2021-01-07	09:05:00	https://apify.com/tugkan/covid-hu	144970
9ee465f6-342a-4075-a4b2-0f7bf269da4e	337743	10440	186449	20865	2798939	2021-01-08	08:10:00	https://apify.com/tugkan/covid-hu	140854
b4b9f2b9-3f02-438e-b319-34848fb82304	340459	10554	193172	23281	2820762	2021-01-09	08:15:00	https://apify.com/tugkan/covid-hu	136733
b8814ed0-a556-4dd0-b9cb-6a6304b1fb4c	342237	10648	197936	22962	2840024	2021-01-10	08:25:00	https://apify.com/tugkan/covid-hu	133653
0dd0069e-7bad-4ef6-a89e-3c0f5f3808bd	343656	10725	203972	21979	2852591	2021-01-11	07:50:00	https://apify.com/tugkan/covid-hu	128959
092d54c3-7f1d-466f-8099-e0e5611a33db	343656	10725	203972	21979	2852591	2021-01-11	07:55:00	https://apify.com/tugkan/covid-hu	128959
0d2ec396-4c06-4637-8f78-aca4706299f0	344352	10853	209852	25532	2860814	2021-01-12	07:50:00	https://apify.com/tugkan/covid-hu	123647
f9cfc1d0-5292-429c-a9e1-4b03c5aab567	345710	10948	215453	25856	2879364	2021-01-13	08:00:00	https://apify.com/tugkan/covid-hu	119309
b9cbe337-5526-455a-a592-a83ec591aa33	345710	10948	215453	25856	2879364	2021-01-13	08:05:00	https://apify.com/tugkan/covid-hu	119309
c412a287-a80e-4c2f-834f-f29cc6e4a80a	347636	11066	220304	25646	2898998	2021-01-14	07:40:00	https://apify.com/tugkan/covid-hu	116266
0cf88b2e-6f11-4110-bca4-0321438b5f81	349149	11177	225021	25678	2918096	2021-01-15	07:45:00	https://apify.com/tugkan/covid-hu	112951
ba8bec79-497e-42e5-9de6-2e87e3caa178	349149	11177	225021	25678	2918096	2021-01-15	07:50:00	https://apify.com/tugkan/covid-hu	112951
3046cbd8-6119-4d68-97ca-e1bfc8687620	350587	11264	227325	24874	2936435	2021-01-16	07:50:00	https://apify.com/tugkan/covid-hu	111998
9b587259-3a7a-4a47-8f22-54679026c734	351828	11341	228615	23083	2953710	2021-01-17	07:45:00	https://apify.com/tugkan/covid-hu	111872
53699df6-7e51-4f04-9d8b-ec8f6c636078	352703	11409	230441	21648	2963613	2021-01-18	07:40:00	https://apify.com/tugkan/covid-hu	110853
4bb8b849-13f1-4dc9-b300-d57af95f6e9a	353276	11520	231915	18523	2968743	2021-01-19	07:35:00	https://apify.com/tugkan/covid-hu	109841
93820e19-5769-4c43-9ec1-3cfc4e708a66	354252	11615	233232	20170	2984748	2021-01-20	08:00:00	https://apify.com/tugkan/covid-hu	109405
810161c7-292e-4a1d-8f2b-ef41e100e10d	355662	11713	235276	19932	3000325	2021-01-21	08:25:00	https://apify.com/tugkan/covid-hu	108673
0825d125-7d4b-420b-b53c-7bef466718b1	356973	11811	237362	19908	3018389	2021-01-22	07:30:00	https://apify.com/tugkan/covid-hu	107800
4e7974c3-9bba-4292-b036-523e0cc7c628	358317	11904	239880	20095	3035627	2021-01-23	08:05:00	https://apify.com/tugkan/covid-hu	106533
bb6e1bff-284c-4f75-a669-e506ddfb7c39	359574	11968	241472	18929	3052068	2021-01-24	07:55:00	https://apify.com/tugkan/covid-hu	106134
7c633747-ae1a-4550-97d7-60f8e3b160d1	360418	12024	243092	18141	3062132	2021-01-25	07:55:00	https://apify.com/tugkan/covid-hu	105302
1647b310-e4e6-4787-a214-e12b8462ac78	360877	12113	244681	18075	3067663	2021-01-26	07:50:00	https://apify.com/tugkan/covid-hu	104083
6661a6ec-9992-472f-a9f3-bf776aed74b1	361881	12198	246596	17834	3084716	2021-01-27	07:56:00	https://apify.com/tugkan/covid-hu	103087
dc362e48-c5ef-4c19-9b8d-154fc9ee67cc	363450	12291	249003	19131	3097809	2021-01-28	07:25:00	https://apify.com/tugkan/covid-hu	102156
cbc53262-628d-45b2-96a1-bcfc23ed5868	364909	12374	254783	17540	3116784	2021-01-29	08:00:00	https://apify.com/tugkan/covid-hu	97752
44edde32-26b8-4ffe-8513-854966cbec6d	368710	12578	264260	13810	3169150	2021-02-01	12:30:00	https://apify.com/tugkan/covid-hu	91872
c5540b99-c4f9-46e3-add2-7074e059f0e8	369288	12656	268803	18030	3176944	2021-02-02	07:50:00	https://apify.com/tugkan/covid-hu	87829
afb2f285-6f27-4d28-ac5a-e804961dd278	370336	12739	272284	18337	3192378	2021-02-03	07:55:00	https://apify.com/tugkan/covid-hu	85313
30d23770-2dcc-40cd-94ee-eb49e15f2326	371988	12832	274308	19633	3210549	2021-02-04	07:45:00	https://apify.com/tugkan/covid-hu	84848
42a958c4-d2c9-40f8-9acd-7ded2998b161	371988	12832	274308	19633	3210549	2021-02-04	07:50:00	https://apify.com/tugkan/covid-hu	84848
e175f221-7a83-4059-8b27-c87e7d96a542	373564	12930	275764	20254	3229242	2021-02-05	07:55:00	https://apify.com/tugkan/covid-hu	84870
5079f518-676a-4fdd-a8aa-fcdd6604c417	375125	13026	277949	18124	3246838	2021-02-06	08:32:00	https://apify.com/tugkan/covid-hu	84150
de80cdb6-1548-4975-aec8-efda6d659a01	376495	13090	279763	19510	3265862	2021-02-07	07:45:00	https://apify.com/tugkan/covid-hu	83642
d4e655af-ed0a-4673-bd60-77b80802b1c3	377655	13155	281839	15847	3275582	2021-02-08	07:55:00	https://apify.com/tugkan/covid-hu	82661
466bd3d7-3e63-42db-88a1-1cec9eef8c6f	378734	13249	283282	16850	3281992	2021-02-09	07:55:00	https://apify.com/tugkan/covid-hu	82203
ef72ac90-97a7-4ffc-bff3-88da3b815379	380013	13347	285022	19414	3298814	2021-02-10	08:15:00	https://apify.com/tugkan/covid-hu	81644
683811fa-3a0f-40f8-a8a9-5dd8fed8237b	381875	13444	287134	21456	3318850	2021-02-11	07:56:00	https://apify.com/tugkan/covid-hu	81297
4665be09-49ce-4b76-9d0d-460243920436	383735	13543	289520	22525	3338289	2021-02-12	07:45:00	https://apify.com/tugkan/covid-hu	80672
54f1069e-d99a-40d7-a0b1-cea3df84788b	383735	13543	289520	22525	3338289	2021-02-12	07:51:00	https://apify.com/tugkan/covid-hu	80672
0d8951aa-078c-4294-aa76-76db466e3784	385755	13636	293542	20794	3357672	2021-02-13	08:00:00	https://apify.com/tugkan/covid-hu	78577
a483044b-5300-4adc-8de3-fd61294228da	387462	13706	296173	19927	3377187	2021-02-14	07:45:00	https://apify.com/tugkan/covid-hu	77583
d8b4c977-ef80-415c-9d35-38996a0e47ae	388799	13752	298008	20718	3388457	2021-02-15	07:55:00	https://apify.com/tugkan/covid-hu	77039
dae6e005-273d-464a-959e-d882924a2acd	391170	13931	299989	18205	3414023	2021-02-17	10:40:00	https://apify.com/tugkan/covid-hu	77250
b1abf753-53d6-4941-b852-25868a69d438	394023	14035	301363	22893	3434878	2021-02-18	07:30:00	https://apify.com/tugkan/covid-hu	78625
f81522d9-e7a7-451d-a5a4-363e2a43d82b	397116	14145	302689	25536	3457538	2021-02-19	10:05:00	https://apify.com/tugkan/covid-hu	80282
52116575-d32b-4867-828a-3d7651c47733	400111	14252	304680	26068	3480444	2021-02-20	07:55:00	https://apify.com/tugkan/covid-hu	81179
ec9465ed-f879-4396-91e4-7c1608d30f67	403023	14299	306621	27179	3503611	2021-02-21	08:20:00	https://apify.com/tugkan/covid-hu	82103
dd2c9c97-47a6-45e5-a73c-b24ac2f88b02	405646	14347	308650	25589	3519536	2021-02-22	07:40:00	https://apify.com/tugkan/covid-hu	82649
e10cfa1c-d245-4f40-8826-1d9ca37f12b5	407274	14450	310848	26549	3528862	2021-02-23	07:40:00	https://apify.com/tugkan/covid-hu	81976
96d4da9c-644a-4675-8314-71e68a8b10c6	410129	14552	313450	27737	3552261	2021-02-24	07:45:00	https://apify.com/tugkan/covid-hu	82127
74d73a70-8709-4c7e-a871-61eda6b0f483	414514	14672	315781	29389	3577770	2021-02-25	08:30:00	https://apify.com/tugkan/covid-hu	84061
d99dd744-6d52-45cd-9b8e-984757eb10ce	419182	14795	317899	35303	3604898	2021-02-26	07:35:00	https://apify.com/tugkan/covid-hu	86488
55b7cccc-1b53-4cff-9366-ca02ae252cfe	424130	14902	319691	37658	3632712	2021-02-27	08:01:00	https://apify.com/tugkan/covid-hu	89537
18c353ac-5e30-4229-b3ef-dea815ed65d5	428599	14974	321128	33353	3660342	2021-02-28	08:35:00	https://apify.com/tugkan/covid-hu	92497
082bb97b-14c0-40e8-8dfd-a1e3c82e0b7e	432925	15058	322956	34716	3680572	2021-03-01	08:10:00	https://apify.com/tugkan/covid-hu	94911
414a8abb-5ce9-4e66-a5b1-b32a5ce1e8d9	435689	15188	324202	35023	3693390	2021-03-02	07:50:00	https://apify.com/tugkan/covid-hu	96299
56bb3bf6-1b3c-45cb-a05e-27ee5269c841	439900	15324	326215	37005	3719113	2021-03-03	08:00:00	https://apify.com/tugkan/covid-hu	98361
ab7cf79c-7a02-4db5-b44c-8df3417ae4ec	446178	15476	328136	41440	3749907	2021-03-04	07:46:00	https://apify.com/tugkan/covid-hu	102566
771cc280-1226-4ecd-90c2-04fe7554aad9	452547	15619	331557	45164	3781181	2021-03-05	08:00:00	https://apify.com/tugkan/covid-hu	105371
641d28d2-3662-4aaa-84c9-5c20e865bf5b	459816	15765	333045	46620	3816852	2021-03-06	08:00:00	https://apify.com/tugkan/covid-hu	111006
f0943020-f6af-46bb-964a-fdf3244e0234	466017	15873	335512	44217	3850623	2021-03-07	09:00:00	https://apify.com/tugkan/covid-hu	114632
dce72d83-e037-4034-8fb2-40c94200e3a0	468713	15988	336744	37343	3874513	2021-03-08	10:00:00	https://apify.com/tugkan/covid-hu	115981
1f4eec18-7e47-42b6-8d7f-86c8f01af9cb	475207	16146	338946	40869	3891778	2021-03-09	09:00:00	https://apify.com/tugkan/covid-hu	120115
224eb662-36f0-41e6-94ad-268f35575bfa	480860	16325	340844	42362	3922530	2021-03-10	07:00:00	https://apify.com/tugkan/covid-hu	123691
9cd9c6fa-49fd-4926-8e71-1529361a4dfe	489172	16497	344267	46302	3955994	2021-03-11	09:00:00	https://apify.com/tugkan/covid-hu	128408
65534b0b-9c34-4b0f-b244-4f02e8d38c30	498183	16627	346904	48677	3992790	2021-03-12	08:00:00	https://apify.com/tugkan/covid-hu	134652
10b6b760-71f1-498d-be32-8b9d4e4392e7	507627	16790	349530	46249	4034635	2021-03-13	08:00:00	https://apify.com/tugkan/covid-hu	141307
b2503f14-8bd0-4cbb-8e52-f5ebc3760d03	516490	16952	351891	48329	4076943	2021-03-14	08:00:00	https://apify.com/tugkan/covid-hu	147647
0ed8e10e-bd6d-4f2e-9dcc-5bd53b46b76d	524196	17083	354817	45605	4104415	2021-03-15	08:00:00	https://apify.com/tugkan/covid-hu	152296
ef3faab4-c057-4cfc-978d-f892c7ce2c1a	529122	17226	356679	43553	4122541	2021-03-16	08:00:00	https://apify.com/tugkan/covid-hu	155217
142985b4-9d19-4332-a5aa-93f932a243e0	532578	17421	359061	44648	4136190	2021-03-17	09:01:00	https://apify.com/tugkan/covid-hu	156096
5f8211e4-461f-4233-8e35-f44c63c6533a	532578	17421	359061	44648	4136190	2021-03-17	10:00:00	https://apify.com/tugkan/covid-hu	156096
ab783ebf-d5a6-41b7-be5b-1c038f740096	539080	17628	360895	47116	4162688	2021-03-18	08:00:00	https://apify.com/tugkan/covid-hu	160557
31a73be9-8a1f-4a0d-b07d-d757b983928a	549839	17841	364808	50701	4202286	2021-03-19	08:00:00	https://apify.com/tugkan/covid-hu	167190
77204644-3dae-48dc-8d15-fdbffe1fae22	560971	18068	366774	52885	4242762	2021-03-20	08:00:00	https://apify.com/tugkan/covid-hu	176129
8445f18d-efc8-416f-a196-bd9f82a9d72a	571596	18262	369998	50512	4283741	2021-03-21	08:01:00	https://apify.com/tugkan/covid-hu	183336
f195a3d1-67e3-45d2-96b7-d70e7ef05296	580642	18451	373666	43961	4315305	2021-03-22	09:00:00	https://apify.com/tugkan/covid-hu	188525
088954f6-7cc1-4ff6-aec0-9aee4d8bff14	586123	18703	378176	50096	4334584	2021-03-23	08:00:00	https://apify.com/tugkan/covid-hu	189244
f123c505-4a62-4893-aa77-0d465029388c	593710	18952	381807	51230	4367900	2021-03-24	08:00:00	https://apify.com/tugkan/covid-hu	192951
08100039-bedb-4ebf-bad8-d5093a33b198	603347	19224	387570	54422	4403317	2021-03-25	09:00:00	https://apify.com/tugkan/covid-hu	196553
a31d4c67-7371-4931-bc4a-c19b503bcc75	614612	19499	392314	58667	4443610	2021-03-26	09:00:00	https://apify.com/tugkan/covid-hu	202799
90722609-d0d1-4f4d-b468-0097b825b943	624779	19752	393999	61430	4486163	2021-03-27	09:00:00	https://apify.com/tugkan/covid-hu	211028
37b04f69-6abb-41de-84d1-6abf4eec5815	633861	19972	395790	59018	4515464	2021-03-28	08:00:00	https://apify.com/tugkan/covid-hu	218099
bd25fd1a-18a5-4b96-b127-c4aa0e3a6958	641124	20161	399961	55511	4557943	2021-03-29	07:00:00	https://apify.com/tugkan/covid-hu	221002
a8dd7494-7a94-4180-b4be-2b137d7e8755	645733	20435	402964	55280	4576398	2021-03-30	13:00:00	https://apify.com/tugkan/covid-hu	222334
b5103d57-d5a5-4560-881a-c1d4ba15ac52	652433	20737	406935	55287	4609152	2021-03-31	08:00:00	https://apify.com/tugkan/covid-hu	224761
8aa66b11-a6da-46a3-b1f3-37f60818e850	652433	20737	406935	55287	4609152	2021-03-31	09:00:00	https://apify.com/tugkan/covid-hu	224761
9d31f6e9-ffd2-4c8d-8ca6-bbfc356a07c6	661721	20995	410565	55915	4649596	2021-04-01	08:00:00	https://apify.com/tugkan/covid-hu	230161
6c5c1868-3f45-4723-afec-217671ffaf7f	670776	21262	413370	57800	4689589	2021-04-02	08:00:00	https://apify.com/tugkan/covid-hu	236144
6c9cc4e7-bfd7-4423-99d1-debbe7c7374a	679413	21504	415601	55056	4726187	2021-04-03	07:00:00	https://apify.com/tugkan/covid-hu	242308
c1f53ab0-efe0-43cd-8b3d-3bb1e1bcc691	685979	21715	416972	52528	4753281	2021-04-04	08:00:00	https://apify.com/tugkan/covid-hu	247292
9565f7fe-fe71-4c00-8d79-56bb142413b7	689853	21928	418084	50052	4772189	2021-04-05	08:01:00	https://apify.com/tugkan/covid-hu	249841
4682a614-07f6-4609-af69-854b4f51d69e	691743	22098	418568	44172	4783383	2021-04-06	07:00:00	https://apify.com/tugkan/covid-hu	251077
65655744-7845-4dec-80f8-6e81013f31a4	693676	22409	419152	47578	4795584	2021-04-07	07:00:00	https://apify.com/tugkan/covid-hu	252115
090e8394-30d1-43b0-96ea-0f5a3d837b14	698490	22681	419765	46612	4825607	2021-04-08	08:00:00	https://apify.com/tugkan/covid-hu	256044
556e68b6-ac71-40c3-9116-6cabafe9247b	705815	22966	420275	46775	4861310	2021-04-09	07:00:00	https://apify.com/tugkan/covid-hu	262574
9c53b519-3a59-4fea-8949-3408a3824955	713868	23211	423366	47041	4897922	2021-04-10	08:00:00	https://apify.com/tugkan/covid-hu	267291
d0bd5a0d-c317-4a27-8e54-bde6392fdbd4	720164	23417	426394	44370	4934786	2021-04-11	07:00:00	https://apify.com/tugkan/covid-hu	270353
3733437f-48d5-4131-b1d9-d25217bae877	725241	23708	429074	43002	4961146	2021-04-12	07:00:00	https://apify.com/tugkan/covid-hu	272459
860898ee-5d1b-4cb5-9fb0-033a3d8d6f30	753188	25381	458212	45132	5144130	2021-04-19	07:00:00	https://apify.com/tugkan/covid-hu	269595
ef403b44-6692-4116-bb02-46f918ddc092	754833	25580	461181	43841	5157082	2021-04-20	07:00:00	https://apify.com/tugkan/covid-hu	268072
4d41acff-6ae0-4ce4-96c4-50f465ee12fd	757360	25787	464750	42068	5179517	2021-04-21	07:00:00	https://apify.com/tugkan/covid-hu	266823
0253092a-912c-4ae9-a3ef-e48df383633d	760967	26001	469592	41857	5205923	2021-04-22	07:00:00	https://apify.com/tugkan/covid-hu	265374
6318e316-a0f8-4848-9ccd-d6c199896f68	764394	26208	474147	42182	5233530	2021-04-23	10:00:00	https://apify.com/tugkan/covid-hu	264039
9e112aa3-9a90-4c43-bbb8-759ff2388eb4	767190	26420	478323	40947	5257377	2021-04-24	08:00:00	https://apify.com/tugkan/covid-hu	262447
8dd566d3-3d41-4e24-9c55-9b3992b83dec	769518	26625	482207	37497	5280600	2021-04-25	08:00:00	https://apify.com/tugkan/covid-hu	260686
f0b68a0b-8039-4db5-95da-9587ebe6fdaf	771454	26801	486435	35472	5297235	2021-04-26	08:00:00	https://apify.com/tugkan/covid-hu	258218
be33caf5-352c-4af0-ba3f-c4b87371961f	772707	26984	491620	34785	5308624	2021-04-27	08:00:00	https://apify.com/tugkan/covid-hu	254103
0af22e51-4c9a-4466-934f-38d5cfa17090	774399	27172	497084	33429	5327413	2021-04-28	07:00:00	https://apify.com/tugkan/covid-hu	250143
eb6eafb1-a85d-45e0-a12d-d379d4fd0884	776983	27358	503697	31133	5349792	2021-04-29	07:00:00	https://apify.com/tugkan/covid-hu	245928
376064f3-45dc-4ab7-a5cc-d2a04d4944d9	779348	27540	510379	32838	5373540	2021-04-30	10:00:00	https://apify.com/tugkan/covid-hu	241429
ef933ac4-7ef5-493e-b520-699a151679ab	779348	27540	510379	32838	5373540	2021-04-30	17:00:00	https://apify.com/tugkan/covid-hu	241429
7f2b10d5-1afe-4c33-bbc4-ac1f579657ac	781299	27701	517026	31885	5394652	2021-05-01	08:00:00	https://apify.com/tugkan/covid-hu	236572
c54576fa-1034-4ae5-8fad-7a22b0ed100d	782892	27802	523510	28989	5415983	2021-05-02	08:00:00	https://apify.com/tugkan/covid-hu	231580
c89a2a69-175a-4aa2-aa42-69043f768d4e	782892	27802	523510	28979	5415983	2021-05-02	11:00:00	https://apify.com/tugkan/covid-hu	231580
552a7aa5-ed61-4840-badc-f2e7826ec7f8	784111	27908	528201	27386	5429737	2021-05-03	08:00:00	https://apify.com/tugkan/covid-hu	228002
96cd7286-c466-4ad6-a470-402ed6cf1612	784837	28045	532990	28080	5438145	2021-05-04	08:00:00	https://apify.com/tugkan/covid-hu	223802
79ebd387-c0db-4634-9b24-c46d95b1c4f5	785967	28173	538965	24796	5454661	2021-05-05	08:00:00	https://apify.com/tugkan/covid-hu	218829
fbbe9dd9-ba2f-4732-80d4-888928d84bc3	787647	28297	546246	24902	5475551	2021-05-06	07:01:00	https://apify.com/tugkan/covid-hu	213104
55223465-e546-43f7-a85d-13c15ada34cc	789188	28403	553836	24690	5494198	2021-05-07	08:00:00	https://apify.com/tugkan/covid-hu	206949
fe7abacc-bfc0-41e6-9621-02a9fcdd4f95	790564	28504	561119	21301	5494198	2021-05-08	07:00:00	https://apify.com/tugkan/covid-hu	200941
fbd16eb2-f382-4818-ac12-f9cd4a7256d3	791709	28602	568329	21975	5528240	2021-05-09	08:00:00	https://apify.com/tugkan/covid-hu	194778
3bcb56e9-1870-4ea7-81a0-4a20eeb0c3bc	792386	28693	575610	20967	5538792	2021-05-10	07:00:00	https://apify.com/tugkan/covid-hu	188083
d23692ed-4a8a-4f49-84a1-3fa5a88613f5	792879	28792	583802	20197	5545305	2021-05-11	08:00:00	https://apify.com/tugkan/covid-hu	180285
316420da-0df1-4fc5-aa92-15a4a3c8a416	793784	28888	592440	18872	5560617	2021-05-12	08:00:00	https://apify.com/tugkan/covid-hu	172456
0b14274b-810e-4650-b4b6-75e2ba097e04	795200	28970	600461	18886	5588435	2021-05-13	07:00:00	https://apify.com/tugkan/covid-hu	165769
be60937c-bac9-4fd9-97f2-d341c2c55c5c	796390	29041	608891	18448	5607336	2021-05-14	07:00:00	https://apify.com/tugkan/covid-hu	158458
3325393c-370d-4abb-9655-cb681320602e	796390	29041	608891	18448	5607336	2021-05-14	08:00:00	https://apify.com/tugkan/covid-hu	158458
552bd18d-c7bd-48c6-b488-ba0ccc8eac95	797429	29114	618608	18171	5622836	2021-05-15	08:00:00	https://apify.com/tugkan/covid-hu	149707
f4c8585a-bdaf-49be-b14b-579c9e8eac8e	798147	29175	625088	17043	5638662	2021-05-16	08:00:00	https://apify.com/tugkan/covid-hu	143884
2eb041f6-9c11-4af1-b9e0-9f5a8c4f91dc	798573	29213	630976	16297	5649027	2021-05-17	08:00:00	https://apify.com/tugkan/covid-hu	138384
704b232e-ace7-41df-aa43-3efdf17af224	798955	29277	640964	16088	5656131	2021-05-18	08:00:00	https://apify.com/tugkan/covid-hu	128714
9f2e66c6-4d97-47e1-817b-6f3ea6a6afb0	799588	29329	648513	16027	5670793	2021-05-19	08:00:00	https://apify.com/tugkan/covid-hu	121746
05ae06f2-31cc-40d8-ad40-48d33e5dfa3f	800368	29380	655959	16210	5687117	2021-05-20	08:00:00	https://apify.com/tugkan/covid-hu	115029
c463e28c-c1fe-4ca5-82f4-95d4e1d6236f	801025	29427	661564	16209	5697748	2021-05-21	08:00:00	https://apify.com/tugkan/covid-hu	110034
288181e2-726c-4d66-8ce2-905198c8149f	801672	29475	665552	15585	5720398	2021-05-22	08:00:00	https://apify.com/tugkan/covid-hu	106645
4136e7ef-69f9-4b70-a780-07911054d762	801672	29475	665552	15585	5720398	2021-05-22	17:00:00	https://apify.com/tugkan/covid-hu	106645
60c11ffa-ad3e-460f-a653-8cb9d2ab7e53	802088	29519	668820	14220	5734447	2021-05-23	08:00:00	https://apify.com/tugkan/covid-hu	103749
3418f96a-f09a-4d9f-a266-e7e517adb404	802346	29560	670205	13211	5743991	2021-05-24	07:00:00	https://apify.com/tugkan/covid-hu	102581
f82ad979-eeca-4a4b-90e8-5a3fbb7b53e2	802510	29581	671392	12376	5750359	2021-05-25	07:00:00	https://apify.com/tugkan/covid-hu	101537
6fa1be0b-8235-4551-b4b9-ad1a4f601117	802723	29622	675082	11878	5756599	2021-05-26	07:00:00	https://apify.com/tugkan/covid-hu	98019
a79d7122-294a-461e-a744-aae6b86e4778	803119	29654	682301	11432	5771058	2021-05-27	07:00:00	https://apify.com/tugkan/covid-hu	91164
2f557540-804a-48ab-8a75-35098bd5ee99	803567	29682	689166	10790	5786609	2021-05-28	08:00:00	https://apify.com/tugkan/covid-hu	84719
b60d9423-6809-4d6d-84e8-1f6bef5419aa	804032	29709	692248	10302	5801554	2021-05-29	08:00:00	https://apify.com/tugkan/covid-hu	82075
8052191d-34bb-4327-a7e1-387698b17261	804382	29728	696029	9670	5816796	2021-05-30	08:00:00	https://apify.com/tugkan/covid-hu	78625
e6287ee6-9ac2-4df9-a434-0c333f5e61e6	804538	29733	700236	9221	5824848	2021-05-31	07:00:00	https://apify.com/tugkan/covid-hu	74569
9c84137c-cb50-41c3-9735-8469d7f48769	804712	29761	703352	8749	5837630	2021-06-01	07:00:00	https://apify.com/tugkan/covid-hu	71599
c6d52075-c578-40a1-91fb-e8feb2eed705	804987	29774	705378	8320	5862778	2021-06-02	07:00:00	https://apify.com/tugkan/covid-hu	69835
91a3a0f5-3f54-4705-bf02-5d843740bbfb	805302	29792	708198	7759	5866214	2021-06-03	07:00:00	https://apify.com/tugkan/covid-hu	67312
659e2442-7279-466b-bffe-a5a2cbffc560	805571	29818	711105	7393	5884887	2021-06-04	08:00:00	https://apify.com/tugkan/covid-hu	64648
74c6ff34-6cb8-4f4b-9ea1-3df955694b9d	805871	29842	714329	7254	5897459	2021-06-05	07:00:00	https://apify.com/tugkan/covid-hu	61700
4886cf66-3650-4c28-8bca-de849cbe7f72	806008	29854	716163	7093	5910248	2021-06-06	07:00:00	https://apify.com/tugkan/covid-hu	59991
0e8084f7-349c-40f7-b764-25b6808983e8	806089	29866	717254	7066	5916866	2021-06-07	07:00:00	https://apify.com/tugkan/covid-hu	58969
b7fc69e3-7de8-45e7-80a2-dae2ab192b08	806206	29883	718577	6890	5922744	2021-06-08	08:01:00	https://apify.com/tugkan/covid-hu	57746
bca2fd67-923b-447b-bd51-7f01f88a2868	806385	29889	720400	6749	5936304	2021-06-09	07:00:00	https://apify.com/tugkan/covid-hu	56096
1ca456d9-bb48-42d6-a6dc-b494e8a40243	806591	29896	722296	6189	5948874	2021-06-10	08:01:00	https://apify.com/tugkan/covid-hu	54399
1a6da153-95e8-46c2-ac26-8162fcb9b9b7	806790	29904	724614	6182	5962887	2021-06-11	08:01:00	https://apify.com/tugkan/covid-hu	52272
f58c9d75-c34f-463f-b2d8-fe33165c276e	807045	29925	730588	5567	5991170	2021-06-14	07:00:00	https://apify.com/tugkan/covid-hu	46532
e8e8a364-28c9-444b-8395-6a333279a8b8	807102	29935	731626	5182	5996016	2021-06-15	07:00:00	https://apify.com/tugkan/covid-hu	45541
6285fe3e-95ba-44b3-83e8-f275ed48d6b9	807209	29944	732901	4665	6009124	2021-06-16	07:00:00	https://apify.com/tugkan/covid-hu	44364
dfed245b-283c-4e93-95fe-354d22e2728f	807322	29948	733907	4411	6020027	2021-06-17	07:00:00	https://apify.com/tugkan/covid-hu	43467
aebbcf12-0667-4215-a435-8875e4925a50	807428	29950	734627	4044	6033519	2021-06-18	07:00:00	https://apify.com/tugkan/covid-hu	42851
f0bf9cad-2685-4410-9d73-9f7eb417ff6e	807630	29959	735574	3969	6058488	2021-06-21	07:01:00	https://apify.com/tugkan/covid-hu	42097
f5703e33-407b-4ab4-821c-78d07b3b9fa7	807684	29963	735937	3866	6062806	2021-06-22	07:00:00	https://apify.com/tugkan/covid-hu	41784
e316f962-b7b3-45c3-9ec9-4672960f6cdb	807775	29971	736387	3322	6073516	2021-06-23	08:01:00	https://apify.com/tugkan/covid-hu	41417
80287770-13b1-4b86-bc16-8f75994df1c8	807844	29972	736854	2973	6083248	2021-06-24	08:00:00	https://apify.com/tugkan/covid-hu	41018
6298b0ed-fc5a-4778-a855-3486bddc3f21	807910	29980	737233	2701	6094415	2021-06-25	08:00:00	https://apify.com/tugkan/covid-hu	40697
c1488fa8-46b7-4ee7-a910-20dbff7f2d58	808042	29989	738391	2614	6116542	2021-06-28	09:01:00	https://apify.com/tugkan/covid-hu	39662
114bfe21-9ad4-4ce5-9a94-f19f98be3381	808076	29991	738542	2376	6120838	2021-06-29	07:00:00	https://apify.com/tugkan/covid-hu	39543
5729deae-e20e-4d00-b0aa-3d7d762b6536	808128	29992	738782	2212	6130295	2021-06-30	08:00:00	https://apify.com/tugkan/covid-hu	39354
5b21ba23-e393-4f96-9436-7d1675e7a2c5	808160	29992	739204	1998	6138529	2021-07-01	07:00:00	https://apify.com/tugkan/covid-hu	38964
9205808f-7fc3-48c6-a59d-29860ef2dcff	808197	29992	739561	1851	6145920	2021-07-02	08:00:00	https://apify.com/tugkan/covid-hu	38644
4b6c8a65-e49a-423f-87f8-08aaca51a399	808262	29996	740195	2332	6164167	2021-07-05	07:00:00	https://apify.com/tugkan/covid-hu	38071
02c9d69d-a364-4326-9563-0d4458afbb8a	808294	29998	740327	1852	6168335	2021-07-06	07:00:00	https://apify.com/tugkan/covid-hu	37969
729ab928-3002-4159-823b-ab0b84a4d47b	808338	29999	740535	1778	6173422	2021-07-07	08:00:00	https://apify.com/tugkan/covid-hu	37804
ca868a3e-ab8d-40fe-bc75-c678cb440abd	808393	30004	740790	1678	6179187	2021-07-08	08:00:00	https://apify.com/tugkan/covid-hu	37599
959b1868-609b-481b-b531-a4d8e5d2b092	808437	30004	741083	1629	6192388	2021-07-09	08:01:00	https://apify.com/tugkan/covid-hu	37350
2dc52c6d-7e33-4f93-bdf8-57f85ed885e2	808539	30007	741509	1649	6210862	2021-07-12	07:00:00	https://apify.com/tugkan/covid-hu	37023
cf1e29ce-e318-401f-bd3c-a0ed55168a63	808556	30010	741663	1659	6214858	2021-07-13	08:00:00	https://apify.com/tugkan/covid-hu	36883
b53e825c-d094-441d-b679-c9ce4f45a440	808612	30013	741896	1582	6222052	2021-07-14	07:00:00	https://apify.com/tugkan/covid-hu	36703
0a9f9963-9d1d-453e-956e-b9ce68530520	808661	30013	742270	1544	6229508	2021-07-15	07:00:00	https://apify.com/tugkan/covid-hu	36378
420fc4e7-73a7-4843-8fea-56be2fcc9e60	808725	30015	742632	1473	6238275	2021-07-16	07:00:00	https://apify.com/tugkan/covid-hu	36078
73c341d4-4599-4c61-9395-ab89820943c0	808864	30017	743245	1594	6257264	2021-07-19	07:00:00	https://apify.com/tugkan/covid-hu	35602
1b7e557b-fc8f-4b58-be40-bec82ca52017	808889	30019	743449	1504	6261622	2021-07-20	07:00:00	https://apify.com/tugkan/covid-hu	35421
5b2be8c0-a70a-4bba-8ea9-ec0113e474ab	808945	30019	744051	1409	6268163	2021-07-21	07:00:00	https://apify.com/tugkan/covid-hu	34875
3b955203-160d-4c30-9b84-2660d7b5d065	809016	30020	744714	1384	6274804	2021-07-22	07:00:00	https://apify.com/tugkan/covid-hu	34282
d5da91ee-6f45-4743-9538-7ba6ec619102	809101	30020	745277	1376	6284811	2021-07-23	07:00:00	https://apify.com/tugkan/covid-hu	33804
b5c04d31-44af-4d36-b31a-37e9667e0b55	809262	30020	745848	1517	6303940	2021-07-26	07:00:00	https://apify.com/tugkan/covid-hu	33394
4d714690-6179-452b-9d7c-9241fbb15dbc	809288	30021	746219	1471	6308291	2021-07-27	07:00:00	https://apify.com/tugkan/covid-hu	33048
b587d6a7-afc6-4787-8dd2-03d3c06747c1	809362	30025	746981	1475	6316629	2021-07-28	07:00:00	https://apify.com/tugkan/covid-hu	32356
9d9734a5-af03-44fa-be92-31da475b88a8	809427	30025	747512	1412	6323793	2021-07-29	07:00:00	https://apify.com/tugkan/covid-hu	31890
15d06d38-a931-497f-af30-e8e9fce697bd	809491	30026	748157	1335	6328373	2021-07-30	08:00:00	https://apify.com/tugkan/covid-hu	31308
c580b517-dea7-473a-9ac8-9de835235bd2	809491	30026	748157	1335	6328373	2021-07-30	10:00:00	https://apify.com/tugkan/covid-hu	31308
69fb2a76-b224-4629-8d3d-65478d03fd7f	809646	30027	749185	1365	6348148	2021-08-02	08:00:00	https://apify.com/tugkan/covid-hu	30434
f0f277a9-072d-4590-b7d7-d4bc9bfdec59	809672	30029	749461	1349	6352215	2021-08-03	07:00:00	https://apify.com/tugkan/covid-hu	30182
cc5e9ba4-76ed-4a35-a75d-df61c338aa67	809731	30032	749773	1412	6360304	2021-08-04	08:00:00	https://apify.com/tugkan/covid-hu	29926
b76c2c3d-bc9d-43c1-9f54-7b62f2f98a7e	809803	30032	750955	1364	6367442	2021-08-05	08:00:00	https://apify.com/tugkan/covid-hu	28816
b0d9dbc1-ab8d-499f-bd27-2584f42ca043	809855	30033	752709	1346	6375668	2021-08-06	08:00:00	https://apify.com/tugkan/covid-hu	27113
bf6f805b-9e28-496f-98f1-e10e895fb5dd	810011	30037	757247	1252	6395030	2021-08-09	08:00:00	https://apify.com/tugkan/covid-hu	22727
c12198e7-5128-4ba7-9df5-e56bbe190649	810046	30037	759033	1137	6399106	2021-08-10	08:01:00	https://apify.com/tugkan/covid-hu	20976
b1c11ed3-c0f2-4026-ad95-82818008545d	810126	30037	761265	1233	6407283	2021-08-11	07:00:00	https://apify.com/tugkan/covid-hu	18824
0e396960-f4e2-4366-b467-eb7257037111	810212	30037	763801	1168	6415557	2021-08-12	08:00:00	https://apify.com/tugkan/covid-hu	16374
323af0eb-b646-4825-8eb3-086b9764a773	810316	30038	765952	1085	6423992	2021-08-13	08:00:00	https://apify.com/tugkan/covid-hu	14326
65913790-09f5-4e3e-af98-664ee29f11b3	810504	30041	768308	835	6445084	2021-08-16	08:00:00	https://apify.com/tugkan/covid-hu	12155
1bb0b970-7e5f-4c80-9342-0f215484e6aa	810549	30042	768519	731	6449264	2021-08-17	08:01:00	https://apify.com/tugkan/covid-hu	11988
f4bbc809-b3b7-4f96-9d9b-f61b01067ec8	810658	30045	768891	864	6457558	2021-08-18	07:00:00	https://apify.com/tugkan/covid-hu	11722
f924a707-f534-42f8-83a3-14ece110310e	810781	30046	769777	879	6467683	2021-08-19	08:01:00	https://apify.com/tugkan/covid-hu	10958
ecfb90c4-1c91-46ad-b005-96a4762700e5	811121	30052	771530	865	6492441	2021-08-23	08:00:00	https://apify.com/tugkan/covid-hu	9539
f63760e2-f990-40c4-99b9-0469b71e7d30	811121	30052	771530	865	6498814	2021-08-23	10:00:00	https://apify.com/tugkan/covid-hu	9539
ec1dd70b-63fa-4440-be49-f2300447b46d	811203	30054	772241	942	6504169	2021-08-24	07:00:00	https://apify.com/tugkan/covid-hu	8908
17b03137-8625-42d2-a8ef-ed222625d395	811337	30055	773569	1101	6513515	2021-08-25	08:00:00	https://apify.com/tugkan/covid-hu	7713
14e6476b-2ce5-4bfa-a367-3b0f4ca00a4c	811517	30056	774600	1217	6531925	2021-08-26	07:00:00	https://apify.com/tugkan/covid-hu	6861
b6478f1d-d37a-4f19-91a9-0757647daa71	811706	30057	775286	1137	6542042	2021-08-27	08:00:00	https://apify.com/tugkan/covid-hu	6363
84d4a944-55b6-4c74-9aa6-b2ab6c1bf96c	812227	30057	777234	1270	6568905	2021-08-30	08:00:00	https://apify.com/tugkan/covid-hu	4936
97265b5b-f67c-409a-a88e-5ded5ef35c1d	812337	30058	777445	1344	6574523	2021-08-31	08:00:00	https://apify.com/tugkan/covid-hu	4834
92641bd0-d012-4603-90a1-373db38ba16c	812531	30059	777646	1437	6584218	2021-09-01	08:00:00	https://apify.com/tugkan/covid-hu	4826
192daad9-7f76-4632-a5f2-420106914ecd	812531	30059	777646	1437	6584218	2021-09-02	08:00:00	https://apify.com/tugkan/covid-hu	4826
e82fb52e-7e39-47c7-956e-c21441039c83	812793	30060	777909	1750	6595169	2021-09-02	10:00:00	https://apify.com/tugkan/covid-hu	4824
3e68448d-a6fe-4e91-b31b-0a681b74ea3e	813040	30061	777988	1874	6606051	2021-09-03	08:00:00	https://apify.com/tugkan/covid-hu	4991
7cb01ca1-51e7-4799-af90-6192b2493461	813688	30070	778236	1799	6634089	2021-09-06	07:00:00	https://apify.com/tugkan/covid-hu	5382
542018e4-1554-46e5-ade1-6e6df8fd64f1	813818	30074	778258	1955	6640890	2021-09-07	07:00:00	https://apify.com/tugkan/covid-hu	5486
8dd2f7b8-5a86-44a9-ace2-642c30132f81	814064	30077	778401	2212	6651684	2021-09-08	07:00:00	https://apify.com/tugkan/covid-hu	5586
4db67db8-c1b2-4505-aec8-5f36aaa7bd04	814409	30080	778531	2563	6664898	2021-09-09	07:00:00	https://apify.com/tugkan/covid-hu	5798
3d252367-94d9-4760-a3ea-a5117a3ac3ed	814732	30086	778640	2868	6679227	2021-09-10	07:00:00	https://apify.com/tugkan/covid-hu	6006
465b1af0-6b49-41d5-b757-5ad4f5c78f1d	815605	30098	779005	2630	6715858	2021-09-13	08:00:00	https://apify.com/tugkan/covid-hu	6502
cd5b20fe-46de-498b-a4fc-ea6669909108	815851	30102	779114	2842	6724821	2021-09-14	07:00:00	https://apify.com/tugkan/covid-hu	6635
328c2b95-056a-4014-9ebb-e392b2f49df7	960844	32171	825775	42931	7854966	2021-11-15	10:00:00	https://apify.com/tugkan/covid-hu	102898
1a40c603-819a-43ef-bc80-cc037e65ed4e	966167	32336	827237	41353	7876457	2021-11-16	08:00:00	https://apify.com/tugkan/covid-hu	106594
120d1176-2ea6-493f-95c2-725bbde0208f	966167	32336	827237	41353	7876457	2021-11-16	09:00:00	https://apify.com/tugkan/covid-hu	106594
50374e6a-c46b-469c-87c1-7ed5c04c57d3	976432	32514	828535	46530	7909782	2021-11-17	08:00:00	https://apify.com/tugkan/covid-hu	115383
1a305f00-974a-4c1d-8daf-1e39a790496e	987199	32645	833416	54312	7954654	2021-11-18	08:00:00	https://apify.com/tugkan/covid-hu	121138
e9649fa0-aa16-477d-95f4-45acc1144eca	998488	32780	837584	59177	8006581	2021-11-19	08:00:00	https://apify.com/tugkan/covid-hu	128124
6641a91a-a6f1-4a0e-81c2-cf5ac4d0b094	1025697	33172	847992	50429	8134310	2021-11-22	08:00:00	https://apify.com/tugkan/covid-hu	144533
1a686765-1b3b-4940-8db6-80e340a1fc71	1032215	33343	851314	49737	8157875	2021-11-23	08:01:00	https://apify.com/tugkan/covid-hu	147558
dcf1c400-adab-4f6f-b7b2-236f736c588b	1044852	33519	856330	54978	8196724	2021-11-24	08:01:00	https://apify.com/tugkan/covid-hu	155003
40c05f11-3f6b-4580-b49c-65c49c444508	1057017	33704	857451	64002	8249524	2021-11-25	08:00:00	https://apify.com/tugkan/covid-hu	165862
75714918-783a-491d-8d53-3682eaa5c9e3	1068888	33866	862534	66834	8298820	2021-11-26	08:01:00	https://apify.com/tugkan/covid-hu	172488
951acdfd-f079-4d08-803e-c781d0cd244a	1068888	33866	862534	66834	8298820	2021-11-28	08:00:00	https://apify.com/tugkan/covid-hu	172488
73079ea0-10e0-4d9a-b062-9ba954a0ba14	1096718	34326	877251	52452	8423435	2021-11-29	08:00:00	https://apify.com/tugkan/covid-hu	185141
c6f41d6f-638d-4234-b5cd-3c6e9c13f93e	1103108	34521	882659	49607	8443744	2021-11-30	08:00:00	https://apify.com/tugkan/covid-hu	185928
c6536962-a065-4d4b-b684-dee29d871202	1114260	34713	891691	53551	8474664	2021-12-01	08:01:00	https://apify.com/tugkan/covid-hu	187856
04d7f5ec-f65c-41f4-bed1-43e09191dc05	1124726	34931	902000	59593	8516699	2021-12-02	08:00:00	https://apify.com/tugkan/covid-hu	187795
7f2a139d-a274-43a1-b94f-ed6c59f5f267	1134869	35122	910745	60555	8559975	2021-12-03	08:00:00	https://apify.com/tugkan/covid-hu	189002
71cc2a81-d04c-4ff1-95ea-683dcae5a5c5	1157568	35611	932204	48217	8666739	2021-12-06	09:00:00	https://apify.com/tugkan/covid-hu	189753
99e84172-67bd-4a54-abaf-54125c3ccc34	1161879	35835	938836	45198	8679620	2021-12-07	08:00:00	https://apify.com/tugkan/covid-hu	187208
4d3f604f-7d4b-4b4c-8c6a-b66dc5ed69f3	1168728	36048	948385	47718	8701776	2021-12-08	08:00:00	https://apify.com/tugkan/covid-hu	184295
7279e6b2-fc11-46ce-8c5f-0417b6fea0f2	1176038	36263	955248	53187	8734938	2021-12-09	08:00:00	https://apify.com/tugkan/covid-hu	184527
88f12dd9-b209-49ff-bc82-a99434243810	1182922	36429	968897	55544	8768881	2021-12-10	08:00:00	https://apify.com/tugkan/covid-hu	177596
ce6c22c5-97c3-4ef7-8bb1-66e1f956c178	1198939	36884	991639	43047	8853922	2021-12-13	08:00:00	https://apify.com/tugkan/covid-hu	170416
50983f97-f09b-4115-873b-db3e7fdd1d18	1202514	37079	996517	40518	8868961	2021-12-14	08:00:00	https://apify.com/tugkan/covid-hu	168918
ffc4a62c-5645-4b2b-abf0-c8fb40640297	1208020	37232	1005586	42569	8890023	2021-12-15	09:00:00	https://apify.com/tugkan/covid-hu	165202
59c94d54-0b12-4092-9106-dffef89c74b0	1213318	37376	1016089	45659	8919775	2021-12-16	09:00:00	https://apify.com/tugkan/covid-hu	159853
88ed401f-1bd1-49e2-9dc7-158b325267e0	1218295	37530	1026254	45852	8947845	2021-12-17	08:00:00	https://apify.com/tugkan/covid-hu	154511
449cbb8e-a24d-47a5-9bce-8c63c599bfb4	1228400	37896	1048633	33383	9014430	2021-12-20	08:00:00	https://apify.com/tugkan/covid-hu	141871
06be2b9e-5bec-447b-bc1b-22061e3e0b34	1230385	38028	1054288	31543	9021858	2021-12-21	08:00:00	https://apify.com/tugkan/covid-hu	138069
9221eaeb-f0e7-460b-bbb6-2423b981f3d5	1233744	38167	1060360	31081	9037023	2021-12-22	08:00:00	https://apify.com/tugkan/covid-hu	135217
b96bcbd0-faf8-40d0-909d-20849ca4b21e	1237330	38307	1071772	32319	9058668	2021-12-23	08:00:00	https://apify.com/tugkan/covid-hu	127251
6a11ed60-ed69-489e-a29f-ee4a8fa65b8a	1245319	38743	1087943	17751	9114949	2021-12-27	08:00:00	https://apify.com/tugkan/covid-hu	118633
f59c2507-1ff9-44d8-817a-220f856466f7	1246689	38894	1091017	15775	9119505	2021-12-28	09:00:00	https://apify.com/tugkan/covid-hu	116778
f6c482c6-5d07-48cb-bde8-cf4a19cbeb57	1249694	39009	1097628	15599	9135056	2021-12-29	08:00:00	https://apify.com/tugkan/covid-hu	113057
ff5ea714-3d60-4edb-825a-bbac97845af4	1253055	39104	1106531	16380	9152694	2021-12-30	08:00:00	https://apify.com/tugkan/covid-hu	107420
95843602-b4f0-428d-ba4e-dafeddc7ec8c	1256415	39186	1111676	16422	9169355	2021-12-31	08:00:00	https://apify.com/tugkan/covid-hu	105553
14c06ce0-bbf4-4cb0-8de9-2a6f2274eb02	1262280	39434	1121823	12946	9203581	2022-01-03	08:01:00	https://apify.com/tugkan/covid-hu	101023
b1171901-5fd1-4c2c-8212-f27e363f9116	1264709	39517	1124945	13266	9211426	2022-01-04	08:00:00	https://apify.com/tugkan/covid-hu	100247
97dab288-72c9-42ed-a9a9-0673a9829bf9	1269979	39599	1128923	14894	9229190	2022-01-05	08:00:00	https://apify.com/tugkan/covid-hu	101457
0a45248c-d213-4905-b7de-574a03f955fe	1276433	39679	1133345	17424	9256170	2022-01-06	08:00:00	https://apify.com/tugkan/covid-hu	103409
080d1fb5-cfb7-4078-8d80-2a7712f4b9d2	1282957	39780	1137648	20298	9285125	2022-01-07	08:01:00	https://apify.com/tugkan/covid-hu	105529
20a8b8db-4257-4623-a2ee-b329cf083b86	1297612	39947	1145770	21527	9358739	2022-01-10	09:00:00	https://apify.com/tugkan/covid-hu	111895
38733d70-dd96-47dc-88d3-e5c1ff5a6f47	1300994	40016	1147818	25978	9367973	2022-01-11	09:00:00	https://apify.com/tugkan/covid-hu	113160
64591f7e-8e69-4409-a68b-988cd5ffecd4	1308877	40083	1149849	33421	9386272	2022-01-12	08:01:00	https://apify.com/tugkan/covid-hu	118945
1b95280c-99fa-41bd-a045-2bad239ba270	1318093	40164	1155505	40560	9417820	2022-01-13	09:00:00	https://apify.com/tugkan/covid-hu	122424
20c29c38-621e-4d28-b4b4-8134315bf12f	1327014	40237	1158509	44692	9448157	2022-01-14	08:00:00	https://apify.com/tugkan/covid-hu	128268
0aadd659-f6fd-48b9-8494-be92c71c57a8	1348233	40507	1169775	39669	9530346	2022-01-17	08:00:00	https://apify.com/tugkan/covid-hu	137951
a1a65c05-c189-4497-9f28-50b889e7b2fe	1355084	40601	1176855	37207	9546334	2022-01-18	08:00:00	https://apify.com/tugkan/covid-hu	137628
626bdaee-91f5-430e-ae7c-70f77b73ee12	1369974	40686	1181715	38652	9572149	2022-01-19	08:00:00	https://apify.com/tugkan/covid-hu	147573
fb292290-9e1f-4b49-95c8-f15954e59f45	1385500	40757	1186319	34810	9612654	2022-01-20	08:00:00	https://apify.com/tugkan/covid-hu	158424
0e363ed9-bd85-4e26-bbfd-30a93b54d8d7	1401457	40822	1193210	42534	9661929	2022-01-21	08:03:00	https://apify.com/tugkan/covid-hu	167425
c2e57298-6b59-4f94-8fb2-56f5ecad59a9	1441385	40944	1209129	25782	9794753	2022-01-24	08:00:00	https://apify.com/tugkan/covid-hu	191312
04f9f212-a2e9-4d34-9bfd-1e64974d90af	1451102	41018	1216454	24128	9812780	2022-01-25	08:00:00	https://apify.com/tugkan/covid-hu	193630
647df9cd-d006-422e-9ef1-0029d7cc49ac	1471276	41087	1224813	24297	9839158	2022-01-26	08:00:00	https://apify.com/tugkan/covid-hu	205376
80902e10-1462-4380-b846-e7a79d441262	1490489	41151	1233499	26734	9887968	2022-01-27	08:00:00	https://apify.com/tugkan/covid-hu	215839
ef8fa440-3d79-4029-b7a0-e664fb65b7ae	1508358	41229	1241328	29596	9936724	2022-01-28	09:00:00	https://apify.com/tugkan/covid-hu	225801
d072bd98-7965-455b-b7ab-4994d662e0b9	1553405	41405	1280399	24157	10071349	2022-01-31	08:00:00	https://apify.com/tugkan/covid-hu	231601
6e158be7-176a-4c44-8e61-5795f368f0ac	1562827	41471	1291499	23308	10089540	2022-02-01	09:00:00	https://apify.com/tugkan/covid-hu	229857
34cd638b-9d7d-4e2d-a570-a8d54e2fa54a	1582517	41548	1310420	21859	10116075	2022-02-02	09:00:00	https://apify.com/tugkan/covid-hu	230549
d0027ad0-e074-4cd2-a2a8-17aa1416b580	1600411	41636	1330876	23192	10161911	2022-02-03	09:00:00	https://apify.com/tugkan/covid-hu	227899
0e3dd32f-0e2e-418e-890c-1cbed636f112	1616846	41741	1347698	25718	10207444	2022-02-04	08:00:00	https://apify.com/tugkan/covid-hu	227407
bf42d596-b29b-41fd-90e8-fd1bac59a6c1	1650562	41975	1377097	22859	10320134	2022-02-07	08:00:00	https://apify.com/tugkan/covid-hu	231490
5254fdb8-4787-4c20-bde5-d9d69935a423	1657615	42069	1384170	23288	10332848	2022-02-08	08:00:00	https://apify.com/tugkan/covid-hu	231376
e0cecc8a-1d7d-4321-8821-2e8db5511a57	1671547	42170	1400137	22242	10354374	2022-02-09	08:00:00	https://apify.com/tugkan/covid-hu	229240
01fb3ba2-8742-4d1d-9d35-0baa1f109faa	1684432	42269	1410550	23046	10391977	2022-02-10	09:00:00	https://apify.com/tugkan/covid-hu	231613
58edaa9c-4a83-41da-8aa3-7c9a8b5e3f96	1695991	42360	1423921	24341	10429713	2022-02-11	08:00:00	https://apify.com/tugkan/covid-hu	229710
9d31ffa0-b448-48ae-8acf-f45bc8438905	1717072	42631	1450631	20046	10513080	2022-02-14	09:00:00	https://apify.com/tugkan/covid-hu	223810
dce9c81f-1560-401c-93e9-0bd3753054a8	1721483	42754	1468444	18572	10520765	2022-02-15	08:00:00	https://apify.com/tugkan/covid-hu	210285
b8327521-c7d9-4714-8b86-bb953d99fa45	1730366	42851	1478480	18079	10538698	2022-02-16	08:00:00	https://apify.com/tugkan/covid-hu	209035
ec6b06a3-8bed-4683-b48f-18b5e2c05cc8	1738944	42966	1493240	18627	10570027	2022-02-17	08:00:00	https://apify.com/tugkan/covid-hu	202738
f9101dd3-5530-4285-b37c-f3c3d71f16db	1746424	43066	1504055	19612	10597050	2022-02-18	08:00:00	https://apify.com/tugkan/covid-hu	199303
22599175-bd53-49e1-9a7a-10ce07c4e6e5	1759685	43299	1526826	16290	10662822	2022-02-21	09:00:00	https://apify.com/tugkan/covid-hu	189560
e052d69b-6ced-433e-8d58-8a5e4ee46669	1762878	43430	1535456	15314	10669050	2022-02-22	08:00:00	https://apify.com/tugkan/covid-hu	183992
e196adde-9d2e-41b9-9605-bf8e6a4a1535	1769164	43562	1546872	14632	10686340	2022-02-23	08:01:00	https://apify.com/tugkan/covid-hu	178730
e2ad3061-a2bd-477c-b1cb-2a38ed2589ef	1774676	43664	1557214	14566	10711279	2022-02-24	09:00:00	https://apify.com/tugkan/covid-hu	173798
f062a549-5609-4d68-ab25-a16d20e6e8e7	1779174	43752	1566509	14999	10733913	2022-02-25	08:00:00	https://apify.com/tugkan/covid-hu	168913
5326db28-151c-437a-99a5-202c2a08078e	1787544	43949	1588843	11624	10784987	2022-02-28	09:00:00	https://apify.com/tugkan/covid-hu	154752
d4586323-87fb-455a-b6cc-eefb463c7840	1789581	44051	1595008	10799	10789819	2022-03-01	08:00:00	https://apify.com/tugkan/covid-hu	150522
9fc52ea2-4dd9-41cc-8637-d53234a0ed28	1793120	44134	1606084	9800	10800452	2022-03-02	08:00:00	https://apify.com/tugkan/covid-hu	142902
22fd4eb3-8ea3-4b3b-893e-9320df3a5438	1796982	44211	1610315	9646	10818978	2022-03-03	08:00:00	https://apify.com/tugkan/covid-hu	142456
ed0f7fa2-446e-4b70-9b20-66ab59d717f9	1800046	44286	1618574	9718	10836962	2022-03-04	08:00:00	https://apify.com/tugkan/covid-hu	137186
5163d75a-5d83-451f-932e-96bf8b4f18be	1805898	44436	1632325	7342	10878929	2022-03-07	08:00:00	https://apify.com/tugkan/covid-hu	129137
a2fdda11-4802-4c4e-a610-015d71b58d3d	1807285	44495	1636781	7342	10882684	2022-03-08	08:00:00	https://apify.com/tugkan/covid-hu	126009
34d001c3-2078-424c-95ec-7d55a3cdf93f	1809917	44549	1641256	7342	10892581	2022-03-09	08:01:00	https://apify.com/tugkan/covid-hu	124112
73493a94-bfa3-44e7-b6a6-6e027558d21b	1812294	44603	1646037	7342	10907123	2022-03-10	08:00:00	https://apify.com/tugkan/covid-hu	121654
9217257e-06e4-4d90-adb0-71e5b62641be	1814362	44653	1650643	7342	10921558	2022-03-11	08:00:00	https://apify.com/tugkan/covid-hu	119066
2b30bdda-b670-44e2-bbb9-827670dc8d6f	1819264	44831	1663907	7342	10962084	2022-03-16	09:00:00	https://apify.com/tugkan/covid-hu	110526
229b6568-02e1-455a-b9be-cfd19bf3ce93	1820767	44895	1667111	7342	10965815	2022-03-17	08:00:00	https://apify.com/tugkan/covid-hu	108761
911459be-d683-4a09-92bc-ec0d4a09568f	1824089	44961	1672699	7342	10975485	2022-03-18	09:00:00	https://apify.com/tugkan/covid-hu	106429
3d7b9e17-d70f-4536-84a4-fb016c134468	1829928	45095	1681268	7342	11018428	2022-03-21	08:01:00	https://apify.com/tugkan/covid-hu	103565
eb7a4bef-ad7e-4a4d-8ae7-c2274fff63dd	1831423	45143	1683014	7342	11022242	2022-03-22	08:00:00	https://apify.com/tugkan/covid-hu	103266
c3eca017-5f72-4187-ad5b-77e18f89b627	1834268	45185	1686319	7342	11031587	2022-03-23	08:00:00	https://apify.com/tugkan/covid-hu	102764
aa6ba5a8-f374-4788-b64c-42fe1aa2b6df	1836919	45220	1689460	8411	11040273	2022-03-24	08:00:00	https://apify.com/tugkan/covid-hu	102239
a745ab18-5815-4ac6-9dc5-29d8e97336c2	1839358	45258	1693393	8857	11053112	2022-03-25	08:00:00	https://apify.com/tugkan/covid-hu	100707
01cef8bd-ef7d-4840-a241-035eaf28a5d6	1844581	45342	1699172	8857	11086534	2022-03-28	07:00:00	https://apify.com/tugkan/covid-hu	100067
75704011-3416-43b9-b210-55085ebfcba0	1846311	45390	1700728	8234	11094272	2022-03-29	07:00:00	https://apify.com/tugkan/covid-hu	100193
6903ef8c-0436-4130-b3d2-727cdd37e4b5	1849217	45430	1703932	8234	11103060	2022-03-30	07:00:00	https://apify.com/tugkan/covid-hu	99855
1aaaa29a-6f28-498c-a920-ad6b2f0493fd	1849217	45430	1703932	8296	11103060	2022-03-30	08:00:00	https://apify.com/tugkan/covid-hu	99855
df74c2e0-825b-4db9-b78d-de794fe6432d	1851871	45470	1706726	8412	11115682	2022-03-31	07:00:00	https://apify.com/tugkan/covid-hu	99675
20c816f1-bb47-4836-8629-010660da41c0	1854198	45510	1709370	9191	11127382	2022-04-01	07:00:00	https://apify.com/tugkan/covid-hu	99318
d8416148-fd9d-4142-a771-bb408cc6a656	1860159	45611	1717268	7540	11158930	2022-04-05	07:00:00	https://apify.com/tugkan/covid-hu	97280
e42aa037-1ff1-48a2-8ec8-aa5490a5fd1a	1863039	45647	1720497	7340	11168674	2022-04-06	07:00:00	https://apify.com/tugkan/covid-hu	96895
fc9c7ab8-316d-430b-8812-cbc01869b4ef	1865607	45684	1723020	7340	11180076	2022-04-07	08:01:00	https://apify.com/tugkan/covid-hu	96903
32aad457-aa4e-4c8e-8cd4-ddd24944e1e8	1865607	45684	1723020	7799	11180076	2022-04-07	10:00:00	https://apify.com/tugkan/covid-hu	96903
ceb3df6d-355d-409b-b0d8-49a525f2734d	1868007	45721	1725324	8258	11191893	2022-04-08	08:00:00	https://apify.com/tugkan/covid-hu	96962
18ef2733-9b00-44ee-8edd-d635a7a2b48e	1872664	45781	1731816	8258	11221030	2022-04-11	08:00:00	https://apify.com/tugkan/covid-hu	95067
cf2fd1d3-dd95-4669-88a1-b08f2f21ebe3	1872664	45781	1731816	8681	11221030	2022-04-11	09:00:00	https://apify.com/tugkan/covid-hu	95067
6749d4f4-7ccf-4627-ad88-b15e8a62e857	1874206	45812	1735929	8681	11225020	2022-04-12	07:00:00	https://apify.com/tugkan/covid-hu	92465
d1a02c28-7e7e-4e34-a79e-05d2c4f965af	1874206	45812	1735929	5608	11225020	2022-04-12	09:00:00	https://apify.com/tugkan/covid-hu	92465
8a9894d7-ddc8-4028-a3e8-a32aa809ba76	1876946	45838	1742051	5027	11233362	2022-04-13	08:00:00	https://apify.com/tugkan/covid-hu	89057
ef9c9847-f0cd-4538-a06b-6bcd7c498e12	1879480	45865	1748707	3931	11244573	2022-04-14	08:00:00	https://apify.com/tugkan/covid-hu	84908
ca14e763-914c-47da-9349-8b46d90a10ad	1884458	45971	1760777	3609	11275271	2022-04-19	07:00:00	https://apify.com/tugkan/covid-hu	77710
e3911264-de6a-4ce5-9bf7-7c7578872a5e	1885865	46000	1763911	1715	11278894	2022-04-20	08:01:00	https://apify.com/tugkan/covid-hu	75954
2d3f047d-733b-49e4-b6a6-e96b2b24af07	1888906	46024	1770066	1652	11285527	2022-04-21	07:00:00	https://apify.com/tugkan/covid-hu	72816
83e83728-d092-4a5b-8c1c-982508a7bff8	1890953	46048	1776617	1612	11295119	2022-04-22	07:00:00	https://apify.com/tugkan/covid-hu	68288
a67d0f56-7f96-4938-a680-1cc0a987debb	1894278	46101	1788191	1757	11315178	2022-04-25	08:00:00	https://apify.com/tugkan/covid-hu	59986
c145d0a4-4389-4ded-80d1-f0b7bb0c8891	1895677	46133	1792616	1915	11317807	2022-04-26	07:00:00	https://apify.com/tugkan/covid-hu	56928
bb054a76-c841-46ed-8b30-9e918410c8e2	1897897	46162	1797144	1451	11324260	2022-04-27	08:00:00	https://apify.com/tugkan/covid-hu	54591
8244072e-9d01-4ff6-b585-6aafbbee9941	1899633	46189	1801813	2218	11331451	2022-04-28	07:00:00	https://apify.com/tugkan/covid-hu	51631
e4f4d537-0d92-4b75-88a8-301a6e534c0d	1901017	46201	1804295	2360	11339446	2022-04-29	08:00:00	https://apify.com/tugkan/covid-hu	50521
8eb29ff1-90af-4353-8626-0f8720092e4b	1903200	46266	1808061	2401	11355462	2022-05-02	07:00:00	https://apify.com/tugkan/covid-hu	48873
4a2933b2-7bd2-4901-b848-6148e22c57d9	1909948	46343	1821435	1365	11394556	2022-05-11	07:01:00	https://apify.com/tugkan/covid-hu	42170
71ae7cf6-41d4-44a3-8c70-f795f917148c	1914697	46446	1830803	694	11394556	2022-05-18	07:00:00	https://apify.com/tugkan/covid-hu	37448
d330bffe-a5e9-4014-9495-f4c7b72db5d7	1917777	46507	1841731	523	11394556	2022-05-25	07:00:00	https://apify.com/tugkan/covid-hu	29539
6ff015b3-935c-40ce-8406-0ec4c6aa0d5a	1919840	46547	1847746	345	11394556	2022-06-01	08:00:00	https://apify.com/tugkan/covid-hu	25547
c20a35a8-80c1-4409-9eb6-c649c139a864	1921486	46571	1853094	238	11394556	2022-06-08	08:00:00	https://apify.com/tugkan/covid-hu	21821
31678732-87e1-4898-8843-8cff16c08c75	1923122	46594	1862334	237	11394556	2022-06-15	07:00:00	https://apify.com/tugkan/covid-hu	14194
061d901d-0006-4526-8503-ebcd87cd79a1	1925083	46626	1869244	147	11394556	2022-06-22	08:02:00	https://apify.com/tugkan/covid-hu	9213
c4c1d76a-f30b-4c54-9447-9f6de60c270c	1928125	46647	1871930	208	11394556	2022-06-29	08:00:00	https://apify.com/tugkan/covid-hu	9548
9b1e56ba-6851-439e-8cd5-96134a7ddc76	1932788	46661	1874932	428	11394556	2022-07-06	08:00:00	https://apify.com/tugkan/covid-hu	11195
161e17a6-d343-4db6-8e31-45e551b75002	1940824	46696	1878221	727	11394556	2022-07-13	07:00:00	https://apify.com/tugkan/covid-hu	15907
4e638fd4-278a-4f77-a9b5-72397f2674ff	1951079	46736	1883085	1083	11394556	2022-07-20	08:01:00	https://apify.com/tugkan/covid-hu	21258
35562d22-03d3-475c-b96f-46d486547f98	1965481	46790	1890181	1757	11394556	2022-07-27	07:00:00	https://apify.com/tugkan/covid-hu	28510
d61c5049-273e-48f9-9c88-711db7714edd	1987321	46886	1898374	2115	11394556	2022-08-03	07:00:00	https://apify.com/tugkan/covid-hu	42061
ff338eea-ad88-4ec6-b2d0-6cb7bd8e34ae	2005399	46966	1908907	2099	11394556	2022-08-10	07:00:00	https://apify.com/tugkan/covid-hu	49526
94a2de16-3f93-43aa-9106-b5408f48f158	2021648	47083	1924022	2099	11394556	2022-08-17	07:00:00	https://apify.com/tugkan/covid-hu	50543
c51cc727-6867-4c4f-b056-01ce6a1c0b55	2036390	47191	1945910	2099	11394556	2022-08-24	07:00:00	https://apify.com/tugkan/covid-hu	43289
\.


--
-- Data for Name: app_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_user (password, last_login, id, email, "firstName", "lastName", is_staff, is_active, is_superuser, valid, "dateJoined") FROM stdin;
pbkdf2_sha256$390000$d6bIAce48jkQ9O7vbKI3np$rurldU7MDk89/tkX9CsaXz2ohws6d4jNvlM/I7xYSho=	2022-11-16 18:54:11.548541+01	3a9f8235-0428-433f-af7d-16d69e68d80a	superuser@superuser.superuser			t	t	t	t	2022-04-06 13:37:06.585473+02
pbkdf2_sha256$320000$7v3DSexwQ9yghyORmTK6Cs$oFHJsBYS6Wu9dpnIOhfhc0TugqvbZlXgoM5WUkGpLhc=	2022-04-06 15:14:00.114192+02	74e65f0d-baaa-4b3d-abe2-91dfa81f8532	user@user.user			t	t	f	t	2022-04-06 15:12:50.670696+02
\.


--
-- Data for Name: app_user_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_user_groups (id, user_id, group_id) FROM stdin;
1	3a9f8235-0428-433f-af7d-16d69e68d80a	1
2	74e65f0d-baaa-4b3d-abe2-91dfa81f8532	2
\.


--
-- Data for Name: app_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.app_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group (id, name) FROM stdin;
2	Users
1	Supers
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	1	7
8	1	8
9	1	9
10	1	10
11	1	11
12	1	12
13	1	13
14	1	14
15	1	15
16	1	16
17	1	17
18	1	18
19	1	19
20	1	20
21	1	21
22	1	22
23	1	23
24	1	24
25	1	25
26	1	26
27	1	27
28	1	28
29	2	24
30	2	21
31	2	22
32	2	23
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add Covid	6	add_covid
22	Can change Covid	6	change_covid
23	Can delete Covid	6	delete_covid
24	Can view Covid	6	view_covid
25	Can add User	7	add_user
26	Can change User	7	change_user
27	Can delete User	7	delete_user
28	Can view User	7	view_user
29	Can add CovidData	8	add_coviddata
30	Can change CovidData	8	change_coviddata
31	Can delete CovidData	8	delete_coviddata
32	Can view CovidData	8	view_coviddata
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2022-04-06 15:01:00.318336+02	1	Super	1	[{"added": {}}]	3	3a9f8235-0428-433f-af7d-16d69e68d80a
2	2022-04-06 15:01:24.717127+02	3a9f8235-0428-433f-af7d-16d69e68d80a	superuser@superuser.superuser	2	[{"changed": {"fields": ["Groups"]}}]	7	3a9f8235-0428-433f-af7d-16d69e68d80a
3	2022-04-06 15:03:20.153709+02	2	Users	1	[{"added": {}}]	3	3a9f8235-0428-433f-af7d-16d69e68d80a
4	2022-04-06 15:03:37.149038+02	1	Supers	2	[{"changed": {"fields": ["Name"]}}]	3	3a9f8235-0428-433f-af7d-16d69e68d80a
5	2022-04-06 15:12:50.862138+02	74e65f0d-baaa-4b3d-abe2-91dfa81f8532	user@user.user	1	[{"added": {}}]	7	3a9f8235-0428-433f-af7d-16d69e68d80a
6	2022-04-06 15:33:50.426487+02	c6efa581-ae0c-4b1b-809f-c25d5aae3b33	CovidData object (c6efa581-ae0c-4b1b-809f-c25d5aae3b33)	1	[{"added": {}}]	8	3a9f8235-0428-433f-af7d-16d69e68d80a
7	2022-04-07 09:35:40.432141+02	c6efa581-ae0c-4b1b-809f-c25d5aae3b33	CovidData object (c6efa581-ae0c-4b1b-809f-c25d5aae3b33)	2	[{"changed": {"fields": ["Date", "Time"]}}]	8	3a9f8235-0428-433f-af7d-16d69e68d80a
8	2022-04-07 09:35:58.825169+02	c6efa581-ae0c-4b1b-809f-c25d5aae3b33	CovidData object (c6efa581-ae0c-4b1b-809f-c25d5aae3b33)	2	[]	8	3a9f8235-0428-433f-af7d-16d69e68d80a
9	2022-04-07 09:53:52.567558+02	c6efa581-ae0c-4b1b-809f-c25d5aae3b33	2022-04-06 07:53:49	2	[{"changed": {"fields": ["Time"]}}]	8	3a9f8235-0428-433f-af7d-16d69e68d80a
10	2022-04-07 09:54:07.474861+02	c6efa581-ae0c-4b1b-809f-c25d5aae3b33	2022-04-06 10:00:00	2	[{"changed": {"fields": ["Time"]}}]	8	3a9f8235-0428-433f-af7d-16d69e68d80a
11	2022-04-07 10:01:42.798095+02	fd67ae80-fbfb-4490-a14e-03850993cf07	2022-04-06 11:00:00	1	[{"added": {}}]	8	3a9f8235-0428-433f-af7d-16d69e68d80a
12	2022-04-07 10:02:07.258656+02	fd67ae80-fbfb-4490-a14e-03850993cf07	2022-04-07 11:00:00	2	[{"changed": {"fields": ["Date"]}}]	8	3a9f8235-0428-433f-af7d-16d69e68d80a
13	2022-04-07 10:11:23.62409+02	c6efa581-ae0c-4b1b-809f-c25d5aae3b33	2022-04-06 10:00:00	2	[{"changed": {"fields": ["Sourceweb"]}}]	8	3a9f8235-0428-433f-af7d-16d69e68d80a
14	2022-04-07 10:11:36.038497+02	fd67ae80-fbfb-4490-a14e-03850993cf07	2022-04-07 11:00:00	2	[{"changed": {"fields": ["Sourceweb"]}}]	8	3a9f8235-0428-433f-af7d-16d69e68d80a
15	2022-04-07 17:05:12.851851+02	fd67ae80-fbfb-4490-a14e-03850993cf07	2022-04-07 10:00:00	2	[{"changed": {"fields": ["Time"]}}]	8	3a9f8235-0428-433f-af7d-16d69e68d80a
16	2022-04-13 13:06:32.640449+02	ab32d7e4-e1fe-4e43-94f5-95c89fe26d8b	2022-04-13 08:00:00	3		8	3a9f8235-0428-433f-af7d-16d69e68d80a
17	2022-04-19 16:20:34.506432+02	0006076f-65c7-4920-9ff4-4edc18bc910f	2022-04-19 14:20:31	1	[{"added": {}}]	8	3a9f8235-0428-433f-af7d-16d69e68d80a
18	2022-04-19 16:21:05.592149+02	608c27ec-84a9-4941-9bed-08d7dd72c026	2022-04-17 14:20:31	1	[{"added": {}}]	8	3a9f8235-0428-433f-af7d-16d69e68d80a
19	2022-04-19 16:23:54.078668+02	608c27ec-84a9-4941-9bed-08d7dd72c026	2022-04-17 14:20:31	3		8	3a9f8235-0428-433f-af7d-16d69e68d80a
20	2022-04-19 16:27:49.62952+02	da419e06-b486-49bb-8e6f-0fbcc12aa9d8	2022-04-17 14:27:43	1	[{"added": {}}]	8	3a9f8235-0428-433f-af7d-16d69e68d80a
21	2022-04-19 16:29:22.735589+02	da419e06-b486-49bb-8e6f-0fbcc12aa9d8	2022-04-17 14:27:43	3		8	3a9f8235-0428-433f-af7d-16d69e68d80a
22	2022-04-19 16:29:50.470534+02	32de4cce-692e-4ad6-b9b5-a34214177875	2022-04-17 14:29:46	1	[{"added": {}}]	8	3a9f8235-0428-433f-af7d-16d69e68d80a
23	2022-04-19 16:39:04.633504+02	b108478f-58a6-4a76-ae1a-49ac382a9e4b	2022-04-17 14:38:56	1	[{"added": {}}]	8	3a9f8235-0428-433f-af7d-16d69e68d80a
24	2022-04-19 16:39:16.940632+02	b108478f-58a6-4a76-ae1a-49ac382a9e4b	2022-04-17 14:38:56	3		8	3a9f8235-0428-433f-af7d-16d69e68d80a
25	2022-04-20 08:59:21.50773+02	1314788a-c4fd-409f-9130-ccfa3e1cce9f	2022-04-14 08:00:00	3		8	3a9f8235-0428-433f-af7d-16d69e68d80a
26	2022-04-20 09:06:30.821059+02	3f1781ba-fd61-405e-a791-88889e0c6d0e	2022-04-14 08:00:00	3		8	3a9f8235-0428-433f-af7d-16d69e68d80a
27	2022-04-20 11:28:55.322664+02	51b01b93-22a2-46a1-a857-41ba70fd86fd	2022-04-14 08:00:00	3		8	3a9f8235-0428-433f-af7d-16d69e68d80a
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	app	covid
7	app	user
8	app	coviddata
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-04-06 13:36:25.127823+02
2	contenttypes	0002_remove_content_type_name	2022-04-06 13:36:25.134242+02
3	auth	0001_initial	2022-04-06 13:36:25.159609+02
4	auth	0002_alter_permission_name_max_length	2022-04-06 13:36:25.165355+02
5	auth	0003_alter_user_email_max_length	2022-04-06 13:36:25.169969+02
6	auth	0004_alter_user_username_opts	2022-04-06 13:36:25.174628+02
7	auth	0005_alter_user_last_login_null	2022-04-06 13:36:25.179316+02
8	auth	0006_require_contenttypes_0002	2022-04-06 13:36:25.180872+02
9	auth	0007_alter_validators_add_error_messages	2022-04-06 13:36:25.185444+02
10	auth	0008_alter_user_username_max_length	2022-04-06 13:36:25.189968+02
11	auth	0009_alter_user_last_name_max_length	2022-04-06 13:36:25.194746+02
12	auth	0010_alter_group_name_max_length	2022-04-06 13:36:25.200492+02
13	auth	0011_update_proxy_permissions	2022-04-06 13:36:25.205106+02
14	auth	0012_alter_user_first_name_max_length	2022-04-06 13:36:25.209798+02
15	app	0001_initial	2022-04-06 13:36:25.238967+02
16	admin	0001_initial	2022-04-06 13:36:25.254687+02
17	admin	0002_logentry_remove_auto_add	2022-04-06 13:36:25.263431+02
18	admin	0003_logentry_add_action_flag_choices	2022-04-06 13:36:25.269782+02
19	sessions	0001_initial	2022-04-06 13:36:25.276131+02
20	app	0002_coviddata_delete_covid	2022-04-06 15:28:00.72583+02
21	app	0003_coviddata_date_coviddata_time	2022-04-07 09:25:56.580458+02
22	app	0004_coviddata_datetime_unique	2022-04-07 09:34:55.899266+02
23	app	0005_alter_coviddata_options_remove_coviddata_datetime	2022-04-07 09:50:45.567472+02
24	app	0006_remove_user_username	2022-04-07 09:59:07.848549+02
25	app	0007_remove_coviddata_datetime_unique_coviddata_datetime	2022-04-07 10:00:51.264598+02
26	app	0008_coviddata_sourceweb	2022-04-07 10:08:29.397504+02
27	app	0009_alter_coviddata_sourceweb	2022-04-07 10:10:22.974601+02
28	app	0010_coviddata_activeinfected	2022-04-08 14:21:48.906748+02
29	app	0011_alter_coviddata_deceased_alter_coviddata_infected_and_more	2022-04-19 16:27:17.300731+02
30	app	0012_alter_coviddata_activeinfected	2022-04-19 16:28:59.153554+02
31	app	0013_rename_activeinfected_coviddata_activeinfected_and_more	2022-09-26 11:47:26.705368+02
32	app	0014_rename_isactive_user_is_active_and_more	2022-09-26 11:52:16.086259+02
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
my4lnm59d1797ou7wpukwzwxpdwrzb8f	.eJxVzDsOwjAQRdG9uCbW-JPxmJKeNURjj00CKJHyqRB7h0gpoH73vJfqeFv7blvK3A2izspxrGRd24C31HjnasM1SGNQMBYkIWB1-mWJ86OMu5U7j7dJ52lc5yHpPdHHuujrJOV5Odq_g56X_qsLeU8t2wim5JgEEqD4ErIYG0xm8BJCAO8oQrU1mYwuRnAWDWakpN4fpyJAAA:1nh5Zk:US9z2XXHwJ_kNPtJk1Tque24GIiUMFNO05BMkDnHMEk	2022-05-04 10:20:36.566231+02
00eovu772l9ps57myuuotg13f75cvc0e	.eJxVzDsOwjAQRdG9uCbW-JPxmJKeNURjj00CKJHyqRB7h0gpoH73vJfqeFv7blvK3A2izspxrGRd24C31HjnasM1SGNQMBYkIWB1-mWJ86OMu5U7j7dJ52lc5yHpPdHHuujrJOV5Odq_g56X_qsLeU8t2wim5JgEEqD4ErIYG0xm8BJCAO8oQrU1mYwuRnAWDWakpN4fpyJAAA:1nh7qA:oJfrnRJIqyyDYM4TJuMJFh3mVx7sHHwD9-uuvIMBtMA	2022-05-04 12:45:42.940882+02
\.


--
-- Name: app_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.app_user_groups_id_seq', 2, true);


--
-- Name: app_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.app_user_user_permissions_id_seq', 1, false);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 2, true);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 32, true);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 32, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 27, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 8, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 32, true);


--
-- Name: app_coviddata app_coviddata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_coviddata
    ADD CONSTRAINT app_coviddata_pkey PRIMARY KEY (id);


--
-- Name: app_user app_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_email_key UNIQUE (email);


--
-- Name: app_user_groups app_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user_groups
    ADD CONSTRAINT app_user_groups_pkey PRIMARY KEY (id);


--
-- Name: app_user_groups app_user_groups_user_id_group_id_73b8e940_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user_groups
    ADD CONSTRAINT app_user_groups_user_id_group_id_73b8e940_uniq UNIQUE (user_id, group_id);


--
-- Name: app_user app_user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user
    ADD CONSTRAINT app_user_pkey PRIMARY KEY (id);


--
-- Name: app_user_user_permissions app_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user_user_permissions
    ADD CONSTRAINT app_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: app_user_user_permissions app_user_user_permissions_user_id_permission_id_7c8316ce_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user_user_permissions
    ADD CONSTRAINT app_user_user_permissions_user_id_permission_id_7c8316ce_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: app_coviddata datetime; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_coviddata
    ADD CONSTRAINT datetime UNIQUE (date, "time");


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: app_user_email_efde8896_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_user_email_efde8896_like ON public.app_user USING btree (email varchar_pattern_ops);


--
-- Name: app_user_groups_group_id_e774d92c; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_user_groups_group_id_e774d92c ON public.app_user_groups USING btree (group_id);


--
-- Name: app_user_groups_user_id_e6f878f6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_user_groups_user_id_e6f878f6 ON public.app_user_groups USING btree (user_id);


--
-- Name: app_user_user_permissions_permission_id_4ef8e133; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_user_user_permissions_permission_id_4ef8e133 ON public.app_user_user_permissions USING btree (permission_id);


--
-- Name: app_user_user_permissions_user_id_24780b52; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX app_user_user_permissions_user_id_24780b52 ON public.app_user_user_permissions USING btree (user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: app_user_groups app_user_groups_group_id_e774d92c_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user_groups
    ADD CONSTRAINT app_user_groups_group_id_e774d92c_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_user_groups app_user_groups_user_id_e6f878f6_fk_app_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user_groups
    ADD CONSTRAINT app_user_groups_user_id_e6f878f6_fk_app_user_id FOREIGN KEY (user_id) REFERENCES public.app_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_user_user_permissions app_user_user_permis_permission_id_4ef8e133_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user_user_permissions
    ADD CONSTRAINT app_user_user_permis_permission_id_4ef8e133_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: app_user_user_permissions app_user_user_permissions_user_id_24780b52_fk_app_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.app_user_user_permissions
    ADD CONSTRAINT app_user_user_permissions_user_id_24780b52_fk_app_user_id FOREIGN KEY (user_id) REFERENCES public.app_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_app_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_app_user_id FOREIGN KEY (user_id) REFERENCES public.app_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

