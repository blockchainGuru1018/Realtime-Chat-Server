--
-- PostgreSQL database dump
--

-- Dumped from database version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)
-- Dumped by pg_dump version 10.12 (Ubuntu 10.12-0ubuntu0.18.04.1)

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: api_callinfo; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.api_callinfo (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    status character varying(60) NOT NULL,
    duration integer NOT NULL,
    from_user_id integer NOT NULL,
    to_user_id integer NOT NULL
);


ALTER TABLE public.api_callinfo OWNER TO weaveuser;

--
-- Name: api_callinfo_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.api_callinfo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_callinfo_id_seq OWNER TO weaveuser;

--
-- Name: api_callinfo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.api_callinfo_id_seq OWNED BY public.api_callinfo.id;


--
-- Name: api_customuser; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.api_customuser (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    phone_number character varying(128) NOT NULL,
    full_name character varying(60) NOT NULL,
    dob date,
    bio text NOT NULL,
    address character varying(120) NOT NULL,
    location public.geometry(Point,4326) NOT NULL,
    is_location boolean NOT NULL,
    photo character varying(100),
    is_blocked boolean NOT NULL
);


ALTER TABLE public.api_customuser OWNER TO weaveuser;

--
-- Name: api_customuser_black_list; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.api_customuser_black_list (
    id integer NOT NULL,
    from_customuser_id integer NOT NULL,
    to_customuser_id integer NOT NULL
);


ALTER TABLE public.api_customuser_black_list OWNER TO weaveuser;

--
-- Name: api_customuser_black_list_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.api_customuser_black_list_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_customuser_black_list_id_seq OWNER TO weaveuser;

--
-- Name: api_customuser_black_list_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.api_customuser_black_list_id_seq OWNED BY public.api_customuser_black_list.id;


--
-- Name: api_customuser_groups; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.api_customuser_groups (
    id integer NOT NULL,
    customuser_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.api_customuser_groups OWNER TO weaveuser;

--
-- Name: api_customuser_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.api_customuser_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_customuser_groups_id_seq OWNER TO weaveuser;

--
-- Name: api_customuser_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.api_customuser_groups_id_seq OWNED BY public.api_customuser_groups.id;


--
-- Name: api_customuser_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.api_customuser_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_customuser_id_seq OWNER TO weaveuser;

--
-- Name: api_customuser_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.api_customuser_id_seq OWNED BY public.api_customuser.id;


--
-- Name: api_customuser_user_permissions; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.api_customuser_user_permissions (
    id integer NOT NULL,
    customuser_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.api_customuser_user_permissions OWNER TO weaveuser;

--
-- Name: api_customuser_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.api_customuser_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_customuser_user_permissions_id_seq OWNER TO weaveuser;

--
-- Name: api_customuser_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.api_customuser_user_permissions_id_seq OWNED BY public.api_customuser_user_permissions.id;


--
-- Name: api_group; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.api_group (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    photo character varying(100),
    access_key character varying(100),
    general_access boolean NOT NULL,
    creater_id integer
);


ALTER TABLE public.api_group OWNER TO weaveuser;

--
-- Name: api_group_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.api_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_group_id_seq OWNER TO weaveuser;

--
-- Name: api_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.api_group_id_seq OWNED BY public.api_group.id;


--
-- Name: api_group_members; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.api_group_members (
    id integer NOT NULL,
    group_id integer NOT NULL,
    customuser_id integer NOT NULL
);


ALTER TABLE public.api_group_members OWNER TO weaveuser;

--
-- Name: api_group_members_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.api_group_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_group_members_id_seq OWNER TO weaveuser;

--
-- Name: api_group_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.api_group_members_id_seq OWNED BY public.api_group_members.id;


--
-- Name: api_likemessage; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.api_likemessage (
    id integer NOT NULL,
    updated timestamp with time zone NOT NULL,
    is_like boolean NOT NULL,
    message_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.api_likemessage OWNER TO weaveuser;

--
-- Name: api_likemessage_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.api_likemessage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_likemessage_id_seq OWNER TO weaveuser;

--
-- Name: api_likemessage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.api_likemessage_id_seq OWNED BY public.api_likemessage.id;


--
-- Name: api_phonetoken; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.api_phonetoken (
    id integer NOT NULL,
    phone_number character varying(128) NOT NULL,
    otp character varying(40) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    attempts integer NOT NULL,
    used boolean NOT NULL
);


ALTER TABLE public.api_phonetoken OWNER TO weaveuser;

--
-- Name: api_phonetoken_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.api_phonetoken_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_phonetoken_id_seq OWNER TO weaveuser;

--
-- Name: api_phonetoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.api_phonetoken_id_seq OWNED BY public.api_phonetoken.id;


--
-- Name: api_voicemessage; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.api_voicemessage (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    file character varying(100),
    from_user_id integer NOT NULL,
    to_user_id integer,
    is_heard boolean NOT NULL,
    is_seen boolean NOT NULL,
    extra_file character varying(100),
    extra_type character varying(10),
    text text,
    group_id integer
);


ALTER TABLE public.api_voicemessage OWNER TO weaveuser;

--
-- Name: api_voicemessage_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.api_voicemessage_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.api_voicemessage_id_seq OWNER TO weaveuser;

--
-- Name: api_voicemessage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.api_voicemessage_id_seq OWNED BY public.api_voicemessage.id;


--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO weaveuser;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO weaveuser;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO weaveuser;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO weaveuser;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO weaveuser;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO weaveuser;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO weaveuser;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO weaveuser;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO weaveuser;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO weaveuser;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO weaveuser;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO weaveuser;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO weaveuser;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO weaveuser;

--
-- Name: friendship_friend; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.friendship_friend (
    id integer NOT NULL,
    created timestamp with time zone NOT NULL,
    from_user_id integer NOT NULL,
    to_user_id integer NOT NULL
);


ALTER TABLE public.friendship_friend OWNER TO weaveuser;

--
-- Name: friendship_friend_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.friendship_friend_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friendship_friend_id_seq OWNER TO weaveuser;

--
-- Name: friendship_friend_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.friendship_friend_id_seq OWNED BY public.friendship_friend.id;


--
-- Name: friendship_friendshiprequest; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.friendship_friendshiprequest (
    id integer NOT NULL,
    message text NOT NULL,
    created timestamp with time zone NOT NULL,
    rejected timestamp with time zone,
    viewed timestamp with time zone,
    from_user_id integer NOT NULL,
    to_user_id integer NOT NULL
);


ALTER TABLE public.friendship_friendshiprequest OWNER TO weaveuser;

--
-- Name: friendship_friendshiprequest_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.friendship_friendshiprequest_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.friendship_friendshiprequest_id_seq OWNER TO weaveuser;

--
-- Name: friendship_friendshiprequest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.friendship_friendshiprequest_id_seq OWNED BY public.friendship_friendshiprequest.id;


--
-- Name: push_notifications_apnsdevice; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.push_notifications_apnsdevice (
    id integer NOT NULL,
    name character varying(255),
    active boolean NOT NULL,
    date_created timestamp with time zone,
    device_id uuid,
    registration_id character varying(200) NOT NULL,
    user_id integer,
    application_id character varying(64)
);


ALTER TABLE public.push_notifications_apnsdevice OWNER TO weaveuser;

--
-- Name: push_notifications_apnsdevice_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.push_notifications_apnsdevice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.push_notifications_apnsdevice_id_seq OWNER TO weaveuser;

--
-- Name: push_notifications_apnsdevice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.push_notifications_apnsdevice_id_seq OWNED BY public.push_notifications_apnsdevice.id;


--
-- Name: push_notifications_gcmdevice; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.push_notifications_gcmdevice (
    id integer NOT NULL,
    name character varying(255),
    active boolean NOT NULL,
    date_created timestamp with time zone,
    device_id bigint,
    registration_id text NOT NULL,
    user_id integer,
    cloud_message_type character varying(3) NOT NULL,
    application_id character varying(64)
);


ALTER TABLE public.push_notifications_gcmdevice OWNER TO weaveuser;

--
-- Name: push_notifications_gcmdevice_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.push_notifications_gcmdevice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.push_notifications_gcmdevice_id_seq OWNER TO weaveuser;

--
-- Name: push_notifications_gcmdevice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.push_notifications_gcmdevice_id_seq OWNED BY public.push_notifications_gcmdevice.id;


--
-- Name: push_notifications_webpushdevice; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.push_notifications_webpushdevice (
    id integer NOT NULL,
    name character varying(255),
    active boolean NOT NULL,
    date_created timestamp with time zone,
    application_id character varying(64),
    registration_id text NOT NULL,
    p256dh character varying(88) NOT NULL,
    auth character varying(24) NOT NULL,
    browser character varying(10) NOT NULL,
    user_id integer
);


ALTER TABLE public.push_notifications_webpushdevice OWNER TO weaveuser;

--
-- Name: push_notifications_webpushdevice_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.push_notifications_webpushdevice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.push_notifications_webpushdevice_id_seq OWNER TO weaveuser;

--
-- Name: push_notifications_webpushdevice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.push_notifications_webpushdevice_id_seq OWNED BY public.push_notifications_webpushdevice.id;


--
-- Name: push_notifications_wnsdevice; Type: TABLE; Schema: public; Owner: weaveuser
--

CREATE TABLE public.push_notifications_wnsdevice (
    id integer NOT NULL,
    name character varying(255),
    active boolean NOT NULL,
    date_created timestamp with time zone,
    device_id uuid,
    registration_id text NOT NULL,
    user_id integer,
    application_id character varying(64)
);


ALTER TABLE public.push_notifications_wnsdevice OWNER TO weaveuser;

--
-- Name: push_notifications_wnsdevice_id_seq; Type: SEQUENCE; Schema: public; Owner: weaveuser
--

CREATE SEQUENCE public.push_notifications_wnsdevice_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.push_notifications_wnsdevice_id_seq OWNER TO weaveuser;

--
-- Name: push_notifications_wnsdevice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: weaveuser
--

ALTER SEQUENCE public.push_notifications_wnsdevice_id_seq OWNED BY public.push_notifications_wnsdevice.id;


--
-- Name: api_callinfo id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_callinfo ALTER COLUMN id SET DEFAULT nextval('public.api_callinfo_id_seq'::regclass);


--
-- Name: api_customuser id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser ALTER COLUMN id SET DEFAULT nextval('public.api_customuser_id_seq'::regclass);


--
-- Name: api_customuser_black_list id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser_black_list ALTER COLUMN id SET DEFAULT nextval('public.api_customuser_black_list_id_seq'::regclass);


--
-- Name: api_customuser_groups id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser_groups ALTER COLUMN id SET DEFAULT nextval('public.api_customuser_groups_id_seq'::regclass);


--
-- Name: api_customuser_user_permissions id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.api_customuser_user_permissions_id_seq'::regclass);


--
-- Name: api_group id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_group ALTER COLUMN id SET DEFAULT nextval('public.api_group_id_seq'::regclass);


--
-- Name: api_group_members id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_group_members ALTER COLUMN id SET DEFAULT nextval('public.api_group_members_id_seq'::regclass);


--
-- Name: api_likemessage id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_likemessage ALTER COLUMN id SET DEFAULT nextval('public.api_likemessage_id_seq'::regclass);


--
-- Name: api_phonetoken id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_phonetoken ALTER COLUMN id SET DEFAULT nextval('public.api_phonetoken_id_seq'::regclass);


--
-- Name: api_voicemessage id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_voicemessage ALTER COLUMN id SET DEFAULT nextval('public.api_voicemessage_id_seq'::regclass);


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: friendship_friend id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.friendship_friend ALTER COLUMN id SET DEFAULT nextval('public.friendship_friend_id_seq'::regclass);


--
-- Name: friendship_friendshiprequest id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.friendship_friendshiprequest ALTER COLUMN id SET DEFAULT nextval('public.friendship_friendshiprequest_id_seq'::regclass);


--
-- Name: push_notifications_apnsdevice id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.push_notifications_apnsdevice ALTER COLUMN id SET DEFAULT nextval('public.push_notifications_apnsdevice_id_seq'::regclass);


--
-- Name: push_notifications_gcmdevice id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.push_notifications_gcmdevice ALTER COLUMN id SET DEFAULT nextval('public.push_notifications_gcmdevice_id_seq'::regclass);


--
-- Name: push_notifications_webpushdevice id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.push_notifications_webpushdevice ALTER COLUMN id SET DEFAULT nextval('public.push_notifications_webpushdevice_id_seq'::regclass);


--
-- Name: push_notifications_wnsdevice id; Type: DEFAULT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.push_notifications_wnsdevice ALTER COLUMN id SET DEFAULT nextval('public.push_notifications_wnsdevice_id_seq'::regclass);


--
-- Data for Name: api_callinfo; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.api_callinfo (id, created, status, duration, from_user_id, to_user_id) FROM stdin;
\.


--
-- Data for Name: api_customuser; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.api_customuser (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined, phone_number, full_name, dob, bio, address, location, is_location, photo, is_blocked) FROM stdin;
21	pbkdf2_sha256$150000$DFuNbHdQSHHg$heifKMprk2fsp1rkvQnZ5sXDnAxLKNM3ZWKjeDDReso=	2020-03-02 23:49:00.172767+00	f	1057b580-f1df-4e87-849f-a9c64249cd79				f	t	2020-03-02 23:48:59.719604+00	+18195762842	al4	2000-01-02	Bonjour		0101000020E610000000000000000000000000000000000000	f	FFBB687A-FEA0-4BA1-A93C-F25D68CA4F17.png	f
11	pbkdf2_sha256$150000$St9menfe5jtZ$zhWea8WfMRl5A8Uk+eKIGmtMwC7f5c+4ZFXfoEax0pI=	2020-02-19 18:26:38.792478+00	f	b9e07cfa-3ab6-4a07-b06d-a8b18c97e900				f	t	2020-02-19 18:26:38.560359+00	+8613109880761	bib	2019-02-20	Sdf		0101000020E610000000000000000000000000000000000000	f	B59FB860-FF51-47D5-B9D7-4A8BF308EC1E.png	f
30	pbkdf2_sha256$150000$kQeYPqHtLe19$6/vRSzNYYaI+Cvy1PQOSGvdp6SCOjJ6RJBNmV32ufIQ=	2020-03-03 02:35:09.345838+00	f	bd342572-fdc7-4c17-9ee5-f8450dee9e00				f	t	2020-03-03 02:35:09.132557+00	+15147778013	Kalisa	2020-05-02	💘💕		0101000020E610000000000000000000000000000000000000	f	4B5C0A60-31A5-4FAF-A68C-2F230FE45693.png	f
121	pbkdf2_sha256$150000$hpdScT8Dq4Hp$Z4OwuX/poQJGi3JwGfdvquJ5+tX3CC7Vs7a9suq/OXE=	2020-03-13 05:58:48.177855+00	f	66d7cc07-4543-4063-a40e-ea77c0f49caa				f	t	2020-03-13 05:58:47.984581+00	+16137910605	Stephane	1991-02-15	Don’t take me to seriously		0101000020E610000000000000000000000000000000000000	f	0E12272F-65A9-4699-9519-D883677B90FB.png	f
54	pbkdf2_sha256$150000$JndBAPMXezMP$HwOLe1ZBkoZVNa1uvdkiDjW43Iqtmn25PHBlr+uQUh0=	2020-03-04 04:29:19.303674+00	f	0b47afda-949b-4705-80e9-f1e6a95ad42c				f	t	2020-03-04 04:29:18.911729+00	+14793220162	Guillain	1998-03-03	Engineer, entrepreneur and a loving family member.		0101000020E610000000000000000000000000000000000000	f	B7D38F21-B5E9-47F6-B62E-80BCCBB8416B.png	f
41	pbkdf2_sha256$150000$jVVh7C0rkn1Z$UBqOPC6zeQY9YFnJGmik9UEa2RigX2lyXz9JQfqz/yw=	2020-03-03 15:36:47.378425+00	f	9417a94d-8ed5-4da4-bbf5-b73dd87a4b70				f	t	2020-03-03 15:36:47.126439+00	+16137206698	Steve	1997-09-01	Yo!		0101000020E610000000000000000000000000000000000000	f	F017ECCB-0D5B-4DF0-B81F-F54F7178B357.png	f
10	pbkdf2_sha256$150000$c2l7jS1IJ6QF$3b+zKdLhqDjrXFMHPCZZeusht7VvhCiGxm8eZZrHyWk=	2020-02-27 21:37:02.021551+00	f	cc4173d3-077b-4d7c-a959-34263f9d8471				f	t	2020-02-17 19:01:27.424439+00	+14084766514	fly	2004-02-17	Test		0101000020E61000000000006082BC424000000060877B5EC0	f	1B93BBBA-FE32-4BAD-9B43-C29CE3A9930C.png	f
25	pbkdf2_sha256$150000$8ECWQbpDcdNx$ckKQNFNPeTHlKfHXtf6iUt6RsatDPucnZ82wA75tpOE=	2020-03-03 01:09:46.10046+00	f	cd30d208-f8cd-4ced-bdb1-ba054943741c				f	t	2020-03-03 01:09:45.878537+00	+18194616270	rohit	1998-03-10	Rohit		0101000020E6100000411B4F77A8B04640B06FFA9408F052C0	f	DAA10325-A0D1-4C5A-BA84-1CA279588EFA.png	f
27	pbkdf2_sha256$150000$wTGqTV5jlSfd$R0d06bg75DdXNfO4KCNjKeme6jN5eFRr5Cf468IbGME=	2020-03-03 01:44:16.778261+00	f	3eb9444d-f1f9-4672-a9fc-f2bc16465991				f	t	2020-03-03 01:44:16.584902+00	+16134134833	Deborah	1995-11-14	Ask me :)		0101000020E610000000000000000000000000000000000000	f	5672E965-DA87-4815-9A9C-55506E51AF2F.png	f
86	pbkdf2_sha256$150000$41jRQZbLvg1S$AilbS/b6tf8AKN4Cow90mkhUlAK0DaLa6vuLg4ll//o=	2020-03-08 00:25:01.040994+00	f	3b488f9d-1ec5-4102-a90d-4c7ee6068476				f	t	2020-03-08 00:25:00.759007+00	+14794354252	ninenty-nine	1996-03-02	Poet,singer, dancer and aspiring engineer		0101000020E610000000000000000000000000000000000000	f	417525C6-8D1E-4851-84A3-A42659E54895.png	f
48	pbkdf2_sha256$150000$eg3cAJybPpvt$mLfM6LHlIe5ckJCYK6gC6CyFaVbbEHLExhdF3pQs3nM=	2020-03-03 23:17:38.04652+00	f	a71d1dd2-9b33-4ca6-9a4b-9a854d9ac6a0				f	t	2020-03-03 23:17:37.831448+00	+18197908410	Meech	1997-10-29	🔒💰		0101000020E6100000DC8B49ABFCB746400388649EEDEE52C0	f	81466820-03C1-48F2-AB5D-37EDB85826CE.png	f
47	pbkdf2_sha256$150000$5kuZCEvyX0Hl$v1Tc97s/aFOVfOTLiUqMdSP5Wz8vgOEyPDfnIaVVn7s=	2020-03-03 21:57:32.516492+00	f	13696dff-93ad-42d8-889e-de951cdb7f4e				f	t	2020-03-03 21:57:32.276183+00	+12896845959	hawandeep	1999-07-15	i am best		0101000020E6100000128D7A04A3A246404A3D09CE01EE52C0	f	269B88DB-4F67-4AC7-980E-05D9C2E48448.png	f
104	pbkdf2_sha256$150000$Ko7A3d6Aa5ER$NOZU3VkvdHKAuM8fLJ3wGaTHSD0S5amJCfN5AaKPzZs=	2020-03-09 18:24:02.207423+00	f	3178e6c9-eed3-488a-88ec-0a8b00480897				f	t	2020-03-09 18:24:01.557576+00	+16133230028	Jared	2001-08-17	Hey I’m Jared		0101000020E61000003FE220EEA1B646400B126875A5E952C0	t	740436FB-9536-43BD-8874-39616ED9B251.png	f
3	pbkdf2_sha256$150000$IQ4KgsP6BB0U$46x8HBbFNGGxD1k4YFrLAzWJp1aCWb2Mj/E7jM1v/iM=	2020-02-11 12:31:58.697236+00	f	henry				f	t	2019-12-24 03:03:22+00	+14384531256	Henry	1989-12-24	Err	Test Address	0101000020E61000000F8B6B97F1B0484000000000005356C0	t	A5C03D50-180B-427B-BC71-9D71F58CC98A.png	f
89	pbkdf2_sha256$150000$frngNSe5ECZv$k2CDIsQKr2+2SFijN8l3YFy97cfecBt6cv7CFQ9etmk=	2020-03-09 03:15:38.59805+00	f	664d321f-688f-44a5-a5d7-e634d47448a3				f	t	2020-03-09 03:15:38.317077+00	+14185634591		\N			0101000020E6100000F917D89A576947403B12C49A0CCE51C0	f		f
82	pbkdf2_sha256$150000$9z3yNIElyq2t$IMPGQp1KORb5lwrUQaT2SFOxNyUY4kqEDORdL1DQmIc=	2020-03-07 06:01:17.001016+00	f	91bd888c-6e9e-4d47-887d-639e828f33c4				f	t	2020-03-07 06:01:16.676567+00	+14187175256	Anjelo	1988-07-30	Hello		0101000020E61000006F1CC633EF6947407383478365CE51C0	f	BACA96FA-CF2D-483A-876D-DB29A5BEE800.png	f
37	pbkdf2_sha256$150000$YKotMX1LPfwF$hoHCYMjwpN0fw3s/8pV5RpEKBkPf3KqFaHPix729Lj8=	2020-03-03 13:04:02.494587+00	f	0127ec62-4cb3-43a6-ac1e-a25d840e6042				f	t	2020-03-03 13:04:02.16689+00	+18732887786	Nipun	2001-01-19	Nipun goyal		0101000020E610000000000000000000000000000000000000	f	99098EF8-B160-41A3-89FF-46C7A66B4B05.png	f
6	pbkdf2_sha256$150000$Vu6pOHpxzZ89$qf4DWBu0YElNZFQ3br+xss7defmEaSYrWIdjrVbpfRk=	2020-02-10 21:03:20.772122+00	f	test				f	t	2020-02-01 20:15:43+00	+17075551854	Test Contact	1993-02-01	Test	Test Address	0101000020E6100000CF88B8756BED444040EF65AA9BD85E40	f	6.png	f
63	pbkdf2_sha256$150000$lsR58ohGRH2f$VHpPBm0dYpoDwovvqhYCjxQe0r0w5SmmmCuDoj2Fwus=	2020-03-05 01:59:35.969075+00	f	dcb73404-60f7-4bc5-b3fd-c3506fe45043				f	t	2020-03-05 01:59:35.793672+00	+14037710090	Victoria	2000-07-30	Design entrepreneur		0101000020E6100000CC17469DDA8A4940D8ECB22D5A915CC0	f	F39741D8-FD17-40D6-90C0-1ABAEF7E619C.png	f
33	pbkdf2_sha256$150000$uueFDzlHIf6o$MzWt+uSv6WTOlbif7FhbWPfCjvP6wDMQ3pUKd2Thxi0=	2020-03-03 06:50:32.002172+00	f	c93e98d2-75ac-4d83-bac5-c212f1ede8cb				f	t	2020-03-03 06:50:31.696249+00	+14039095453	Rachael	1999-11-17	Rwandese Ting		0101000020E6100000ADAAAE921D86494032257DABEE845CC0	f	7E006AC7-1C05-4B27-BA04-4D8F6944663F.png	f
34	pbkdf2_sha256$150000$NYuERDX4aoiV$jgLBYDEGGCl+OWK4ss9xsQmlZY4kkIssyWMCHue9pLA=	2020-03-03 09:26:42.417801+00	f	a3694615-547b-403d-a007-2c4a9c98dcb7				f	t	2020-03-03 09:26:42.185186+00	+14388882149	Fabien M	2020-02-29	Rwandese		0101000020E610000048B7CD602AB6464041FA4CB6FD6852C0	f	5B6E7E60-B4DF-4F55-BB8F-A47E857ADE52.png	f
108	pbkdf2_sha256$150000$5zhDmvQW4ebq$8GfJFehJ1GiWHSypnylrOjya6useuDkUlgJ5mEyK2/w=	2020-03-09 19:28:45.073926+00	f	3f69d8ac-d5d9-4a06-8ba7-285050e69b22				f	t	2020-03-09 19:28:44.811466+00	+16137163988		\N			0101000020E610000000000000000000000000000000000000	f		f
43	pbkdf2_sha256$150000$aPwY8WrKEOAm$vm12Mr8u7juqM43zy/gXlXoiHq8RrEuQr4+RuZU27UE=	2020-03-03 17:31:00.717002+00	f	7b6a3640-a239-42c6-9406-8dff4abc8d08				f	t	2020-03-03 17:31:00.38085+00	+14189055709	Deborrah	2020-07-07	Debbie deb		0101000020E6100000A8969E6A19C34640E48DDDA4536652C0	f	0E905078-EA30-4CEF-B0BE-AEB9D99DA524.png	f
75	pbkdf2_sha256$150000$DWK6CnS39YZY$OynZ7gEwOTX9JlEl85aj3sqBXEX0d+KZ45qDn4Rj/tg=	2020-03-06 16:09:11.183822+00	f	f99a61f8-4281-4a25-9bce-aabaf8b19372				f	t	2020-03-06 16:09:10.900317+00	+16139814696		\N			0101000020E610000000000000000000000000000000000000	f		f
14	pbkdf2_sha256$150000$srUKW4adxqpa$EocToxMSGpQGd72wdwYS7ge2Od5J68XR9XH8pNYdSyA=	2020-02-26 12:16:26.492762+00	f	037ebbcf-e610-471a-bc05-05f4fbb520b8				f	t	2020-02-26 12:16:26.271081+00	+8613109880763	Xin	1988-02-26	iOS sssss		0101000020E6100000931804560E9D4840D578E92631C05EC0	t	4305AD38-5A01-4D29-B846-A61805A4BB2C.png	t
12	pbkdf2_sha256$150000$ZLaWvIXr5TGs$PLVnQlnt2j80cOjsA5+mysGSCe8/b7AHZlwT5PfDK+0=	2020-03-01 04:54:53.048139+00	f	25c1197b-1280-4ce3-9a04-fa1cb0128bbf				f	t	2020-02-21 14:08:01.66492+00	+8615734052600	Simul	1994-10-30	queen	asdf	0101000020E6100000000000A03ABB4340000000E09BB95EC0	t	vlcsnap-2018-08-31-11h37m52s91.png	f
2	pbkdf2_sha256$150000$T10N8vu2GI2l$Xb4F51Odbdtf1nl333FR0Vpe92ttaDl33NUiFo71nv0=	2020-02-12 17:45:56.338149+00	f	stanley				f	t	2019-12-23 17:39:56+00	+14387965541	Test	1964-12-23	Test Bio	Test Address	0101000020E610000086764EB340AD4940B4E55C8AAB945CC0	t	E604756A-7BBA-4ECB-B1A4-7F98ADAA5558.png	f
60	pbkdf2_sha256$150000$n0Nkvj3HdxD4$80S65yOhZOlpWFnjwebs052Ql3TLH9IOUr7euvMajF4=	2020-03-05 00:49:21.245632+00	f	9fb88479-2537-4300-b2d6-553c67c01d5b				f	t	2020-03-05 00:49:21.057256+00	+14107141777	gurpreet	1967-06-07	SANDHU		0101000020E610000000000000000000000000000000000000	f	8B8EC083-EDF9-4DE4-942C-A4160163C24B.png	f
22	pbkdf2_sha256$150000$JidCvVdPeCdc$5sUe9w1ZJFzpxolvw3xKluG49FWSqVW5aSxbmvztQEE=	2020-03-02 23:49:31.409706+00	f	7ca12207-cfc6-44ea-a469-0c554271fb2a				f	t	2020-03-02 23:49:31.079173+00	+18193194428	Oulfath	1998-01-30	Lets talk !!		0101000020E61000007FD53026ECB5464014DC0EAFA2EB52C0	f	633D5093-7BF7-4F88-BD69-331A93C1D918.png	f
88	pbkdf2_sha256$150000$3zRiHoFHwDLD$iCdw/flyifWal8T1pOrpfOK+9OqYh9XMbATGm9X3Jik=	2020-03-08 07:39:31.460535+00	f	346822f6-926b-460e-8de9-7e5c4b37ff75				f	t	2020-03-08 07:39:31.15681+00	+18193285011		\N			0101000020E610000000000000000000000000000000000000	f		f
28	pbkdf2_sha256$150000$r1BQPjTb2tT6$swmtDzisdO6Sm8NKrzVIXCGuwPjRBWx8hwAMtFyFing=	2020-03-03 01:58:49.474713+00	f	1c39247c-216c-49f2-b459-5fdde0d28e37				f	t	2020-03-03 01:58:49.177773+00	+16135014556	Navi	1989-08-20	Female		0101000020E610000030171448D9A446406C139C9E05F852C0	f	328B0A03-0B6E-4F58-8127-76DE25CE7D29.png	f
51	pbkdf2_sha256$150000$fWvUZbw73cY8$3WoZaFaLN/CNd36LkKy0b/DAeyaAaiCi2CSCGsWIDUE=	2020-03-04 00:25:05.515526+00	f	cab898cb-098e-42e1-8013-b3abe55ab3a6				f	t	2020-03-04 00:25:05.288941+00	+18195932570	Cando	2020-03-03	Cn		0101000020E610000041F9648670B84640000E8C04F0F252C0	f	6BA1A741-3CCA-4626-8320-DC3326832F6F.png	f
36	pbkdf2_sha256$150000$24yDDr8R0FXN$OoeUuWKMDimgKQcaekSm/GC/TbjPkdv7knJN1kF4koU=	2020-03-03 12:51:38.581522+00	f	b591b940-4479-41bc-a5d6-a72227c54c7d				f	t	2020-03-03 12:51:38.362515+00	+16479144994	vp	1998-11-03	Hi		0101000020E61000006686E84135AD4640D76F76373CF052C0	f	DDEE93C8-F5D2-45E2-ABC8-211655FEE199.png	f
53	pbkdf2_sha256$150000$3E0qoZ7Pfrtt$eL0uHHRURUzYfTJu+uAyXRAoeKjUHQq0TVnpQ2FEHQc=	2020-03-04 00:40:49.011754+00	f	db6c451a-f2ec-4110-823d-b79e82ca9f3a				f	t	2020-03-04 00:40:48.817644+00	+15142094918	Blameless	1993-12-21	Music heals.		0101000020E61000005DD91E92F9C04640B0609E69F66452C0	t	C280609E-3331-43EA-AC4F-B0E05726B4D2.png	f
64	pbkdf2_sha256$150000$jJFa1BpMj7BJ$MkDyYYI1A0q1GthSKr7UDApDiWnvc1v8bWtlwy4RH4Y=	2020-03-05 02:19:28.900393+00	f	72b71d0b-72b6-40d7-a615-8d77929edde6				f	t	2020-03-05 02:19:28.648744+00	+18196650187	Virgo woman 🤩	1995-09-18	Blossom wherever life plants you		0101000020E610000024EB6E0239B04640FFF326F2C2F352C0	f	E4EA9471-7DDF-42CB-AB72-6579F23368DD.png	f
49	pbkdf2_sha256$150000$ljzgYsp6mU4p$w/MiSa+M7PC6EHFvSS4sIRr1aTO6en/ETcgJT35lTXE=	2020-03-04 00:07:23.048158+00	f	8a44831d-6d54-4a80-a635-1f2269d77c4b				f	t	2020-03-04 00:07:22.835763+00	+14388202129	Ignace Nikwivuze	1992-09-03	Young and wild		0101000020E6100000F374CABDAAB74640B0DB6F95676752C0	f	3C80CB7B-EDE1-4443-BBEF-DA81820684CD.png	f
139	pbkdf2_sha256$150000$ggB6dJM6Z0HW$822N9eLFzPdVdT+59iU4Tuk9a6VcIhWuMW1+Lqc0rxI=	2020-03-31 15:59:49.137639+00	f	90db29e6-d654-42dc-b91b-c92843233765				f	t	2020-03-31 15:59:48.982133+00	+18197441243	Allan	2010-03-30	Blessed		0101000020E6100000283F729120B7464001CD292BD2F352C0	f	84359D6A-8FF0-4F10-A25F-A874D968CB4D.png	f
20	pbkdf2_sha256$150000$L1fjQHcrmxVL$pddfJ00HovJzjHlzGbMPg+Akk8iKJ5ZpmC6+2Z6Pr68=	2020-03-02 23:47:06.205505+00	f	5f45d0cb-6147-4bc8-aff3-32d9a946643f				f	t	2020-03-02 23:47:05.678506+00	+13104227623	Jeanne	1977-08-02	Accounting		0101000020E6100000604DF740581D4140ACB04E1220C15DC0	f	F6C9B831-BEF6-45A1-94ED-4A982BB2C7C6.png	f
99	pbkdf2_sha256$150000$Bmt3l0HyLiex$eiZ3rDNwmmyK9VOUyyarg6gXlORLR/93YAF7NJHZfMg=	2020-03-09 16:02:50.258233+00	f	3e7dba47-8557-409b-b0ff-6ac067e411e5				f	t	2020-03-09 16:02:50.009122+00	+16138839020	em	1997-03-09	Hi		0101000020E610000000000000000000000000000000000000	f	0952C4C7-00AE-4581-97FE-9D1F9FBF5564.png	f
24	pbkdf2_sha256$150000$8PzDHmFSBnOm$NAtREMVUAgqtftdut7m4eIFSbw/2BB+IfxEVa3sieq4=	2020-03-03 00:46:02.874171+00	f	0cf537f0-9782-4bfb-9703-a016b1ede28d				f	t	2020-03-03 00:46:02.566551+00	+15813085131	joel mutezintare	1994-04-30	C’est		0101000020E6100000AC932F86B5BA464024981AFF586452C0	t	A725CDDA-5BCD-44EE-9762-B29F6777954A.png	f
92	pbkdf2_sha256$150000$ytwGkhydfMyN$WYl+L4ZMNAtsAb41Vl+QKitAe7rmCzby00F04HvoH4k=	2020-03-09 14:37:01.658325+00	f	1ec35c66-f0fd-44c4-8ff7-b8891120de9a				f	t	2020-03-09 14:37:01.3311+00	+16138510279	Sarah	1980-03-09	🦎		0101000020E6100000FB2E04F762B646402E71FCD766EB52C0	t	EC23F9A7-C0C6-458C-8C6C-F981EA3118CB.png	f
118	pbkdf2_sha256$150000$oTQYpCKeiMWU$PGwYX5r7A0ffk+iFN7hEiJYFdl287x7lMbdBR4NsSKU=	2020-03-11 04:49:19.901725+00	f	37b9fb2f-c1cb-4fe5-845d-0ba6634c5164				f	t	2020-03-11 04:49:19.738803+00	+16476182781		\N			0101000020E610000056B3C660BBB646409FF5E2CECAEB52C0	f		f
122	pbkdf2_sha256$150000$aEfVeKm4urK8$0BJ7drtZiKG39R2ABupfb4/mVivysJWjzCD9PH1BYgg=	2020-03-16 17:11:06.132174+00	f	9594f207-98e2-4ff5-979b-2fd49a3745a5				f	t	2020-03-16 17:11:05.802654+00	+15878892903	Josué	2003-01-03	😁		0101000020E61000005605AA3069974940FDE4D11696875CC0	f	6A1ABD83-1E32-41F7-B26C-BE4DA8631CE2.png	f
13	pbkdf2_sha256$150000$LSZFLnq2xcFW$re6gJ4xJvb9VnW+5Yc2CG6fDRlyuj9MJMjDyOYBup5I=	2020-02-26 05:53:18.33912+00	f	33e42011-a30d-4fb3-b4ed-ad2f5f93d837				f	t	2020-02-26 05:53:18.048755+00	+13233643084	KKK	1992-04-25	Ffffffffffffffffffffff		0101000020E6100000C788C068C1AA424076EDA04C82815EC0	f	C64853D5-B8C8-402E-A105-04E01358662F.png	f
39	pbkdf2_sha256$150000$QM0Jpow5CCOr$8a7S3MHbG8fxAbMxG3dd80iCN4X6rmBWehycp9SKWu8=	2020-03-03 14:01:47.122673+00	f	519317a1-48c1-419d-b8cd-e5bbb9772694				f	t	2020-03-03 14:01:46.880927+00	+15817775156	Ghislaine	1996-10-10	Cc		0101000020E6100000CEEDF40679634740C24ED812C6D351C0	f	2FAEBD3D-E5C9-4376-BE17-AD1AD088F379.png	f
71	pbkdf2_sha256$150000$hgLpdnaqWHiH$ONMQzFxuHxUZTVDY902n/F3iwq6iNdp6kuRgGVIOFZA=	2020-03-06 01:40:24.508896+00	f	7fccb2c1-914a-4ac2-af88-eeac99a0e259				f	t	2020-03-06 01:40:23.932682+00	+16136063487	Balzak	1994-08-07	The realest alive		0101000020E610000019A56E877DB44640E1F78F8BBBF352C0	f	DBB5A697-56EB-48BA-AAA3-F31F2525B236.png	f
55	pbkdf2_sha256$150000$uKAOPOp1CCPR$WtEkP7kGzoYVBFiYlq9XNoWj3dPLGmCh0VL4DggmLpw=	2020-03-04 15:04:22.972867+00	f	2a9ea949-5bba-4814-b7a7-213ea9f93626				f	t	2020-03-04 15:04:22.779026+00	+18196093798	Joannie	1990-02-22	French teacher, mom,  meme lover		0101000020E6100000604F0CFDA22A47409859201BAA2552C0	f	FE5F02DF-6A6A-403B-911D-1F23ACF30A31.png	f
58	pbkdf2_sha256$150000$ndteuCFdTxer$bDgD82ssjAPegDSL1EEtffaX27E7NtG6AypMEyvL+BM=	2020-03-04 19:43:03.423227+00	f	c28610e8-b85d-4483-9cfb-3766cf531f27				f	t	2020-03-04 19:43:03.098503+00	+250788325417	gabb23	1997-03-14	Humberguy😎		0101000020E610000087BE6997C215FFBFA4ADAE967D1F3E40	f	CE990C85-A66F-4075-8C78-822F741641FA.png	f
46	pbkdf2_sha256$150000$ZpWJOGgHGJlo$U5NQHgljMGAeZ9y4CtLu8bAw6N5kZqd294SdgoXxM8U=	2020-03-03 21:19:22.464769+00	f	e7353a2b-ce85-4c40-981a-f7bcab319b5b				f	t	2020-03-03 21:19:22.216639+00	+18186617976	Shaka Sanani	2000-03-05	20 years old soccer player		0101000020E610000057B99BD7B4184140F6A6094B85BA5DC0	f	9E0C2CFF-37C1-4FC4-9EBC-2D412A395166.png	f
67	pbkdf2_sha256$150000$KDFN9YUAsfQC$aYiJjdhlpPRmP5q6BMzV+ocSjUC2o8ip1x4yfovPIqQ=	2020-03-05 14:15:52.907731+00	f	f5310624-5cc8-460c-97c8-142a46e6779f				f	t	2020-03-05 14:15:52.599558+00	+15146477195		\N			0101000020E6100000801C7885DEC646409CFA11430D6452C0	f		f
59	pbkdf2_sha256$150000$vMqjdjvt9nvn$UIU4ppRWbLsUgdeZV0C9kDnb5K+Wez1cUeyAMSBzyaw=	2020-03-04 20:28:50.815733+00	f	c7e942cc-70f6-47e6-8ac5-2d608ba3081d				f	t	2020-03-04 20:28:50.486968+00	+18193292684	Lameis	1999-05-27	Me		0101000020E61000001D40EF59B1B746402554B235A7F152C0	t	21403110-46BF-49F2-900F-0B4C1A7463D2.png	f
81	pbkdf2_sha256$150000$2xUJwAP6kKzB$tcmEmac2lb+NVQ+PLu+aExLOMBqHEXhDRx5qrZTkeIg=	2020-03-09 01:12:17.10774+00	f	fa6899ab-612d-4b9f-b41e-f7846884b8f7				f	t	2020-03-07 01:23:16.250572+00	+16136681855	Cory	1998-02-21	Just a programmer		0101000020E610000042CE19DDDEA546406B3B78BE22EF52C0	f	5DE94516-6CF8-4811-A232-D648ACDA37B9.png	f
62	pbkdf2_sha256$150000$Q1aQMYoV0hlj$pPcveV/P/cOsrhZeSN05b99Ar0Fnar7U9jFEp60KwuM=	2020-03-05 01:19:16.541686+00	f	016aa9da-5f09-401f-8cee-37deb8a5a33f				f	t	2020-03-05 01:19:16.354491+00	+16478095789	test	2020-03-04	Dhjfj		0101000020E6100000473585E892AC4640D004129B5FF052C0	f	050EE6A6-5A79-4610-82CB-D59CC3B13D31.png	f
68	pbkdf2_sha256$150000$dpwKhmHY7L4W$HXRHhA/0MbP3GJE3a1OXhmm+LiyfgczDJ3kx9xVjfcI=	2020-03-05 15:22:35.470868+00	f	8d8fb3c1-12fd-46fa-b426-579b193bdd4d				f	t	2020-03-05 15:22:34.814946+00	+916284676210	Dhillon	2002-12-17	Loading...\nTyping...		0101000020E610000000000000000000000000000000000000	f	90F463DF-5B4C-499A-A304-5EA71F7487E4.png	f
44	pbkdf2_sha256$150000$kKu764s5hTds$9Rp8yjA58NKBL7zqJbRcguCti1oFQgdjhApA7UXQGSg=	2020-03-03 18:12:19.229896+00	f	1147bdf4-a927-453d-81e7-ee98e958038d				f	t	2020-03-03 18:12:18.992761+00	+18195925122	Nathalie	1971-02-19	Fiancial adivisor		0101000020E61000000AB7C9D6C9B9464091F50057D1ED52C0	f	A589E7C5-C260-4CDD-A9A0-07175397B2CD.png	f
83	pbkdf2_sha256$150000$7vBZOWcEqjyU$uxH82TrZY5qnR8ojF3bEhhFPScm0bkFjinE6DbU2UPY=	2020-03-07 07:59:14.27369+00	f	020dffc0-2162-4d75-ac34-a4d337c3d765				f	t	2020-03-07 07:59:13.964687+00	+13439975716	sahibjit	1999-05-30	Rabb mehrr kre		0101000020E610000000000000000000000000000000000000	f	14F1B5D4-022F-46DF-877D-1E7FC94266BB.png	f
32	pbkdf2_sha256$150000$wE7ZxTuMUzvs$efiz2rtT4ZNO0goCSFt1tfnPS2t4siEt/nPy/4utQbM=	2020-03-03 02:59:23.541168+00	f	5e0bd748-7994-4d51-a399-7728a03dd3e0				f	t	2020-03-03 02:59:23.353049+00	+15875007235	Darcy Muhoza	1997-04-24	God first, Family next, music ease my stress. Yes		0101000020E6100000C68C40199488494005A77A0670865CC0	f	0BCFBE90-421B-4997-A22C-6818CB811E45.png	f
91	pbkdf2_sha256$150000$K6uYjZ9JAcXj$9meGpdp6v80OGCpqHvhwoML91xsa9NT5tHwKLXYjmfU=	2020-03-11 03:56:28.760047+00	t	ccleg			ccleg2020@outlook.com	t	t	2020-03-09 03:25:49.193372+00	+17054987562	clef	1998-02-21	Just a tester		0101000020E610000000000000000000000000000000000000	f	33BE116A-FDD9-4FE6-9C58-7D084015A1E7.png	f
130	pbkdf2_sha256$150000$Ow6CJqixdLLA$mJUjFzO+KD8z+IlTDYaigdiJG3uK2Vv7T0wXDlg+0ec=	2020-03-23 09:20:13.732721+00	f	0f65e632-aa76-4cef-82c7-cb2707d9d42b				f	t	2020-03-23 09:20:13.55133+00	+250788407340	mukagasana	2020-03-23	Uw		0101000020E610000000000000000000000000000000000000	f	0BCDE0B4-0717-4C9F-9CF9-ECC4BCB9B991.png	f
87	pbkdf2_sha256$150000$ISgcH45htQ81$NDBZNdw1nlOIi1TTuDAg76LaVPjE9kYRkx+cDJL8jsI=	2020-03-08 03:08:42.646091+00	f	e602ac3c-790c-4095-9079-17af0b8d6fa6				f	t	2020-03-08 03:08:42.364898+00	+16136004601	Pankit	1999-12-02	Yo		0101000020E610000069ED3622DAAC46403B13942D49FB52C0	f	B1295A7A-76E2-452B-9114-9ADBFC3D2837.png	f
74	pbkdf2_sha256$150000$Z2lBDwXRMoJq$x6NhuqXhLRRh5nzsW1f1ZVgGTf56WJ1bBWItSywtMcQ=	2020-03-06 15:57:10.61446+00	f	3daabc51-a073-4c5d-aae7-65ff0a29282d				f	t	2020-03-06 15:57:10.40991+00	+16134156079	Emmanuel	1999-04-19	MUSIC LOVER		0101000020E610000071FEF591BFB84640255485BD42F252C0	t	438CAC67-43B9-4D86-B42D-2E96FECC0A7C.png	f
23	pbkdf2_sha256$150000$8Z5CWxVSFIvN$f4komc526ZywV+4444XWwcmJebldI7Q8M4MfK9AL9pI=	2020-03-03 00:35:36.380283+00	f	e1ae12b3-2b9e-480c-9ecb-cec04aa18ce3				f	t	2020-03-03 00:35:36.110968+00	+18195348527	sonia	1996-02-12	.		0101000020E6100000857629154CB546405438AE8EB2F052C0	f	B3278B0F-DF1C-424B-B1AF-2C18CFE930BC.png	f
116	pbkdf2_sha256$150000$fErdYMoNY9NT$zJ0cp/rGNICxBLp4LMwCXEFmuBO/6HV4N965apfp6D8=	2020-03-10 12:43:24.933747+00	f	8e74df3e-6735-45c0-84f7-89f8f485c7fd				f	t	2020-03-10 12:43:24.69589+00	+5512991879181	karen	1983-09-02	Karen		0101000020E610000000000000000000000000000000000000	t	165289C5-F101-4D3A-9D98-52FD1C265F54.png	f
65	pbkdf2_sha256$150000$5hzQE80IBhTi$kXBXPGr3xllriBAoE/+j/2JuiKFqg9B8MjXinq86mcE=	2020-03-05 02:57:08.622047+00	f	7c221d42-6706-4286-914d-154a90309f6f				f	t	2020-03-05 02:57:08.293739+00	+15875668360	yohoyo	1985-02-28	Hoe		0101000020E6100000CA4DB09D6B5C4C40C902689DEED75BC0	f	BC4BE4DA-C174-415F-B82F-76CAA6746AD3.png	f
79	pbkdf2_sha256$150000$LhewecYf23P7$mB3KNDiVuf0TFaJRyxKWPa61XiCsQazQ83DErDfV4T4=	2020-03-06 21:54:52.871642+00	f	9d4384cc-67d2-4371-83d6-060774d99b7f				f	t	2020-03-06 21:54:52.266075+00	+16134101091	Landry	1990-05-01	Live		0101000020E61000007FD87EBA02B64640FFF326F2C2F352C0	f	34BB3C35-423B-496A-8517-1918C38FF610.png	f
80	pbkdf2_sha256$150000$tfeJhRdZe3xM$Eps2d5qmuJ48a7pK023siT+cslgfLv2KiW35U+0+pZQ=	2020-03-06 23:33:45.593111+00	f	d10e0963-2727-4a1d-b4a6-a8083503e7ff				f	t	2020-03-06 23:33:45.374911+00	+15819900261	Moise K	1995-07-28	🇨🇦🇷🇼		0101000020E610000000000000000000000000000000000000	f	4FBDBABB-F7F9-4274-9DB4-B329DB339E62.png	f
76	pbkdf2_sha256$150000$v6OJs8QOcVOq$knBPQoumF/TstARWHMHTL1B81IOymi3VeXONg9i08Yc=	2020-03-06 18:24:50.045955+00	f	6a467706-9cb6-4eed-845d-a8823284a66f				f	t	2020-03-06 18:24:49.733371+00	+18193280067		\N			0101000020E61000007FD87EBA02B64640ADEA2ECEA7F652C0	f		f
111	pbkdf2_sha256$150000$pRwEWUBnpBcv$xqNh7iXDx2SVSByuETyXVwE+6MWKTbKxbyuiXREYqJ0=	2020-03-09 21:23:54.454809+00	f	e3130b4a-f21a-4aee-a2f5-874a67b22393				f	t	2020-03-09 21:23:54.162315+00	+18732882447	P	2000-09-27	Hmu		0101000020E610000008443AA609B6464029A6A0A6D5EB52C0	f	276CC177-EC39-4528-BD77-054BE7291AC9.png	f
50	pbkdf2_sha256$150000$MtTGXiH7iIR4$1yVh/il0T97aBPDRc37jNgozc0Gt0fcfZF8NrJ7cnPA=	2020-03-04 00:10:49.344124+00	f	0fbcd658-b99c-48eb-80b9-ecb805f575b0				f	t	2020-03-04 00:10:49.158874+00	+18189646404	wase	2004-02-12	hi		0101000020E61000001DE8106B981A41403F789CE35CA85DC0	f	308C8C17-E92F-417E-B720-8B2B2D91D230.png	f
128	pbkdf2_sha256$150000$mK3CDctDNyCs$H/WZJ+H33oTQqfwCPbyzPRmdmu0HyAfbSM9PT7GPr0Q=	2020-03-22 04:03:28.26345+00	f	941e65f2-169f-485b-9577-b370a6c3146f				f	t	2020-03-22 04:03:27.978187+00	+15146556103		\N			0101000020E6100000E682FBEA4DC246403AC5CD003B7352C0	f		f
72	pbkdf2_sha256$150000$u7GiisIqFCQf$aJN94a8wd/exNhQuQ99f25ZBBxMi9T9MKfvih1Ba0PU=	2020-03-06 02:12:02.340652+00	f	3fa1fb48-4bea-4c77-9115-220eec33e0d5				f	t	2020-03-06 02:12:02.04975+00	+16138065723	ID	1987-09-15	Oim		0101000020E610000003162DB24AB7464092E82042BCF252C0	f	66B7C5DB-7590-4B41-832F-F78BFC5426EB.png	f
70	pbkdf2_sha256$150000$FQ9yoBk5kkU0$ecb44uFi0Iciat1E/6M6rW5ELUgsWiM7/fAkM4QQ5eI=	2020-03-05 22:49:27.985118+00	f	30d656e4-2c74-48f8-8893-1f2bcda181c1				f	t	2020-03-05 22:49:27.494807+00	+13437778246	test	2020-03-05	Test		0101000020E61000009B87FD048FAC46402A5BFD2D5EF052C0	f	B8F4DE95-3F5E-4536-B84B-152C61F2782D.png	f
66	pbkdf2_sha256$150000$zTsYiWqK70I4$dHRNsakYfQNefdZEjGUGxz9GplM6YWrYqJSAspFBPoQ=	2020-03-05 03:32:10.192054+00	f	13172c34-e091-4c91-a6f5-68bef9342648				f	t	2020-03-05 03:32:09.983454+00	+16136065072	Axel	1996-03-04	Goofy		0101000020E6100000E45B2B6ADBB04640E27269DDCFEC52C0	t	8B7D81BF-BAB3-4544-9528-199B191C0B63.png	f
77	pbkdf2_sha256$150000$2qDiiRys2oX7$2mvT17VU3u4DvxTCwVGsJV3U7cK6x8OmO/S0o9QuFKM=	2020-03-06 19:15:50.67956+00	f	35469210-f6e7-406a-9256-75e9e22162ba				f	t	2020-03-06 19:15:50.342685+00	+18195769383	tea	2000-03-06	Tea skil		0101000020E610000000000000000000000000000000000000	f	F2737BFD-E016-4019-8D41-F56226574322.png	f
113	pbkdf2_sha256$150000$DF9Okj0FBYQG$YHMakFQVOL4+Yb7f+/Nq4zzaUHAK4TSXEMYQiTvHGl8=	2020-03-10 02:39:09.729834+00	f	75735a4d-23e1-42da-ac65-f6e3153272fd				f	t	2020-03-10 02:39:09.548674+00	+18193293201	Sarah	1991-07-30	Awesome human being		0101000020E6100000871FBC2C4CB5464049705F12AFF052C0	f	0F8D3E2B-0BE2-4625-B8A2-030857D01C82.png	f
106	pbkdf2_sha256$150000$EBCUNKA1K34l$VPfSgogl//vGoNfqRBTQ4VJ1BbIdEopJFiEPswnPwKY=	2020-03-09 18:49:25.608272+00	f	c79294fd-d201-4334-8113-010406f388f8				f	t	2020-03-09 18:49:25.13865+00	+18733540221	Betty	1998-10-27	Riding horses		0101000020E610000030DBC82DC6AC4640736CE6CF63F052C0	t	D2D3424C-7427-4749-8F3C-B2F991E62890.png	f
114	pbkdf2_sha256$150000$ilwBWzIkH9Ri$E2ujuyfR+fOkYeEcQs4c8IEqZnjVh5j5K2WorQ4J5bM=	2020-03-10 04:19:28.316502+00	f	cb56f8e9-82e3-4c84-851a-89dce5bea06a				f	t	2020-03-10 04:19:28.075229+00	+12074098983	Christmas	1998-03-09	Test		0101000020E6100000E0C43E9E69E34240F567AB374F995EC0	f	F465D85B-E436-46AE-86B0-2D78202739E8.png	f
17	pbkdf2_sha256$150000$vEQ55fMrIsrb$nRjB5TZrYjElVBRN0ij8YR8TnXFb2FABT2x3xhJNQpk=	2020-03-02 23:39:18.574983+00	f	d1c50e7a-df38-4ee5-9424-f9808aa9e832				f	t	2020-03-02 23:39:18.21248+00	+18197755334	Gurjeet Singh	1997-08-09	Hello !	Ottawa	0101000020E61000001CA1FF5DA5B04640C1FF890E09F052C0	t	9B5CD956-3239-4133-9983-586FDB4C6D00.png	f
98	pbkdf2_sha256$150000$yftRgUSJL8hq$d2vHEhBs984mtD5y179HBmUTBZ58PulnhQv96LXzenc=	2020-03-09 16:02:12.515806+00	f	3c364c29-a9b2-4f9f-98b6-1130f86bb23f				f	t	2020-03-09 16:02:12.285181+00	+18195769432	Sarah	2000-04-22	Im a sleepy girl		0101000020E610000081E46A9195AC4640AB8B3D2279F052C0	t	0C6B35F3-3368-4A44-ABE2-C28909ACCF32.png	f
56	pbkdf2_sha256$150000$Jfq2NVQmAnvK$AIYXPBxkIu6vow9fdnoiVfjx4wqXAPITKK7GoLgQ4fo=	2020-03-04 15:06:39.432852+00	f	c4ddb640-1f55-4ea8-aab2-d84eee4c02c9				f	t	2020-03-04 15:06:39.14267+00	+18199681884	Carlos	2001-04-19	Soccer player\n(Cinque dai cinque)		0101000020E6100000256819F499B64640FF1229A06FF352C0	t	3840E6DA-0F63-43D1-919E-7FCFBF867786.png	f
119	pbkdf2_sha256$150000$WgtLISM3I8Mg$BSS9v557zhXPZsp/yUjNaqUwL/xygl+F1EOhgPHKdQE=	2020-03-11 09:19:41.25798+00	f	a736b495-6f86-4441-b5b1-f88996cfe0dd				f	t	2020-03-11 09:19:40.976692+00	+16132614859	Tracy	1999-07-16	✊🏾✊🏾		0101000020E610000000000000000000000000000000000000	t	36FD238B-E669-41A7-B2C6-7A6D364C7422.png	f
105	pbkdf2_sha256$150000$TYioKM0M2XSm$8NmrBRHzgy2zyxpLXE9Odfp2V8+ArIp2vnnu5q+4pxs=	2020-03-09 18:38:22.41244+00	f	8d44807a-7132-4eed-8652-83884edb0b43				f	t	2020-03-09 18:38:22.116156+00	+13439977229	Maryam	2000-04-30	Hang out		0101000020E61000008A47A3DB39AE4640A4713957BCF252C0	t	81A56333-0B99-478A-9A15-18A783E2565F.png	f
123	pbkdf2_sha256$150000$AHCCt74WUwmk$vdTBpoASpzAR/w8ARRhyQHIsZ6oHxGj9kk2FOhRnCxk=	2020-03-18 02:08:05.428281+00	f	685d1f3c-34ab-4484-9a24-2e39e615246c				f	t	2020-03-18 02:08:05.145177+00	+18193287398	Lucas Bianchi	1983-03-02	M		0101000020E6100000041D7EE488B646406C12666CB8F052C0	f	9120DA2B-B739-4E8B-8905-A2A38CC09E19.png	f
15	pbkdf2_sha256$150000$dS2kuG26TlEp$mhxocyDpZFaunwoas1ZPrEDwtn0i+l9oTAH48orbGR0=	2020-03-02 23:26:10.132343+00	f	15240413-85f7-4e7b-9c2c-f1c927633dd6				f	t	2020-03-02 23:26:09.774489+00	+16134132747	Khushpreet singh	1995-05-14	Web Designer		0101000020E6100000C02F3364C8A2464021379B89DBED52C0	f	D1AD26B5-A105-4E71-BAA4-61287CBC0F56.png	f
96	pbkdf2_sha256$150000$XgT0LVbn0mLa$d9Jm/LirpTTpNXurUFWU/pHbj4v+IUmF++SvBunMWGY=	2020-03-09 15:47:23.418474+00	f	1249da7e-efb5-4cac-aeec-40c8f83a332e				f	t	2020-03-09 15:47:23.17969+00	+16133163043	Jonathan	2000-01-24	Interested in doing business? Let’s chat! I am a marketing major and an entrepreneur.		0101000020E610000087B2DADBB8AC4640235EEAE76AF052C0	f	BF5AC940-D145-437B-82D4-2D83F68ED415.png	f
61	pbkdf2_sha256$150000$uudFLa7gYP4V$vOEgDwGu8Kf071r5xaC6DNz3PmTuLzG+0OoDxzc3X8k=	2020-03-05 01:11:30.447621+00	f	e776cab1-45b5-4348-bb03-e65e294050d4				f	t	2020-03-05 01:11:30.18657+00	+16042201789	vanessa	1989-06-15	Bonjour		0101000020E6100000B747EEF78AD745407BD56BD305DB53C0	f	DB1C0093-282E-46EC-9585-3B8149AAC013.png	f
42	pbkdf2_sha256$150000$GTa18tBYzV20$XaLJSaNJx29dGECl1IQj2+vnU3BJ6GVwqfKhmtdlcPo=	2020-03-03 16:56:25.043732+00	f	50230dec-00c5-4413-8ed6-6c429d2e1ca0				f	t	2020-03-03 16:56:24.779198+00	+15875990576	Abdallah	1992-10-13	Je suis un homme respectueux		0101000020E6100000081CC5F5D9B7464013BD81605BF452C0	f	24AF7975-2698-47BF-AFC2-B4B3ACAF1BCC.png	f
100	pbkdf2_sha256$150000$5AMBbzBAUmCL$d8nZTS0c/AFulltR4BveBpqkqF1nrm0ayCQgqtj8cdc=	2020-03-09 16:38:53.492866+00	f	2f7a68ca-ff9b-4d0b-b5a7-70f777162b6d				f	t	2020-03-09 16:38:53.22829+00	+17058758334	Aislinn	2000-11-18	Law clerk - Algonquin		0101000020E610000001EC8F2C04AD46405BD7199B70F052C0	f	D24EBE9C-B20D-499C-9F30-9EBE16A2F1F8.png	f
101	pbkdf2_sha256$150000$3a8tcxXIVI7R$tQpHKs8EArHkENWLjOhLjG37roscQYNKHJ4vcr0hEW4=	2020-03-09 16:39:34.452928+00	f	d7bcb440-1ca2-4f59-8565-db4b91252349				f	t	2020-03-09 16:39:34.168664+00	+16477812324	Reed	2000-02-25	:)		0101000020E610000043F653C604AD46400C010C236EF052C0	f	F64018CA-7F1B-4596-8678-9D348CD705BD.png	f
94	pbkdf2_sha256$150000$OyHn0xffjga2$KQw+qvRVMG5tu/LjGUF9FmQPTJfu87aDQufhGgvHJA8=	2020-03-09 15:12:50.665506+00	f	9c68f38e-6bea-404f-9049-33465be60e50				f	t	2020-03-09 15:12:50.349178+00	+16133638608	Brayden Dupuis	2001-06-28	Algonquin		0101000020E6100000C9FD5E4A6FAA464051FD1E16DEF052C0	f	1F592446-392F-44B8-A848-2FE14AF7833B.png	f
129	pbkdf2_sha256$150000$V8Z6zOy108an$kMvrpQ0aRepL1uTZy28V5TQp9lU4MBV+O/Ww60EYV2Y=	2020-03-23 03:37:34.738109+00	f	80cbe6f7-115b-43db-8f3b-4ebcde099ed7				f	t	2020-03-23 03:37:34.545335+00	+16133014514	Vinay	1996-05-19	Let’s skip it.!		0101000020E6100000DD9FD90FDDAA4640B906450DF4F052C0	f	D7A0E48C-1E9D-480A-8294-FBAE2C6D060F.png	f
31	pbkdf2_sha256$150000$G2ohmDPqZ2MN$cB61NttRSXTfk8KTOETuGflE3bc0KZgbGKrjipU8oGY=	2020-03-03 02:54:59.374745+00	f	7601a2c0-ce73-40bc-9f94-fbf9c712850d				f	t	2020-03-03 02:54:59.164388+00	+16134478523	Patrick Saul	1983-10-07	I’m the Man with surprises		0101000020E61000004D8FEAEEABAF4640AEB4926AF5EF52C0	t	3CEA9E49-4625-4EE4-8F2E-8F0385CB3B62.png	f
85	pbkdf2_sha256$150000$RA5wPOlflT6Z$Dlqk+JQBFXj/ywEc8J1CUa+rC4h+KUgrWJ5pgrkc+nI=	2020-03-07 16:33:15.274028+00	f	7a6fcf6e-d66c-4402-986d-cb2ea50aaa03				f	t	2020-03-07 16:33:14.96069+00	+919586807698	testuser	2020-01-01	StudentBio		0101000020E6100000DD0A613596E4424076E272BC029A5EC0	f	28F87C29-A4C5-42BB-891E-744EF09C3C1E.png	f
35	pbkdf2_sha256$150000$JIEOlcp3dXPL$VE7VcYRFP5HUjV1NFiKxo6Alyn+i4HS9wsYZHQqunKA=	2020-03-03 12:00:19.576242+00	f	fb2404a2-c3f5-4833-b8d8-38ecfea41d4b				f	t	2020-03-03 12:00:19.305831+00	+16134155403	Pati	1960-01-01	Tx		0101000020E6100000ABEBDE78FBAE46403EE015DC21F252C0	f	AF20ADCC-DB80-416D-8171-8E69F4AF71BC.png	f
84	pbkdf2_sha256$150000$FvHbnnwc5fkT$jJFTJynfAswgNuylQUThqPBZBNjqeDWlKqOHICCDicU=	2020-03-07 16:26:28.598054+00	f	0905a7a7-3590-4956-8857-cbd2fb0b743f				f	t	2020-03-07 16:26:28.298609+00	+17692189192	AJ	1992-01-01	Easy going		0101000020E610000000000000000000000000000000000000	f	B54AE33C-E8DC-4E59-8365-F2B2D739AA82.png	f
95	pbkdf2_sha256$150000$Aqt9hsgivNYJ$jC/6/n0DvcMY3OB11ZgpNVItwwpFXUoRb84oW1rCq4I=	2020-03-09 15:20:31.268996+00	f	a9924486-d6f8-46e5-9e0d-f761d3f667de				f	t	2020-03-09 15:20:30.97658+00	+18193299439	Ali	2001-08-27	Hi		0101000020E61000005406F58092B946403AFA3ABBF4E552C0	t	FE57F557-8A76-43CA-956F-CC811DF1FBE0.png	f
45	pbkdf2_sha256$150000$SBYQdc364d10$rdsscn56JoAEQM+D5lNgcc/r+D1u/KrbOMy9yfC/f3U=	2020-03-03 18:23:16.239187+00	f	aaafa298-0a21-43b3-ac70-43cf2cac6b81				f	t	2020-03-03 18:23:15.856075+00	+15874364094	Elsa	2000-06-07	Sup		0101000020E6100000341972F22CB646406A64902DD0EB52C0	t	640095EE-8C65-4E4A-A8C1-873CA656A792.png	f
102	pbkdf2_sha256$150000$gNDHAaY5Si63$/uVOngSJW29QwMcDlwl7N1U0mQbfL1eZ/iP5C8XQl9U=	2020-03-09 17:49:21.859474+00	f	16aaac2f-a54a-4663-a39a-008e11cb614f				f	t	2020-03-09 17:49:21.565442+00	+16137694877		\N			0101000020E61000009E217F8791AC4640425E736260F052C0	f		f
18	pbkdf2_sha256$150000$zLT3Bheo5fZW$6QvLGpghhCt1co6DfhwZOqz7QElFxC3rwSpK16qscto=	2020-03-02 23:40:58.798955+00	f	be96da58-a25d-4d85-a4b0-435d21ff0633				f	t	2020-03-02 23:40:58.519281+00	+14384075384	Nobel Ruremesha	1987-10-12	Nobel R.		0101000020E6100000E7837CBC396F474080A1022378CF51C0	t	169B4385-C51B-4F85-A12A-2488E80B1455.png	f
133	pbkdf2_sha256$150000$dQthCc8hzUjd$6bnIcGdjefG4xvH+az+MsPO+9kpqgeEqCF+G93NFeAU=	2020-03-24 13:51:29.415824+00	f	a426dd95-aaec-440b-874c-1f6c98d7612a				f	t	2020-03-24 13:51:29.230312+00	+918319296414	ajay	2005-04-21	Indore		0101000020E610000043EF75CE26F93640EF9FEA671C2B5340	t	BE1B2975-2DA0-4501-95D7-77F43E9B8546.png	f
109	pbkdf2_sha256$150000$QEi4hcmsx7fI$h7apRfqJlt0SlExGt/gXlGOMi6ekhxoUyw4PdiuhBzg=	2020-03-09 19:30:44.897796+00	f	ba01eff2-9869-4608-8ae0-2abcbd88a56f				f	t	2020-03-09 19:30:44.495229+00	+13067163171	Anna	2000-01-04	Hey, who wants to hang out?		0101000020E6100000C9E4FDBDC2AC4640F88F485865F052C0	t	4E2AAF82-B1CB-4192-B6D8-A90D4BF29488.png	f
40	pbkdf2_sha256$150000$gtW6CDEwlVdP$UuoOnqTTLojpZIMDgMCmgPgIOAzslMm+EaeX88MHZFQ=	2020-03-03 14:02:44.651537+00	f	17bf08d2-a424-4783-a2d3-9cc4ebe5cf4d				f	t	2020-03-03 14:02:44.384019+00	+18193299579	Ronaldo	1995-03-27	Student at Algonquin College	Ottawa	0101000020E610000040DE220447A34640AB7EA97676ED52C0	t	A06176E6-C67E-4D81-ADDB-592BE8A1930B.png	f
137	pbkdf2_sha256$150000$g35JdvrbJsQ5$7hqMe6xdixJywiZKrhFs4asmzrVVPz8pbHAKPoeAAvo=	2020-03-26 04:50:17.380671+00	f	63c9e5c2-77ff-42d0-bb63-cdc66a89bd40				f	t	2020-03-26 04:50:17.238609+00	+919998730557	Alpesh Chauhan	1987-07-07	Good		0101000020E61000007EAFC72A21FD364040369C5A9F275240	t	2BA960BE-2128-4B25-BD68-F45C6E872ABD.png	f
29	pbkdf2_sha256$150000$N18FDYlaVo6o$uVKmwk3WtG/2j5zBV5HtE+pHDucbhX5+cX6W2eF/UV0=	2020-03-03 01:59:14.838853+00	f	06fe326d-437f-4ade-88d6-dd1d1d03de36				f	t	2020-03-03 01:59:14.550405+00	+14386227568	Bingwa	1995-10-27	@_bingwa_		0101000020E61000006F972A9C80CE464090F58610326352C0	f	0D03C666-1693-48A1-B261-7DC75E6EB918.png	f
124	pbkdf2_sha256$150000$aMlmSZDmVRew$zR8gHMUvLOW/LlgsPZ4ImUme5nqjdmnlgxIP/LwhpPo=	2020-03-18 10:32:26.423049+00	f	a312fca3-4a1a-404b-bce0-2d689ea25957				f	t	2020-03-18 10:32:26.126707+00	+16043490860	Alinane	1988-03-18	I’m an e-commerce business owner that teaches others about business as a way of spreading equal opportunity & empowerment.		0101000020E6100000A6DBC79E33A148402135F30612C75EC0	t	1479F179-43C8-48D6-B0E2-F31E61BB4EB5.png	f
117	pbkdf2_sha256$150000$xYR236IjwXr2$0AwOstTp9tNrdQbk0a1if/Z9PnJjNZRWnpjDUm1KFPc=	2020-03-10 13:55:01.440875+00	f	0d638bd3-f1a7-4fa2-b25b-e31ca5333207				f	t	2020-03-10 13:55:01.192986+00	+18192306399	Lynn	1962-03-10	Love gardening, reading		0101000020E610000043175C02B5B74640661344DEABF152C0	f	F70E994A-CBFF-402E-B189-42F20CBF5817.png	f
120	pbkdf2_sha256$150000$RAOY576kgtZJ$Ecdj74dFHoeAKJdB20wjBVBn+c1qVVqPhMjv8ZY7kuE=	2020-03-20 09:55:44.850404+00	f	cc25c80f-c657-4e88-b53d-dc4b8e867a8b				f	t	2020-03-12 06:04:11.091597+00	+918874464014	Devonshire	1995-03-12	IOS		0101000020E61000007A1BA071A3D53A40BD14AE5DAE405440	t	4F9FE7AF-0C7D-4B0C-B4CF-DF4B06AB166C.png	f
16	pbkdf2_sha256$150000$XhsMkT2bljZI$XSWbUdN8ii5P3UqHk18Tx1HIR0eMGWjbThoDyV8ER40=	2020-03-03 02:22:12.891118+00	f	d326212f-f92c-482e-a456-dc1e2d10445e				f	t	2020-03-02 23:33:17.324253+00	+18192716210	Herve	1997-08-23	Relax		0101000020E6100000F5550708BFA946407E729B9DFCF152C0	t	6282A219-8779-4B29-B898-C8716FC776CC.png	f
135	pbkdf2_sha256$150000$Gl1mC23tTcgb$61F8llhvOHrdwJawVrDiv0SrEYsSoIEi5q9ErESskhM=	2020-03-25 04:49:02.960173+00	f	862753c6-e047-4687-af0f-62bbf3dd77aa				f	t	2020-03-25 04:49:02.808594+00	+918200182941	Tushar Amkar	1993-03-02	I am a iOS developer		0101000020E6100000000000000000474000000000004052C0	f	E934E25F-F68A-4C9E-A807-F75375EE1505.png	f
57	pbkdf2_sha256$150000$ySw7IxdUQOlZ$9Jux0HNVqRWsXy/TgHJR5g8o/fZZBhdQyLGvYRMv2EQ=	2020-03-04 17:42:29.023484+00	f	c9d4ef18-413a-4751-9182-66f03eb6ca0c				f	t	2020-03-04 17:42:28.591736+00	+16478895232	Alexis	1982-06-06	“Le meilleure façon de prédire l’avenir est de créer” Peter Drucker		0101000020E61000007670E72199E54540525392C922D453C0	f	263FAC43-1C91-459A-B01A-42C89910A16F.png	f
38	pbkdf2_sha256$150000$T7go1gVh386b$yFE85VI9dwTKGQTIMaRKFw6mUdqSpXfarPWhwZ/AY0k=	2020-03-03 19:03:34.320356+00	f	8c3add63-9be4-40f3-9927-30e066ef65f3				f	t	2020-03-03 13:29:17.327312+00	+16135135313	Manuel	1996-11-10	Hiiiii!		0101000020E6100000DD4BB8B217AF4640F85AA55A16E952C0	t	E2D96652-3687-4DA1-B188-E999A179249F.png	f
8	pbkdf2_sha256$150000$D15BNVt4MpVU$UTz/Oplnpc+Fn3mHwkH3mFXl37qKz5EIQ4TT0weh5Fg=	2020-02-11 04:08:56.46598+00	f	4d2d3db3-d0ac-45fe-8e7a-2802cf2f2489				f	t	2020-02-07 19:45:25.363981+00	+14185690481	leo	1996-07-29	Fake it until you make it		0101000020E6100000AB98904FC16E4740980886CEC2CD51C0	t	8.png	f
112	pbkdf2_sha256$150000$hvvz3PPEBMMd$eNvvYwQGtSCjgvqmuja+KogsVqpBZ69jTClYS0f5pN4=	2020-03-09 23:22:28.088662+00	f	619efaf7-f989-495e-90be-bfbc80359d21				f	t	2020-03-09 23:22:27.836937+00	+19059770111	carole	2000-09-28	🇧🇮🇨🇦		0101000020E610000037178C9269AC46405F132A128AEA52C0	t	C168AE8B-F7A2-4E1A-8993-CE8FE9802E4C.png	f
93	pbkdf2_sha256$150000$Ak7kAsFlho6d$tsdotFj8n6ULvRrvVo54uMR8jHVhSE9BNe6xpvvoIxg=	2020-03-09 14:52:45.85998+00	f	4c89994c-52ab-481d-ade9-5772488e36ac				f	t	2020-03-09 14:52:45.574827+00	+16136006752	Moe	2000-08-01	Wat it dooo babyyy		0101000020E61000003A17265C9AAE4640631306FBC0EE52C0	t	647D0A76-9FE7-4816-B16D-C676661A6121.png	f
19	pbkdf2_sha256$150000$uPktOswtBzMG$QPRWumzl+NI8/3pah+7grp0CdaN/Akru3Zwizp/FtKM=	2020-03-02 23:45:40.283864+00	f	6c8c62af-aaa2-4ba4-a716-24a73ab369f2				f	t	2020-03-02 23:45:39.853948+00	+15145766022	ibbaaa	1996-10-02	Let’s talk		0101000020E61000007AFCEB86B8B6464030B62CC3C7EB52C0	t	6E0A5F1D-3676-4FC2-B911-FC6935C3DDF7.png	f
52	pbkdf2_sha256$150000$hVBgt5nN8KEX$nxjuPbObQ6eaypTgbustYl0M1HFVcmivyjvydivUNsk=	2020-03-31 04:01:53.507108+00	f	a9b83dcf-eb75-454b-88e1-510d75dab51b				f	t	2020-03-04 00:39:54.814223+00	+15819965243	chloe rutabayiro	1998-04-19	♈️		0101000020E6100000DA5FA2542E714740D16D2AB12DD351C0	f	05127850-1100-4290-835E-8AD897044BC3.png	f
73	pbkdf2_sha256$150000$Mo8ZLis2fGJJ$KBgCgA3HCYdI4jtmAeXxkQYGIOqXsrFwjskuQ5ANAjY=	2020-03-06 03:56:03.877509+00	f	809072a1-7a08-4068-9ebb-44b9f2a27350				f	t	2020-03-06 03:56:03.570069+00	+16138902112	Peace	1993-07-29	Fun		0101000020E61000007B68D9C59DBD4640EF648849C1EB52C0	t	CC2100EB-E17E-4A98-8245-C63AD91BB852.png	f
107	pbkdf2_sha256$150000$CquhVdOdH9Kj$1AC6LQsIko0uXHRZIR3Ijv3L5hy/0c4RwiYHRcR8SHE=	2020-03-09 19:06:17.512166+00	f	2803cc6e-5849-435e-807a-7afc037ec579				f	t	2020-03-09 19:06:17.186241+00	+16138789854	Omar	1999-03-04	Hello it’s Omar		0101000020E6100000446F76E828B646406CA3E82212EA52C0	t	8A5E1686-92CA-4867-96EB-05BC27FC46BC.png	f
125	pbkdf2_sha256$150000$ijQPqExf1SB6$9+2+P3DUTO1p2y002oO65TJe+7gzb+u8mFDCHSNiRG4=	2020-03-19 02:53:12.000218+00	f	c77e4671-3fb6-4be5-be31-fba3ce1e12f4				f	t	2020-03-19 02:53:11.681614+00	+18193517013	jeremie	2020-03-18	Mtb		0101000020E610000000000000000000000000000000000000	f	50D9B76F-87AB-474F-A840-C714979E0941.png	f
97	pbkdf2_sha256$150000$ts91KjvLsKnm$CaVaIEw3176t2wRP5swETidSSd+va70lc9k/Gw/ZzgA=	2020-03-09 16:01:38.763533+00	f	2e05e6fc-8d2e-4a7e-b313-e348320a5718				f	t	2020-03-09 16:01:38.475858+00	+18733534423	Heba	2000-06-26	I love food		0101000020E61000001E22FC2F0AAD4640AF0C96DEB1F352C0	t	2360BE6D-CC20-4909-9253-699510B0102B.png	f
134	pbkdf2_sha256$150000$L7E92lFzQTKJ$0GyWEIzveBplteu/iHyF8MjQTPkkILh661R/li05uNo=	2020-03-24 17:08:26.128833+00	f	47138302-b8e7-486e-ba68-a208f45d909b				f	t	2020-03-24 17:08:25.932351+00	+919998027925	Parth Patel	1994-03-28	IOS DEVELOPER		0101000020E610000000000000000000000000000000000000	f	A2B4E775-B7EA-42C1-A807-2D07D74522A0.png	f
131	pbkdf2_sha256$150000$H123mvEWYwXH$iySJtY/5Lw2pxpy7r5rRPESW8By7AbjR29F6OSY8D4Q=	2020-03-24 05:57:30.691131+00	f	18cb8dd4-9749-4203-a91e-5db46d790e2e				f	t	2020-03-24 05:57:30.515734+00	+917355026529	Ramesh	1984-11-20	Male		0101000020E6100000000000000000474000000000004052C0	f	F7A36CE9-C5F0-46A4-B6A7-1B324D03EB96.png	f
138	pbkdf2_sha256$150000$y9815FAPmAsH$+RsAcu6yCLolCIrZC84TZx/7XFtCP5RP9bSAPktGrCc=	2020-03-28 13:38:41.098885+00	f	e914f79c-bee7-47f1-8d15-726adb96d7a1				f	t	2020-03-28 13:38:40.951078+00	+16132226644	Dr Jo-Anne MATHESON	1963-02-07	Dentist St Laurent Dental Centre		0101000020E6100000DBC58E72CCBB4640ED2BF7C965E252C0	f	1DE402E4-1583-4887-A4D4-99D6A61E5508.png	f
78	pbkdf2_sha256$150000$HD9a2weaJNY0$iyLuUEMC1lyOx3PM673Z6k8T5+LzILHwVgrlpLe9lfs=	2020-03-06 19:27:11.591088+00	f	945e45e3-e975-4ca9-857f-a1a70a5cd2c3				f	t	2020-03-06 19:27:11.274082+00	+250788826239	Pla6de	1999-11-08	Hakuna Matata		0101000020E6100000CAA693EC613AFFBF77E5A4212F1B3E40	f	511ECE6C-F674-498D-B3AA-747348E59678.png	f
110	pbkdf2_sha256$150000$bZbU7R4a2t3O$9xh9aZebdfOGF9Ei3wkvaB/pkgfbRHeWIh96bPfTkws=	2020-03-09 19:49:41.400981+00	f	551fc7cb-8167-43a4-98bb-6cb6405a2bd5				f	t	2020-03-09 19:49:41.086873+00	+16136393014	Ethan Boulrice	2000-10-17	I like to play video games		0101000020E6100000AEAF767CD1AC464010E7B62279F052C0	t	57B3F0F7-5C81-4E29-BE8D-BE7FF5A3FFC5.png	f
69	pbkdf2_sha256$150000$cjZc8CxEG73I$f4dOICIHWoEjP2pJVaTe+Z5I7nhGefP88U5O02k9WNc=	2020-03-05 20:57:57.029353+00	f	b78acefa-9e29-4cbe-818f-b3d0a9d83932				f	t	2020-03-05 20:57:56.694822+00	+96598989503	mishari	1996-08-12	Mishari		0101000020E6100000EDA8DD5324B14640A10454BAFFEA52C0	f	FE9D1077-A5DB-419C-A236-156E591C61CE.png	f
136	pbkdf2_sha256$150000$8lgVlh9fMJZU$ihMdqUPpBtxCLzyKXYzXR3koIdjubYeP2aRmgg6i0Ik=	2020-03-25 18:38:22.281672+00	f	869d8856-d71e-4f4a-b1a1-ce1c60ee91f3				f	t	2020-03-25 18:38:22.126538+00	+18186617994	Noëlla	2000-12-25	Noëlla		0101000020E6100000F178E695A3124140FDC04563B6B35DC0	f	BF318240-2BBA-4F17-B48D-5D68E17FDEF7.png	f
115	pbkdf2_sha256$150000$vXCoAMD0Tz1m$ne+wZkCc01niaaY50cv69QFJaWtvIAodJuEpmIR8Edc=	2020-03-10 07:24:03.54004+00	f	1b3f75e0-4db4-4615-a4cd-57ba1b38935a				f	t	2020-03-10 07:24:03.255131+00	+15103840718	Cassilde Ahishakiye	1954-10-12	Burundi		0101000020E6100000C56ECC0F69FA42409883360C447E5EC0	f	3F12A3E8-8DA3-4318-B306-8A51630DBD34.png	f
127	pbkdf2_sha256$150000$Rn8L3Vq9TbUV$+/4MyDB/6jqPvMQqBMlmSZMqOGo6OdX4q4fgdSYSUoE=	2020-03-19 20:20:24.545926+00	f	46839337-a989-4dbe-af23-ec2095bd29fd				f	t	2020-03-19 20:20:24.251732+00	+923044585982	Kim Jo Un	1996-02-12	North Korea President		0101000020E6100000740C3CFC1D743F4096C683C0628C5240	t	777EC7E5-E8F4-4C86-9405-934447AF235C.png	f
140	pbkdf2_sha256$180000$ohtQN6pYuG5k$bkcUpXaCUYX+A+fhvELk0+z/G1yzeylC6oVHruILT2E=	2020-04-13 12:28:06.024137+00	f	73d1295b-c558-4792-93f1-c428b69b449c				f	t	2020-04-10 15:14:17.395311+00	+923326142059		\N			0101000020E6100000AD6D8AC745DD4540180EDF1DF4E153C0	f		f
103	pbkdf2_sha256$150000$UxoCuZV4XJRG$ag8UgDGXh+rI6oZX2578G8QgKgPXJqs/C5t3XuFTXUY=	2020-03-09 17:57:04.362089+00	f	d4733b33-90b4-4c76-9654-72e95cf47289				f	t	2020-03-09 17:57:03.847701+00	+16137008619	Marwan	1980-03-09	Reading book as a club book		0101000020E6100000E7987EAFE6A14640AC27E2FD60F052C0	t	E345D16E-5BB4-488F-B354-815D9F76B0CF.png	t
7	pbkdf2_sha256$150000$d8klhLzfPsby$YqP3hmvPr0hLXzPpnWkSRTcHUhpneq+d5fUX8f8usko=	2020-03-09 01:41:55.531017+00	f	eff6fd1f-7746-4190-bac5-82b120b6fe6d				f	t	2020-02-07 15:52:48.891406+00	+15819912969	David	1974-06-28	King David		0101000020E6100000F31DC65A4BB34640D3C55A15F0F252C0	t	55DE2BD8-1521-4931-A11C-3B24458A7757.png	f
1	pbkdf2_sha256$150000$SBVkAHPq2cMX$QnWbHP3XP3C6/yDYXz3qyrQn28laT/BwCc4shNlvCiw=	2020-03-17 18:36:13.281427+00	t	longx695			longx695@gmail.com	t	t	2019-12-23 17:37:08+00	+14387942375	Bogdan	2019-12-23	test	Test Address	0101000020E6100000000000A03ABB4240000000E09B795EC0	t	1.png	t
26	pbkdf2_sha256$150000$Tj15vETY3LTx$2fJNsmeUqdRh+DwdIk3rJkTfXXsWzQBm3mT8fmzWepI=	2020-03-03 01:27:52.196526+00	f	a6e40ee6-82cf-4e53-a278-8fdeaaae1773				f	t	2020-03-03 01:27:52.008704+00	+15819965242	Rachel	1996-02-20	Rn		0101000020E6100000F5176447B96547403C1270CBD4CE51C0	t	F9516A0D-1CF0-4DC3-8CCF-19D13489D0A2.png	f
145	pbkdf2_sha256$180000$Bpg9rdyT7I0X$loJTy4aKpz+60uU7zN3RsG2FI0jiXvMPyuAqzz+J6B0=	2020-04-27 20:54:15.395007+00	f	18f2660f-646c-427f-b4d9-a40184d0c3d8				f	t	2020-04-27 18:30:06.093408+00	+919911151831	praveen	1997-04-28	Him oob		0101000020E6100000000000000000474000000000004052C0	t	5CC46451-322A-4C25-89AC-80C4C9D25782.png	f
141	pbkdf2_sha256$180000$DXhqLKyA6CRg$E3jyN+Ty9US8eNacThqTtWh7yURkXlfOnNBp5nUpkow=	2020-04-28 10:38:27.077252+00	f	140d97b8-91bf-49f1-a8f2-256e163e9f87				f	t	2020-04-18 19:49:38.928583+00	+919717699480	Anshumaan	2020-04-19	Anshumaan		0101000020E6100000000000000000474000000000004052C0	t	87496C03-3189-4182-81E8-B38EC720978B.png	f
146	pbkdf2_sha256$180000$nUxhIq7AtjqI$1v+l/cvUpTXaGCBvrxYSWJWGYt4137Ya4HIIapwDnGQ=	2020-06-30 18:40:46.496023+00	f	322fd0fb-dec6-4c3b-9e83-529b85638f8d				f	t	2020-06-30 18:40:46.351475+00	+918840636662	dhiraj	1995-12-01	Random		0101000020E6100000000000000000474000000000004052C0	f	048DA399-D5BE-4D94-A8EB-395BCB00E51C.png	f
143	pbkdf2_sha256$180000$NNUzIAsnNNuG$R7zA/MO100YwvAppiKVCj0AUbGKjbDcGU4jilLqYSeg=	2020-07-14 14:36:51.057944+00	f	2594dc25-025f-4d0d-bc7e-37f34fd25062				f	t	2020-04-21 07:32:53.859857+00	+917007956615	Neeraj	1994-01-13	Random data	India	0101000020E6100000000000000000474000000000004052C0	t	827C0D21-CB82-4644-87F1-956C8EAF5226.png	f
132	pbkdf2_sha256$150000$eAMmZqW4kT2Z$3sl32etIjrf5gkgucOt4+fP+rBri7Icr0Yyl3bj6TP8=	2020-07-08 05:46:02.46196+00	f	169f22e4-86f7-4218-a392-ac68db1f141a				f	t	2020-03-24 07:03:55.501963+00	+919911996593	Sunny Singh	1990-03-24	Shfakjjj		0101000020E6100000000000000000474000000000004052C0	t	5E98AB25-7854-4A22-B042-CFBB23C0DC6B.png	f
147	pbkdf2_sha256$180000$xCEHjzwZvb8I$G0Mhy9sF2RozA75s8YNpFLUTHk9UUgt4xsm6S79MutE=	2020-07-02 16:04:22.836299+00	f	1670196d-7469-4ba5-9603-2c1b514f3813				f	t	2020-07-02 16:04:22.683579+00	+918808199686	raha baby	1994-07-02	FhHzj		0101000020E6100000000000000000474000000000004052C0	f	83D78A00-1C4F-447D-AFE2-FD16667BA08A.png	f
142	pbkdf2_sha256$180000$steXagx5Utej$Ebqrd90LtM1yB+4Lg+l5TP+4/vK6LR3ocMCazEWWm1A=	2020-04-18 19:56:25.19994+00	f	4571b00e-488e-4731-a364-f0e891e989e4				f	t	2020-04-18 19:56:25.070813+00	+917906730077	Anshu	2019-04-19	Anshu		0101000020E6100000000000000000474000000000004052C0	f	D39E159E-26E6-441D-BD68-5C54CAF237D5.png	f
144	pbkdf2_sha256$180000$5D42qX7p7el0$pWpXvGIORQrDG8FbIP6BkajhZifoIX0KP37OdBm1Qgg=	2020-07-03 11:40:12.269241+00	f	d380c0b8-82c2-4085-bb1d-9bbe9d20caf5				f	t	2020-04-24 09:31:54.356022+00	+919969673899	no	1994-01-13	Neeraj		0101000020E6100000000000000000474000000000004052C0	t	D3519BFF-B8DE-484F-9A8E-3AE26545DF67.png	f
126	pbkdf2_sha256$150000$ATeWwTanMurZ$NNMKi7nL2sYYRf7OCkCTqXJ9iQyBB8wxsomAZlAQYt4=	2020-05-05 15:48:59.826569+00	f	338a2ffe-c74d-4ccd-ab40-4783e016e104				f	t	2020-03-19 20:09:08.80762+00	+17865067619	Man	1996-02-12	Dev		0101000020E61000002932427297754540103BDAEDB2306040	t	BF24C161-9419-4AE8-A87A-22D33F94A167.png	f
\.


--
-- Data for Name: api_customuser_black_list; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.api_customuser_black_list (id, from_customuser_id, to_customuser_id) FROM stdin;
\.


--
-- Data for Name: api_customuser_groups; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.api_customuser_groups (id, customuser_id, group_id) FROM stdin;
\.


--
-- Data for Name: api_customuser_user_permissions; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.api_customuser_user_permissions (id, customuser_id, permission_id) FROM stdin;
\.


--
-- Data for Name: api_group; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.api_group (id, name, description, photo, access_key, general_access, creater_id) FROM stdin;
1	xbvdzbj	Jbsjdzxmn		6f5b9f3000eb74955b9675d5373c53925d5b56ded29779aa65d5f4506665bcbc	f	132
2	xbvdzbj	Jbsjdzxmn		13f7415f2d750f468da012271ba0665c4eccb9ed3236dbd40e86b577536b5caa	f	132
3	meta group	This is a test group		06f496b86c1b33999cf542740dadec8d777e30f4a4a90a270a792351e156cb59	f	132
4	test group	Testing		425723029acb65246ba93a74a41ad9262be0d769bd563ee9c0befd0a66f75ffb	f	143
5	test group	Testing		53895ea6539ff9ebfb54c54fe77f6ac1cdb817761072f52d573535a97802287e	f	143
6	test group	Testing		5a1b6c57594060b8af333fab1606b13bec7843955daa2f0322281067ffc266da	f	143
7	test group	Testing		a1ec0e5176d09ec6ca9c3c45890a1272d214e30cf3e1d9d0d6d0ca6a3802f88a	f	143
8	test group	Testing		fc38d5cec37a300a1bd7fbf69a26839319b7b1d7a0562b6395d9fba003dd9e5d	f	143
9	test group	Testing		784190e53b49593a511e1f1c33978d1e21017e16becf7c035eee15a844aab6dc	f	143
10	test group	Testing		513df2a697995e8deb39939e418ba2f884f12e25ab221d27998e9b6e5388e78a	f	143
11	test group	Testing		86951ccbbca64f1535c7b19ba04517c8c3794bbcb1b9b6bbb0e44bdfa060833a	f	143
12	test group	Testing		f4d74a1e5abf91210e83e12ad9cf112fd9a55d1932ea6e91d643994d1ffc622f	f	143
13	test group	Testing		3c24c08bee1cdfc8314f990dde9750210b41530664464cc0d4a8a320aa44d599	f	143
14	test group	Testing		400021674876db45fc2c560267623f6ecbe2862b8d8d6b66963ae762faf35c15	f	143
15	2	Asdfqwezcv		e05129caeb1603ca295320579861d953347d588b8ca21e3985371a1c34890ef4	f	143
16	2	456356748fg		ecb5e3a0812582c3ce11119eff4dc7d179c3ad95647a4b8ff582081e70e5e01b	f	143
17	68	Jhkghjk		09be22d7a620368c19d3c3da2979c3ff1e107ddc9504599e353cd14f918df009	f	143
18	test group	Test		9c238af913f2ec40b1b050ba1cb664db2e2be5e244e9eb4a46d513eae5a8af4e	f	143
19	new Group	New group with image		6f08a5a5457728c3da2de2802126b25a4578e1e28f089e1878d1f7413b190ccf	f	143
20	group 1	Description of group		2aa925162ecf95d409cd79205d70db5624379592bfd2a5b6fca45f76db4c9678	f	143
21	group 2	Group test		358adc57e15a7bf673bd9c134e7e65f1a326c00d5a9c8ca69a7205b00577c2ba	f	143
22	qwerty	1233245456		0533074898e24f2c05b2ddb1e8da8a524b36105d4961ab6fbf48e58a50136ba4	f	143
23	qwertasdf	Sfdgsdghshbddwd		3d1c5c2294afda5e851933fc5f3d31517684b37fb2e276529adb7617b435a231	f	143
24	hgfhgfj	Enter Description		f8b66c1cb1d44cdebe3cbe3e6f97991f5d193e2fffd52233c394142f7cb2b18f	t	132
25	advance	Enter Description		97e07bb022ec5df6f8bc9741259fd6fa6deb74c7dd1d48b8fe02d5c845f542c1	t	132
26	grp1234	1235456		99f4a50917d082a94c064e56245316b98b40d38aba53e5dd443bff167898c095	f	143
27	2132342134	34523452345		047fc9d4bc48ce98bf225a233234984ca0a76909632e682f1e39a06f518c5ca8	f	143
28	3534634564567	3245345234		14b0a9df115aa0ebb3d0743ad17761e544d303d36e648340121bc9b6571f1ddd	f	143
29	nkjsdnk	Enter Description		9c48a2d180cafdf51441ee10b31538de696e2c0a2eb1739b53de0b68252b9d12	t	132
30	mnbvcxz	Enter Description		dd407e04f663b255331fd21dda5934aae87bcbcf562d7fb76dfcf4ad61e8def0	t	132
31	group NEw	New group		0b91fd6263a5555fa0001a816c007b5bb9b823d29ad5dc15327a1dc54dec4694	f	143
32	NewGroup Test	Group description		ec3ba21f7cef44984f64c7b3ae8239043ee6252ba52fcf43c212e1129fa06361	f	143
33	lost	Enter Description	0F505A20-D819-4929-8800-E27720DD4207.png	776b3a32e57c17ddf0ae051a542a2344b7d578e283a8b6efb903318e41019f3d	t	132
34	llllll	Enter Description	AC8F418E-D2C6-4B13-9CB1-9CD41CB27E7E.png	aa5274b71181ed830d30c4ee0a2f0c573bc91c52544b15c328b749deb21b8666	t	132
35	test	Adsgdfg		ba91e14f0f7572ed14298272ec17c833b65a449f04149a1d97083ab746c0985d	f	143
36	123test	1234tstgds		aec2fbae671afb8be89d5e6cd8434e37dd8c13005ab8b6d6893c4ba8dce208bf	f	143
37	returrn	Eqtrqergdfb		2609c89e930df0917f5edefac8b3d40ef457d0b9b8a0780e0b8c9f2ff74e69e1	f	143
38	mmm	Asdsdfasdfgasd		f7a9c2be0988d7c0a2f32f0bd7183d32a61813e49cc491e1b0c5934177839d10	f	143
\.


--
-- Data for Name: api_group_members; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.api_group_members (id, group_id, customuser_id) FROM stdin;
1	1	6
2	1	127
3	2	6
4	2	127
5	3	127
6	4	141
7	5	141
8	6	141
9	7	141
10	8	141
11	9	141
12	10	141
13	11	141
14	12	141
15	13	141
16	14	144
17	14	141
18	15	144
19	15	6
20	16	141
21	16	6
22	17	144
23	17	141
24	17	6
25	18	144
26	18	6
27	19	144
28	19	141
29	20	144
30	20	6
31	21	144
32	21	141
33	22	144
34	22	6
35	23	144
36	23	6
37	24	6
38	24	127
39	25	6
40	25	127
41	26	6
42	27	144
43	27	6
44	28	144
45	28	141
46	29	127
47	30	6
48	31	144
49	31	6
50	32	144
51	32	6
52	33	127
53	34	6
54	35	144
55	35	132
56	36	144
57	36	132
58	36	6
59	37	144
60	37	132
61	38	144
62	38	132
63	38	141
\.


--
-- Data for Name: api_likemessage; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.api_likemessage (id, updated, is_like, message_id, user_id) FROM stdin;
26	2020-03-02 23:42:36.693488+00	t	152	16
27	2020-03-02 23:59:45.66161+00	t	155	18
28	2020-03-03 00:13:38.559385+00	t	153	17
29	2020-03-03 02:25:03.685641+00	t	169	7
30	2020-03-03 03:59:17.427126+00	t	175	17
31	2020-03-03 04:46:41.070907+00	t	181	7
32	2020-03-03 04:47:06.899069+00	t	180	27
33	2020-03-03 04:48:02.560061+00	t	184	7
83	2020-03-10 21:09:51.541212+00	t	446	112
34	2020-03-03 05:51:52.51099+00	t	185	32
35	2020-03-03 05:56:06.861367+00	t	193	7
36	2020-03-03 13:45:55.015851+00	t	197	7
37	2020-03-03 15:39:09.468058+00	t	202	7
38	2020-03-03 20:53:50.518183+00	t	211	7
39	2020-03-03 22:02:10.661957+00	t	221	47
40	2020-03-04 03:08:35.086709+00	t	213	41
41	2020-03-04 04:00:32.871368+00	t	228	7
42	2020-03-04 15:14:11.895816+00	t	236	56
43	2020-03-04 20:43:37.694042+00	t	238	59
44	2020-03-05 01:43:38.101312+00	t	242	7
45	2020-03-05 01:52:03.634458+00	t	247	17
46	2020-03-05 01:58:06.253307+00	t	232	23
47	2020-03-05 01:58:08.027961+00	t	231	23
48	2020-03-05 01:58:09.469775+00	t	230	23
23	2020-02-10 01:01:17.743712+00	t	114	7
24	2020-02-10 01:14:16.506459+00	t	113	8
25	2020-02-19 04:24:32.118921+00	t	128	7
49	2020-03-05 02:59:01.782797+00	t	265	7
50	2020-03-05 03:04:44.208343+00	t	271	7
51	2020-03-05 04:39:54.33623+00	t	237	38
52	2020-03-05 04:47:07.363079+00	t	275	17
53	2020-03-05 05:08:46.575172+00	t	270	45
54	2020-03-05 14:42:12.20842+00	t	200	35
55	2020-03-06 04:58:10.483527+00	t	293	7
56	2020-03-06 21:40:24.041844+00	t	258	16
57	2020-03-07 05:06:06.830925+00	t	310	35
58	2020-03-07 08:04:20.215219+00	t	316	83
59	2020-03-07 12:12:22.143082+00	t	288	26
60	2020-03-07 12:12:23.770289+00	t	287	26
61	2020-03-07 21:57:51.884575+00	t	323	45
62	2020-03-07 22:28:53.256632+00	t	333	7
63	2020-03-07 22:40:08.436004+00	t	325	24
64	2020-03-08 01:30:06.475197+00	t	334	45
65	2020-03-08 04:29:43.439618+00	t	337	7
66	2020-03-08 23:10:58.443087+00	t	338	81
67	2020-03-09 00:49:13.508959+00	t	345	7
68	2020-03-09 02:24:42.451703+00	t	368	7
69	2020-03-09 02:27:18.649964+00	t	369	31
70	2020-03-09 03:26:09.385823+00	t	360	81
71	2020-03-09 12:43:44.321664+00	t	344	35
72	2020-03-09 12:43:45.909972+00	t	343	35
73	2020-03-09 18:03:22.425669+00	t	371	31
74	2020-03-09 18:03:25.71264+00	t	372	31
75	2020-03-09 18:03:28.555078+00	t	377	31
76	2020-03-09 18:03:40.148393+00	t	387	31
77	2020-03-09 19:16:22.254157+00	t	398	7
78	2020-03-09 23:05:18.187235+00	t	391	81
79	2020-03-10 00:14:53.454555+00	t	406	7
80	2020-03-10 01:57:36.330767+00	t	414	7
81	2020-03-10 14:46:45.67783+00	t	418	69
82	2020-03-10 20:55:12.677442+00	f	431	7
84	2020-03-10 21:09:54.833784+00	t	445	112
85	2020-03-10 21:09:57.769037+00	t	444	112
86	2020-03-10 21:20:13.767838+00	t	450	19
87	2020-03-10 21:58:50.446922+00	t	392	81
88	2020-03-11 03:42:26.90985+00	t	365	81
90	2020-03-11 04:00:49.464674+00	t	464	7
89	2020-03-11 04:10:35.091886+00	t	462	91
91	2020-03-11 04:58:51.272411+00	t	465	91
92	2020-03-16 04:06:53.936414+00	t	411	27
93	2020-03-27 03:58:41.563875+00	t	217	39
104	2020-07-01 03:25:50.501162+00	f	664	144
105	2020-07-02 15:39:16.505514+00	t	755	143
95	2020-04-22 03:15:08.390774+00	t	500	143
107	2020-07-03 18:35:45.03936+00	t	756	132
108	2020-07-03 18:35:48.873688+00	t	724	132
97	2020-04-27 01:49:44.183808+00	f	504	143
100	2020-06-12 14:08:34.287305+00	f	509	143
96	2020-06-15 06:27:02.732302+00	t	502	143
101	2020-06-12 01:51:24.360533+00	t	626	144
102	2020-06-15 18:28:44.455421+00	t	663	143
103	2020-06-18 06:23:00.30086+00	t	706	143
99	2020-06-12 13:57:18.258568+00	t	511	143
98	2020-06-12 13:57:19.344741+00	t	512	143
\.


--
-- Data for Name: api_phonetoken; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.api_phonetoken (id, phone_number, otp, "timestamp", attempts, used) FROM stdin;
1	+14387965541	7091	2019-12-23 17:39:51.755679+00	1	t
2	+14384531256	3397	2019-12-24 03:02:29.83421+00	1	t
3	+15819912969	4038	2019-12-30 02:01:52.63238+00	1	t
4	+14387965541	3966	2020-01-07 16:09:34.041165+00	1	t
5	+14384531256	9571	2020-01-07 16:12:10.616683+00	1	t
6	+14387942375	0971	2020-01-07 16:29:41.102863+00	1	t
7	+14384531256	0814	2020-01-08 02:01:42.61305+00	1	t
8	+15819912969	6748	2020-01-08 18:47:46.650618+00	1	t
9	+15819912969	7674	2020-01-08 18:53:35.821676+00	1	t
10	+14387942375	7353	2020-01-08 19:20:44.07583+00	1	t
11	+15819912969	8849	2020-01-09 01:38:30.568101+00	1	t
12	+14387942375	0401	2020-01-09 02:06:51.706908+00	1	t
13	+14387965541	9293	2020-01-09 03:23:48.513979+00	1	t
14	+14387942375	1612	2020-01-09 17:39:03.111156+00	0	f
15	+14185690481	6859	2020-01-10 01:44:27.20003+00	1	t
16	+15819912969	0404	2020-01-10 20:10:34.252433+00	2	t
17	+14387942375	6753	2020-01-11 03:21:22.132351+00	0	f
18	+14387942375	5041	2020-01-14 10:09:40.899347+00	1	t
19	+14387942375	3111	2020-01-15 15:50:40.811196+00	1	t
20	+14387965541	9321	2020-01-15 16:17:21.84875+00	1	t
21	+14384531256	4631	2020-01-15 16:18:18.383403+00	1	t
22	+14387965541	8804	2020-01-15 17:02:49.317635+00	1	t
23	+14387942375	0289	2020-01-15 17:04:36.206707+00	1	t
24	+14387942375	0881	2020-01-15 17:51:16.81841+00	1	t
25	+14387965541	5111	2020-01-15 17:54:00.144399+00	1	t
26	+14387942375	4060	2020-01-16 01:20:51.569382+00	1	t
27	+14387965541	8159	2020-01-23 02:30:19.59868+00	1	f
28	+14387965541	1753	2020-01-23 02:34:39.079546+00	1	t
29	+14387942375	8574	2020-01-30 20:05:32.794048+00	1	t
30	+14387942375	0840	2020-01-31 01:38:53.060835+00	1	t
31	+14387942375	4303	2020-01-31 01:49:03.958635+00	1	t
32	+14387942375	1307	2020-01-31 02:09:35.493619+00	1	t
33	+14387942375	3277	2020-01-31 03:27:05.702892+00	1	t
34	+14387965541	7840	2020-01-31 03:29:37.553206+00	1	t
35	+15819912969	1956	2020-01-31 04:07:40.18535+00	1	t
36	+15819912969	1123	2020-01-31 04:53:57.798955+00	1	t
37	+14387965541	4404	2020-01-31 07:25:47.669222+00	1	t
38	+14387942375	1252	2020-01-31 07:28:23.835137+00	1	t
39	+14384531256	9246	2020-01-31 07:34:00.138178+00	1	t
40	+14387942375	6951	2020-01-31 08:32:07.259519+00	1	t
41	+14384531256	3485	2020-01-31 08:35:34.525816+00	1	t
42	+14387942375	2889	2020-01-31 09:39:39.985098+00	1	t
43	+14384531256	2266	2020-01-31 09:43:07.973584+00	1	t
44	+14387942375	0448	2020-01-31 17:42:13.780777+00	1	t
45	+14384531256	0359	2020-01-31 19:15:35.481019+00	0	f
46	+14387942375	9773	2020-01-31 21:09:22.239783+00	1	t
47	+14384531256	1762	2020-01-31 21:13:19.405539+00	1	t
48	+14387942375	8006	2020-01-31 23:10:56.303486+00	1	t
49	+14384531256	2437	2020-01-31 23:15:37.907643+00	1	t
80	+14387945541	7658	2020-02-10 20:36:21.283225+00	1	t
50	+14387965541	2954	2020-01-31 23:30:40.749662+00	2	t
51	+14387942375	5127	2020-02-01 15:39:06.386775+00	1	f
52	+17075551854	3749	2020-02-01 20:15:25.5702+00	1	t
91	+14387942378	7110	2020-02-17 19:17:37.842545+00	1	f
54	+14387965541	0962	2020-02-03 10:58:10.052535+00	1	t
55	+14387965541	2455	2020-02-04 01:35:45.542932+00	1	t
56	+14384531256	1007	2020-02-04 01:39:14.832525+00	1	t
57	+14387965541	6270	2020-02-04 01:45:58.06044+00	1	t
58	+14384531256	8669	2020-02-04 01:46:42.723973+00	1	t
59	+14387965541	4514	2020-02-04 01:52:25.632557+00	1	t
60	+14387965541	2318	2020-02-04 02:01:29.615672+00	1	t
61	+14387965541	4540	2020-02-04 02:38:36.131841+00	1	t
62	+14387965541	7321	2020-02-04 15:21:31.293455+00	1	t
63	+12345678901	9547	2020-02-05 10:30:56.625457+00	1	f
64	+17075551854	5317	2020-02-05 10:31:37.45749+00	0	f
65	+14387965541	2923	2020-02-07 09:04:55.230751+00	1	t
66	+14384531256	1679	2020-02-07 09:12:50.870468+00	1	t
67	+14387965541	1376	2020-02-07 09:21:42.115495+00	1	f
68	+14387965541	7636	2020-02-07 09:21:59.375851+00	0	f
69	+14387965541	1434	2020-02-07 09:41:23.66766+00	1	t
70	+14387965541	2455	2020-02-07 10:33:47.199357+00	1	t
71	+15819912969	0862	2020-02-07 15:52:40.995637+00	1	t
72	+14185690481	3594	2020-02-07 19:45:19.155626+00	1	t
73	+14387965541	6976	2020-02-08 10:26:16.455357+00	1	t
74	+14384531256	0357	2020-02-08 10:30:28.026698+00	1	t
75	+14384531256	8540	2020-02-08 10:34:11.231774+00	1	t
76	+14387965541	5928	2020-02-08 10:37:01.306357+00	1	t
77	+15819912969	6454	2020-02-09 02:42:40.59656+00	1	t
78	+14185690481	2898	2020-02-10 00:03:19.197447+00	1	t
79	+17075551854	0636	2020-02-10 20:21:45.322923+00	1	t
81	+14387965541	1776	2020-02-10 20:38:47.408654+00	1	t
82	+14387965541	5405	2020-02-10 20:57:36.645857+00	1	t
83	+17075551854	3796	2020-02-10 21:03:10.168283+00	1	t
84	+15819912969	3791	2020-02-11 01:19:37.148074+00	1	t
85	+14185690481	1564	2020-02-11 04:08:50.923478+00	1	t
86	+14384531256	3878	2020-02-11 12:31:39.258469+00	1	t
87	+14387965541	5747	2020-02-12 17:45:42.872005+00	1	t
88	+15819912969	6810	2020-02-13 01:27:16.174696+00	1	t
97	+15734052600	5386	2020-02-21 15:47:43.106791+00	0	f
89	+15819912969	6822	2020-02-16 17:51:44.394297+00	1	t
90	+14084766514	4126	2020-02-17 19:01:13.239347+00	1	t
92	+14084766514	7752	2020-02-17 22:54:52.651819+00	1	t
93	+14084766514	0126	2020-02-18 17:53:14.768965+00	1	t
98	+13109880761	4034	2020-02-21 15:48:29.786877+00	0	f
94	+15819912969	8806	2020-02-19 03:26:11.121808+00	1	t
95	+8613109880761	6948	2020-02-19 18:25:57.921547+00	1	t
96	+8615734052600	3083	2020-02-21 14:07:34.781577+00	1	t
99	+8615734052600	3303	2020-02-21 15:49:14.80772+00	1	t
100	+8615734052600	0411	2020-02-24 14:03:17.654642+00	1	t
101	+8615734052600	4706	2020-02-24 18:47:06.146695+00	1	t
102	+8615734052600	2395	2020-02-25 03:02:28.824037+00	1	t
103	+918968429594	0021	2020-02-25 14:34:11.328002+00	0	f
104	+918968429594	5648	2020-02-25 14:35:14.894142+00	0	f
105	+918968429594	4044	2020-02-25 14:35:20.403451+00	1	f
106	+918968429594	0961	2020-02-25 14:35:35.204576+00	0	f
107	+918968429594	3300	2020-02-25 14:42:58.777422+00	0	f
108	+918968429594	6073	2020-02-25 14:47:32.446972+00	0	f
109	+13233643084	6853	2020-02-26 05:53:04.74724+00	1	t
110	+8613109880763	3762	2020-02-26 12:15:48.240412+00	1	t
111	+14084766514	4199	2020-02-27 21:36:23.62862+00	1	t
112	+8615734052600	5137	2020-02-28 15:32:55.2302+00	1	t
113	+8615734052600	6291	2020-03-01 04:53:34.277266+00	2	t
114	+16134132747	4637	2020-03-02 23:25:59.492399+00	1	t
115	+18192716210	1286	2020-03-02 23:33:10.166838+00	1	t
116	+18197755334	7169	2020-03-02 23:39:10.514546+00	1	t
117	+14384075384	1323	2020-03-02 23:40:18.019496+00	1	t
118	+15145766822	8878	2020-03-02 23:45:15.183392+00	0	f
119	+15145766022	4191	2020-03-02 23:45:28.43768+00	1	t
120	+13104227623	9086	2020-03-02 23:46:55.957389+00	1	t
121	+18195762842	1988	2020-03-02 23:48:52.000175+00	1	t
122	+18193194428	7827	2020-03-02 23:49:20.799094+00	1	t
123	+18195348527	5713	2020-03-03 00:35:30.264812+00	1	t
124	+15813085131	1710	2020-03-03 00:45:54.777472+00	1	t
125	+18194616270	9519	2020-03-03 01:09:40.88138+00	1	t
126	+15819965242	5031	2020-03-03 01:27:38.990688+00	1	t
127	+16474917437	2851	2020-03-03 01:43:43.681489+00	0	f
128	+16134134833	1752	2020-03-03 01:44:06.268994+00	1	t
171	+18196650187	4149	2020-03-05 02:19:14.829142+00	1	t
129	+16135014556	9730	2020-03-03 01:58:32.206221+00	2	t
130	+14386227568	8045	2020-03-03 01:59:04.020639+00	1	t
131	+18192716210	5864	2020-03-03 02:22:06.935105+00	1	t
132	+15147778013	0143	2020-03-03 02:35:04.300464+00	1	t
133	+16134478523	6428	2020-03-03 02:54:44.675749+00	1	t
134	+15875007235	0843	2020-03-03 02:59:14.781515+00	1	t
135	+14039095453	0700	2020-03-03 06:50:24.786794+00	1	t
136	+14388882149	0802	2020-03-03 09:26:29.757889+00	1	t
137	+16134155403	9226	2020-03-03 12:00:07.595427+00	1	t
138	+16479144994	7839	2020-03-03 12:51:31.46932+00	1	t
139	+18732887786	0552	2020-03-03 13:03:56.021704+00	1	t
140	+16135135313	1564	2020-03-03 13:28:51.817873+00	1	t
141	+15817775156	6342	2020-03-03 14:01:39.934034+00	1	t
142	+18193299579	4497	2020-03-03 14:02:34.259357+00	1	t
143	+16137206698	9846	2020-03-03 15:36:41.244168+00	1	t
144	+15875990576	2669	2020-03-03 16:56:14.393748+00	1	t
145	+14189055709	1621	2020-03-03 17:30:51.128392+00	1	t
146	+18195925122	9641	2020-03-03 18:11:57.517157+00	1	t
147	+15874364094	5716	2020-03-03 18:23:05.162735+00	1	t
148	+16135135313	3259	2020-03-03 19:03:19.64918+00	1	t
149	+16134101091	0490	2020-03-03 19:06:35.217397+00	0	f
150	+18186617976	7290	2020-03-03 21:18:39.545994+00	1	t
151	+918198002618	2644	2020-03-03 21:53:13.173288+00	0	f
152	+12896845959	3501	2020-03-03 21:57:12.164477+00	1	t
153	+18197908410	2026	2020-03-03 23:17:33.165166+00	1	t
154	+14388202129	3083	2020-03-04 00:07:11.505514+00	1	t
155	+18189646404	3684	2020-03-04 00:10:34.37127+00	1	t
156	+18195932570	1251	2020-03-04 00:24:55.403299+00	1	t
157	+15819965243	6827	2020-03-04 00:38:04.388819+00	0	f
158	+15819965243	2513	2020-03-04 00:38:18.529585+00	0	f
159	+15819965243	8617	2020-03-04 00:39:37.431262+00	1	t
160	+15142094918	5402	2020-03-04 00:40:30.417254+00	1	t
161	+14793220162	4969	2020-03-04 04:29:00.732441+00	1	t
162	+18196093798	5213	2020-03-04 15:04:12.426508+00	1	t
163	+18199681884	6671	2020-03-04 15:06:31.850321+00	1	t
164	+16478895232	4659	2020-03-04 17:42:19.262093+00	1	t
165	+250788325417	2723	2020-03-04 19:42:42.296679+00	1	t
166	+18193292684	7633	2020-03-04 20:28:43.863328+00	1	t
167	+14107141777	8830	2020-03-05 00:49:14.445505+00	1	t
168	+16042201789	1102	2020-03-05 01:11:23.154719+00	1	t
169	+16478095789	5655	2020-03-05 01:19:08.726293+00	1	t
170	+14037710090	4654	2020-03-05 01:59:23.752192+00	1	t
172	+15875668360	3933	2020-03-05 02:56:58.928392+00	1	t
173	+16136065072	7308	2020-03-05 03:31:59.479037+00	1	t
174	+15146477195	8629	2020-03-05 14:15:45.391059+00	1	t
175	+916284676210	8841	2020-03-05 15:21:56.285676+00	1	f
176	+916284676210	5745	2020-03-05 15:22:16.088014+00	1	t
177	+33698565103	9065	2020-03-05 20:46:20.597639+00	0	f
196	+12063976492	5500	2020-03-08 00:23:37.458154+00	0	f
178	+96598989503	2584	2020-03-05 20:57:30.552482+00	2	t
179	+13437778246	0227	2020-03-05 22:49:17.72944+00	1	t
180	+16136063487	4653	2020-03-06 01:40:15.729592+00	1	t
181	+14187175129	8289	2020-03-06 01:40:37.443601+00	0	f
182	+16138065723	5125	2020-03-06 02:11:46.934653+00	1	t
183	+16138902112	6710	2020-03-06 03:55:53.782546+00	1	t
184	+16134156079	2818	2020-03-06 15:56:43.798003+00	1	t
185	+16139814696	8105	2020-03-06 16:08:57.784467+00	1	t
186	+18193280067	8788	2020-03-06 18:24:40.861697+00	1	t
187	+18195769383	8301	2020-03-06 19:15:10.555099+00	1	t
188	+250788826239	2297	2020-03-06 19:26:48.007062+00	1	t
189	+16134101091	2817	2020-03-06 21:54:39.056346+00	1	t
190	+15819900261	5870	2020-03-06 23:33:36.403533+00	1	t
191	+16136681855	5192	2020-03-07 01:23:10.885649+00	1	t
192	+14187175256	7435	2020-03-07 06:01:05.801403+00	1	t
193	+13439975716	7997	2020-03-07 07:59:07.991515+00	1	t
194	+17692189192	9944	2020-03-07 16:26:11.740078+00	1	t
195	+919586807698	2632	2020-03-07 16:32:06.534884+00	1	t
197	+14794354252	7980	2020-03-08 00:24:44.369741+00	1	t
198	+16136004601	4501	2020-03-08 03:08:30.319057+00	1	t
199	+18193285011	6560	2020-03-08 07:39:15.772734+00	1	t
200	+16136681855	7406	2020-03-09 01:12:09.135391+00	1	t
201	+15819912969	0599	2020-03-09 01:41:48.391203+00	1	t
202	+14185634591	5922	2020-03-09 03:15:23.238835+00	1	t
203	+16138510279	6974	2020-03-09 14:36:55.626208+00	1	t
204	+16136006752	4204	2020-03-09 14:52:33.234257+00	1	t
205	+16133638608	9962	2020-03-09 15:12:43.330585+00	1	t
206	+18193299439	9219	2020-03-09 15:20:22.754857+00	1	t
207	+16133163043	7014	2020-03-09 15:35:31.121247+00	0	f
208	+16133163043	5825	2020-03-09 15:35:58.272607+00	0	f
209	+16133163043	9856	2020-03-09 15:36:19.626004+00	0	f
210	+16133163043	7489	2020-03-09 15:36:40.849933+00	0	f
211	+16133163043	8906	2020-03-09 15:37:11.937707+00	0	f
212	+16133163043	1018	2020-03-09 15:47:15.753018+00	1	t
213	+18733534423	5763	2020-03-09 16:01:29.765637+00	1	t
214	+18195769432	4739	2020-03-09 16:02:06.843491+00	1	t
215	+16138839020	6568	2020-03-09 16:02:26.127755+00	2	t
216	+17058758334	3394	2020-03-09 16:38:47.351311+00	1	t
217	+16477812324	5465	2020-03-09 16:39:26.202495+00	1	t
218	+16137694877	0063	2020-03-09 17:49:11.217189+00	1	t
219	+16137008619	7363	2020-03-09 17:56:47.486471+00	1	t
220	+16133230028	3958	2020-03-09 18:23:44.891632+00	1	t
221	+13439977226	5406	2020-03-09 18:38:09.679977+00	0	f
222	+13439977229	4617	2020-03-09 18:38:15.525454+00	1	t
223	+18133540221	8112	2020-03-09 18:48:55.330251+00	0	f
224	+18733540221	4598	2020-03-09 18:49:17.475097+00	1	t
225	+16138789854	2315	2020-03-09 19:06:09.266287+00	1	t
226	+16137163988	1695	2020-03-09 19:18:58.194089+00	0	f
227	+16137163988	8044	2020-03-09 19:19:18.2168+00	1	t
228	+13067163171	9507	2020-03-09 19:30:31.959048+00	1	t
229	+16136393014	9366	2020-03-09 19:49:31.915146+00	1	t
230	+18732882447	1086	2020-03-09 21:23:45.202685+00	1	t
231	+19059770111	9743	2020-03-09 23:22:11.847261+00	1	t
232	+18193293201	2321	2020-03-10 02:39:03.61237+00	1	t
233	+12074098983	2938	2020-03-10 04:19:16.709735+00	1	t
234	+15103840718	8307	2020-03-10 07:23:47.281525+00	1	t
235	+5512991879181	8875	2020-03-10 09:58:42.931175+00	1	f
236	+5512991879181	5877	2020-03-10 09:59:05.929835+00	1	f
237	+5512991879181	3166	2020-03-10 12:42:57.700003+00	1	t
238	+18192306399	8903	2020-03-10 13:54:53.347749+00	1	t
239	+17054987562	2387	2020-03-11 03:56:14.025637+00	1	t
240	+16476182781	2726	2020-03-11 04:48:46.217899+00	0	f
241	+16476182781	1509	2020-03-11 04:49:03.867292+00	1	t
242	+16132614859	6868	2020-03-11 09:19:29.296584+00	1	t
243	+96599464009	2715	2020-03-11 10:49:52.106142+00	2	f
244	+918874464014	9911	2020-03-12 06:03:55.045908+00	1	t
245	+918874464014	6423	2020-03-12 06:07:53.493175+00	1	t
246	+918874464014	4724	2020-03-12 06:35:18.427178+00	1	t
247	+16137910605	4989	2020-03-13 05:58:34.07617+00	1	t
248	+918874464014	0922	2020-03-13 10:29:11.901345+00	1	t
249	+918874464014	5418	2020-03-16 06:22:18.502328+00	1	t
250	+918874464014	5282	2020-03-16 13:20:29.463117+00	1	t
251	+15878892903	2292	2020-03-16 17:08:12.378468+00	0	f
252	+15878892903	1789	2020-03-16 17:09:00.606075+00	1	t
253	+918874464014	8159	2020-03-17 11:14:46.339381+00	1	t
254	+18193287398	7018	2020-03-18 02:07:58.59029+00	1	t
255	+16043490860	3027	2020-03-18 10:32:17.668703+00	1	t
256	+918874464014	1317	2020-03-18 13:25:21.59642+00	1	t
257	+18197715656	1611	2020-03-19 02:52:32.456967+00	0	f
258	+18193517013	1535	2020-03-19 02:52:56.044083+00	1	t
259	+17865067619	8677	2020-03-19 20:08:51.862169+00	1	t
260	+923044585982	0699	2020-03-19 20:20:11.9451+00	1	t
261	+918874464014	4995	2020-03-20 05:21:42.697846+00	1	t
262	+918874464014	9596	2020-03-20 09:55:27.275257+00	1	t
263	+17865067619	8155	2020-03-22 03:19:36.55739+00	1	t
264	+15146556103	1654	2020-03-22 04:03:13.837802+00	1	t
265	+16133014514	9172	2020-03-23 03:37:24.877199+00	1	t
266	+250788407340	8107	2020-03-23 09:20:03.298509+00	1	t
267	+917355026529	2526	2020-03-24 05:56:47.31187+00	1	t
268	+919911996593	6569	2020-03-24 07:03:37.062838+00	1	t
269	+918319296414	1221	2020-03-24 13:51:11.800695+00	1	t
270	+17865067619	7794	2020-03-24 15:20:01.332102+00	1	t
271	+919998027925	3168	2020-03-24 17:08:12.058466+00	1	t
272	+17865067619	3623	2020-03-24 17:14:03.965045+00	1	t
273	+918200182941	0328	2020-03-25 04:48:27.044664+00	1	t
274	+18186617994	1774	2020-03-25 18:37:58.925754+00	1	t
275	+919998730557	1780	2020-03-26 04:49:54.489627+00	1	t
276	+16132226644	0527	2020-03-28 13:38:30.535206+00	1	t
277	+15819965243	7987	2020-03-31 04:01:42.918705+00	1	t
278	+18197441243	6676	2020-03-31 15:59:41.439892+00	1	t
279	+17865067619	3935	2020-04-01 03:06:36.792133+00	1	t
280	+17865067619	0961	2020-04-02 15:25:19.284641+00	1	t
281	+923326142059	0280	2020-04-08 10:53:41.383615+00	0	f
282	+923326142059	6039	2020-04-08 11:01:13.299791+00	0	f
283	+923326142059	3750	2020-04-08 11:08:22.888032+00	0	f
284	+923326142059	6502	2020-04-08 11:14:05.943136+00	0	f
285	+13345680002	0223	2020-04-08 11:21:02.81191+00	0	f
286	+13345680002	5300	2020-04-08 12:39:47.653812+00	0	f
287	+17865067619	3808	2020-04-08 20:57:02.503411+00	1	t
288	+17865067688	9196	2020-04-09 01:01:45.724171+00	0	f
289	+17865067619	7636	2020-04-09 01:02:13.470737+00	0	f
290	+17865067619	0071	2020-04-09 14:36:57.412348+00	1	t
291	+923326142059	9644	2020-04-10 15:13:55.214784+00	1	t
292	+923326142059	3641	2020-04-11 09:34:00.061172+00	1	t
293	+923326142059	1661	2020-04-13 11:18:09.956686+00	1	t
294	+923326142059	5669	2020-04-13 12:06:38.366613+00	0	f
295	+923326142059	2539	2020-04-13 12:07:08.348574+00	1	f
296	+923326142059	3228	2020-04-13 12:07:31.100978+00	1	t
297	+923326142059	5768	2020-04-13 12:27:50.991271+00	1	t
298	+923326142059	1143	2020-04-13 20:16:18.753334+00	0	f
299	+17865067619	7329	2020-04-13 20:25:58.081882+00	0	f
300	+17865067619	9192	2020-04-14 19:12:35.668494+00	1	t
301	+17865067619	0186	2020-04-14 20:53:14.741851+00	1	t
302	+17865067619	9555	2020-04-15 16:50:48.623841+00	1	t
303	+919717699480	7639	2020-04-18 19:49:19.686531+00	1	t
304	+917906730077	3539	2020-04-18 19:56:11.666516+00	1	t
305	+919717699480	2487	2020-04-18 19:59:09.688336+00	1	t
53	+14387942375	7297	2020-02-01 20:20:05.394848+00	28	t
306	+917007956615	0545	2020-04-21 07:32:25.782519+00	1	t
307	+919717699480	7618	2020-04-21 11:21:31.231048+00	1	t
308	+919969673899	3418	2020-04-24 09:31:30.072684+00	1	t
309	+917007956615	2470	2020-04-24 10:42:51.918164+00	1	t
310	+917007956615	9236	2020-04-24 11:29:02.145173+00	1	t
311	+919717699480	8069	2020-04-24 19:14:12.361291+00	1	t
312	+919717699480	5378	2020-04-25 07:43:32.912987+00	1	t
313	+919717699480	7155	2020-04-27 08:40:13.239721+00	2	f
314	+919717699480	3500	2020-04-27 08:41:12.502785+00	1	f
315	+919717699480	5424	2020-04-27 08:42:11.957862+00	1	f
316	+919717699480	2792	2020-04-27 08:43:03.820288+00	1	f
317	+919717699480	7881	2020-04-27 08:44:57.948671+00	0	f
318	+919717699480	5996	2020-04-27 08:46:28.599879+00	1	t
319	+919717699480	1447	2020-04-27 13:19:10.902631+00	1	t
320	+919717699480	8063	2020-04-27 17:49:41.185272+00	0	f
321	+919717699480	9017	2020-04-27 18:06:18.347587+00	0	f
325	+919911151831	3091	2020-04-27 18:36:54.169135+00	1	t
326	+919911151831	3760	2020-04-27 20:13:20.272926+00	1	t
322	+919717699480	1716	2020-04-27 18:06:39.061392+00	4	t
323	+919717699480	7156	2020-04-27 18:24:57.28636+00	1	t
324	+919911151831	1097	2020-04-27 18:29:46.635843+00	2	t
327	+919911151831	0832	2020-04-27 20:53:54.795925+00	1	t
335	+919911996593	7756	2020-05-08 17:52:17.043868+00	1	t
328	+919717699480	8474	2020-04-28 07:18:24.055739+00	2	t
329	+919717699480	0518	2020-04-28 07:39:55.565638+00	1	t
330	+919717699480	8177	2020-04-28 10:37:49.907803+00	1	t
331	+919911996593	8552	2020-05-01 05:40:34.547889+00	1	t
332	+919911996593	5450	2020-05-01 09:01:59.091143+00	1	t
333	+919911996593	6016	2020-05-01 17:47:25.176998+00	1	t
334	+17865067619	6524	2020-05-05 15:48:46.613474+00	1	t
336	+919911996593	2247	2020-05-19 18:30:21.735255+00	1	t
337	+917007956615	5883	2020-05-20 06:28:24.335718+00	1	t
338	+917007956615	7962	2020-05-27 10:39:05.262153+00	1	t
339	+917007956615	9037	2020-06-02 14:55:10.075737+00	0	f
340	+917007956615	7003	2020-06-07 12:01:50.307392+00	1	t
341	+919911996593	8562	2020-06-08 06:12:46.083105+00	0	f
342	+919911996593	1764	2020-06-08 06:13:40.642673+00	1	t
343	+919911996593	0465	2020-06-08 16:11:51.578095+00	1	t
344	+919911996593	0872	2020-06-08 17:10:25.585809+00	1	t
345	+917007956615	0076	2020-06-09 13:55:35.679735+00	1	t
346	+917007956615	9751	2020-06-09 17:51:06.468315+00	1	t
347	+917007956615	1732	2020-06-10 13:57:31.415752+00	1	t
348	+919969673899	0016	2020-06-12 01:50:45.01042+00	1	t
349	+917007956615	9248	2020-06-12 04:24:07.208966+00	1	t
350	+919911996593	1821	2020-06-15 15:43:08.890927+00	1	t
351	+917007956615	5451	2020-06-23 16:59:32.777984+00	1	t
352	+917007956615	1648	2020-06-23 17:01:24.177511+00	1	t
353	+919911996593	7773	2020-06-24 21:24:36.879538+00	1	t
354	+917007956615	3974	2020-06-24 21:27:58.858719+00	1	t
355	+917007956615	1192	2020-06-25 07:19:57.022914+00	1	t
356	+919969673899	6546	2020-06-26 04:35:56.223416+00	1	t
357	+917007956615	6910	2020-06-29 17:31:29.519644+00	1	t
358	+917007956615	9156	2020-06-30 18:17:26.864472+00	1	t
359	+919969673899	3812	2020-06-30 18:19:22.364334+00	1	t
360	+917007956615	8299	2020-06-30 18:35:11.737785+00	1	t
361	+918840636662	0988	2020-06-30 18:40:36.059175+00	1	t
362	+919911996593	1475	2020-07-01 00:41:26.302361+00	1	t
363	+919911996593	4458	2020-07-01 00:43:30.578954+00	1	t
364	+919911996593	8792	2020-07-01 12:30:36.308397+00	1	t
365	+917007956615	4705	2020-07-01 14:40:43.986946+00	1	t
366	+918808199686	3097	2020-07-02 16:03:37.23204+00	1	t
367	+919911996593	0932	2020-07-02 20:29:22.844282+00	1	t
368	+917007956615	2809	2020-07-02 20:31:59.243051+00	1	t
369	+919911996593	1063	2020-07-03 05:33:10.280926+00	1	t
370	+919969673899	8992	2020-07-03 11:40:00.160664+00	1	t
371	+917007956615	1734	2020-07-07 14:12:55.722295+00	1	t
372	+919911996593	4349	2020-07-07 15:42:54.179388+00	1	t
373	+919911996593	1747	2020-07-08 03:27:26.856512+00	1	t
374	+917007956615	3769	2020-07-08 04:08:17.750348+00	1	t
375	+919911996593	1287	2020-07-08 05:45:52.011623+00	1	t
376	+917007956615	2214	2020-07-14 14:36:00.339121+00	1	t
\.


--
-- Data for Name: api_voicemessage; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.api_voicemessage (id, created, file, from_user_id, to_user_id, is_heard, is_seen, extra_file, extra_type, text, group_id) FROM stdin;
106	2020-02-07 10:41:41.798301+00	1d481ffe-c41b-41bd-8da5-1937a3a2cee2.m4a	2	1	f	f	\N	\N	\N	\N
107	2020-02-07 10:41:55.095468+00	6a7d97e0-a7fb-4383-aeb2-a5eff2db82a6.m4a	2	3	f	f	\N	\N	\N	\N
108	2020-02-07 10:42:11.644116+00	b1315d38-c3d0-4774-888e-63d4c8b486ea.m4a	3	2	f	f	\N	\N	\N	\N
109	2020-02-08 01:06:48.018621+00	4af364e9-a362-4f50-9bcc-67922010209f.m4a	2	3	f	f	\N	\N	\N	\N
110	2020-02-08 01:06:54.283011+00	d0b3ea89-e5e9-4595-913a-33ade5eab410.m4a	3	2	f	f	\N	\N	\N	\N
111	2020-02-08 10:26:43.160108+00	4e04d909-992f-4d99-9b1b-689232286895.m4a	2	3	f	f	\N	\N	\N	\N
112	2020-02-09 07:02:11.824046+00	cdeb3e5c-45c0-4923-8024-520016631118.m4a	3	2	f	f	\N	\N	\N	\N
113	2020-02-10 00:06:45.500424+00	14605c68-5c7b-4a12-a750-6cc10e606ad9.m4a	7	8	f	f	\N	\N	\N	\N
114	2020-02-10 00:11:31.126393+00	59b52d3b-dfea-4ae1-9b47-f91e09dfbb96.m4a	8	7	f	f	\N	\N	\N	\N
115	2020-02-10 05:35:09.065492+00	1ff6f803-9957-47da-931f-e46dcd392f00.m4a	7	8	f	f	\N	\N	\N	\N
116	2020-02-10 05:35:16.044152+00	4980717e-f6e6-4aec-837b-c86c28c8a053.m4a	8	7	f	f	\N	\N	\N	\N
117	2020-02-10 05:36:39.131024+00	a8447954-686c-4237-b678-76c9e627ff99.m4a	7	8	f	f	\N	\N	\N	\N
118	2020-02-10 05:36:57.024123+00	4e01df19-aba7-4ea6-8c09-f0c661b312fe.m4a	7	8	f	f	\N	\N	\N	\N
119	2020-02-10 05:38:35.701406+00	17287e94-bfdd-4f0e-ab8a-f80d35729c5d.m4a	7	8	f	f	\N	\N	\N	\N
120	2020-02-10 05:40:55.342458+00	d84763f0-afbe-4f57-8465-72da47019f3b.m4a	8	7	f	f	\N	\N	\N	\N
121	2020-02-10 05:41:05.500535+00	038616da-67ca-4dcc-a1d8-108b4f20d26c.m4a	8	7	f	f	\N	\N	\N	\N
122	2020-02-10 05:41:24.953274+00	4a5f4fbb-0c66-4855-9a7e-58a880aa3b0a.m4a	8	7	f	f	\N	\N	\N	\N
123	2020-02-10 05:41:29.216963+00	f5a25a1c-4d70-47dd-96e9-576932288600.m4a	8	7	f	f	\N	\N	\N	\N
124	2020-02-10 05:41:34.165734+00	829f6ff1-fdf3-4272-bdfa-db7e7bac8934.m4a	8	7	f	f	\N	\N	\N	\N
125	2020-02-10 05:41:41.439716+00	b32d910a-ad4f-49fe-8411-c9671fff96b4.m4a	8	7	f	f	\N	\N	\N	\N
126	2020-02-10 05:41:47.654823+00	8a5948d2-9932-45ca-a783-7d7bdeb27d89.m4a	8	7	f	f	\N	\N	\N	\N
127	2020-02-10 17:52:28.468385+00	516775f1-59e2-499f-aadc-3d4f794622eb.m4a	2	7	f	f	\N	\N	\N	\N
128	2020-02-10 17:57:24.373951+00	3e1e7912-02eb-4ff3-8ef1-dad1214f2a0a.m4a	2	7	f	f	\N	\N	\N	\N
129	2020-02-10 18:19:18.242105+00	8f6c3b77-1f07-455c-bb36-bf81d8f04005.m4a	8	7	f	f	\N	\N	\N	\N
130	2020-02-10 20:39:24.599093+00	08a5c7f7-637f-48ca-a8e7-45be8e2e14a3.m4a	2	6	f	f	\N	\N	\N	\N
131	2020-02-10 21:03:33.77244+00	86fa8fd8-a978-49c5-a26c-aedec572bfa2.m4a	2	6	f	f	\N	\N	\N	\N
132	2020-02-10 21:03:40.669898+00	b4bc2fc1-8648-4453-9a46-aeb4a490463b.m4a	2	6	f	f	\N	\N	\N	\N
133	2020-02-10 21:04:05.704474+00	944dd8c4-51c6-4a8f-ae79-7605095b7c32.m4a	2	7	f	f	\N	\N	\N	\N
134	2020-02-10 21:05:12.994546+00	0241cd88-b197-4343-a90e-deba7a26ff16.m4a	2	7	f	f	\N	\N	\N	\N
135	2020-02-10 21:06:28.049713+00	98b73b9f-2de8-4e8e-91e7-c95a0de633c8.m4a	7	8	f	f	\N	\N	\N	\N
136	2020-02-11 05:07:24.817606+00	28da65c8-5bc8-4bbf-8863-c1abd1a4c100.m4a	7	8	f	f	\N	\N	\N	\N
137	2020-02-11 05:08:02.915849+00	afeeedc9-2841-4716-a77f-f18b54aa734d.m4a	8	7	f	f	\N	\N	\N	\N
138	2020-02-11 05:08:39.624211+00	5f7b539d-8551-45e3-bddd-fbb5cb682be3.m4a	7	8	f	f	\N	\N	\N	\N
139	2020-02-11 05:08:46.697226+00	39059a8b-3bdf-4189-a276-359eed894551.m4a	7	8	f	f	\N	\N	\N	\N
140	2020-02-11 05:09:32.992987+00	692c79f9-4805-4f75-b4ce-58f04c2bb5df.m4a	8	7	f	f	\N	\N	\N	\N
141	2020-02-11 05:12:58.715119+00	5223adff-c879-4890-b45d-bc3d01762920.m4a	7	8	f	f	\N	\N	\N	\N
142	2020-02-11 05:13:41.907798+00	d033c8ae-a7f1-4f86-92c2-6fadc5ef0e80.m4a	8	7	f	f	\N	\N	\N	\N
143	2020-02-11 05:42:38.453776+00	e55c829f-802d-4fa3-b66f-685a7375ef43.m4a	7	8	f	f	\N	\N	\N	\N
144	2020-02-11 13:10:04.058163+00	a49000d7-660e-498e-98db-681598e86b60.m4a	7	8	f	f	\N	\N	\N	\N
145	2020-02-19 18:27:55.457628+00	8623dc1e-6644-4b85-9d1a-b35890fb1484.m4a	11	1	f	f	\N	\N	\N	\N
146	2020-02-19 18:28:50.254402+00	643c0633-efb1-4625-8f6f-30025c573ee2.m4a	11	1	f	f	\N	\N	\N	\N
147	2020-02-24 14:38:51.539588+00	58a0e39e-c322-4ee0-81c2-934a81c18ef6.m4a	12	1	f	f	\N	\N	\N	\N
148	2020-02-24 16:27:25.184009+00	cdc555c4-e028-40bd-87be-60d9eb88f14c.m4a	12	1	f	f	\N	\N	\N	\N
149	2020-03-02 23:40:59.355599+00	395bba20-ab0e-4cf3-aebe-9f0cfff2905e.m4a	17	7	f	f	\N	\N	\N	\N
150	2020-03-02 23:41:18.854027+00	e388904d-0b3a-481f-9d88-79ac89b71efa.m4a	17	7	f	f	\N	\N	\N	\N
151	2020-03-02 23:41:32.432618+00	da74a9e0-8e05-48f7-be75-cef4196c7e65.m4a	17	7	f	f	\N	\N	\N	\N
152	2020-03-02 23:41:58.64536+00	06d4c929-ac1a-4d5f-afe2-1f7014ef6533.m4a	17	16	f	f	\N	\N	\N	\N
153	2020-03-02 23:54:24.328421+00	86166940-6bb1-42a7-beef-0fa40294d029.m4a	7	17	f	f	\N	\N	\N	\N
154	2020-03-02 23:54:50.461719+00	be889c09-fdb5-4231-a558-db7dcfcca984.m4a	7	19	f	f	\N	\N	\N	\N
155	2020-03-02 23:56:05.253145+00	5bd7426e-f7a9-4597-9dda-7cddb9f3e9c0.m4a	7	18	f	f	\N	\N	\N	\N
156	2020-03-02 23:56:37.889528+00	b26e68f2-467a-49d8-99c2-f08f8deb2377.m4a	7	16	f	f	\N	\N	\N	\N
157	2020-03-02 23:57:51.977464+00	c9704850-5c75-4758-bc1d-964c45075b35.m4a	7	20	f	f	\N	\N	\N	\N
158	2020-03-03 00:13:51.328113+00	7c84b071-d485-4e0f-be91-7738ea3d8644.m4a	17	7	f	f	\N	\N	\N	\N
159	2020-03-03 00:14:29.210974+00	04e034db-d46e-4006-b5f2-721887088404.m4a	17	7	f	f	\N	\N	\N	\N
160	2020-03-03 00:14:41.308029+00	71527d96-bc8f-46f2-ad6d-0c370222301d.m4a	8	18	f	f	\N	\N	\N	\N
161	2020-03-03 00:16:43.966149+00	97ceac53-9fea-4df8-a39d-ff4968fa3a0a.m4a	18	8	f	f	\N	\N	\N	\N
162	2020-03-03 00:26:17.036485+00	b579fc03-69be-4a82-8584-deb554d9d065.m4a	17	7	f	f	\N	\N	\N	\N
163	2020-03-03 00:32:28.564907+00	ef2d8ee6-cb6c-41a0-8aed-01ad7e582c90.m4a	7	21	f	f	\N	\N	\N	\N
164	2020-03-03 00:49:47.730987+00	421242ea-09ce-4799-90b4-a4b8b124520f.m4a	7	23	f	f	\N	\N	\N	\N
165	2020-03-03 00:50:05.277345+00	f600cc1f-89f1-4938-bf6f-ea417eafa64f.m4a	7	24	f	f	\N	\N	\N	\N
166	2020-03-03 01:21:53.409872+00	4ba392fa-ae72-4ecb-9c3f-2d3dedf9c6a0.m4a	17	25	f	f	\N	\N	\N	\N
167	2020-03-03 01:27:27.801957+00	55d9ddf7-f724-47e4-bddd-ad4de99e0b7d.m4a	23	7	f	f	\N	\N	\N	\N
168	2020-03-03 01:27:35.030538+00	d4072dcb-1bd3-4e0d-9a55-c8734550c627.m4a	23	7	f	f	\N	\N	\N	\N
169	2020-03-03 02:23:36.275035+00	3f3af253-bef1-4f52-9c17-11963d87f6dc.m4a	16	7	f	f	\N	\N	\N	\N
170	2020-03-03 02:29:17.060184+00	e48dbfa8-9b71-4979-8f2e-b52869ac9625.m4a	7	23	f	f	\N	\N	\N	\N
171	2020-03-03 02:29:45.191281+00	8fd43cac-bc5b-42cb-8033-41c141ae10d1.m4a	7	23	f	f	\N	\N	\N	\N
172	2020-03-03 03:52:31.113376+00	e2ae4cc7-affa-4fe1-9dac-2aec5fc8da11.m4a	17	28	f	f	\N	\N	\N	\N
173	2020-03-03 03:55:19.506508+00	a259636d-b778-4d96-ac8d-8dddf5e3290a.m4a	19	8	f	f	\N	\N	\N	\N
174	2020-03-03 03:55:42.692755+00	d909aa52-f421-4db9-bd99-c98d1a8c5d66.m4a	19	8	f	f	\N	\N	\N	\N
175	2020-03-03 03:57:57.173876+00	b4bc2a55-2d8c-4628-bd09-1e765e3c6882.m4a	25	17	f	f	\N	\N	\N	\N
176	2020-03-03 04:15:06.582013+00	4dad6dbd-b619-4e68-ad78-ab16def1b052.m4a	7	32	f	f	\N	\N	\N	\N
177	2020-03-03 04:44:07.812278+00	5ba43561-d583-4964-8e67-94d96cd6d5aa.m4a	32	7	f	f	\N	\N	\N	\N
178	2020-03-03 04:45:00.5308+00	8b5fc5fa-5035-4534-a5b2-e4bbf69bc3ad.m4a	7	32	f	f	\N	\N	\N	\N
179	2020-03-03 04:45:19.906676+00	aa6a54e1-b330-43a1-97c4-efa9b99c4a14.m4a	27	7	f	f	\N	\N	\N	\N
180	2020-03-03 04:45:50.633869+00	851ba683-f343-44bd-924e-57512b0bc68f.m4a	7	27	f	f	\N	\N	\N	\N
181	2020-03-03 04:45:51.196622+00	b142325c-6752-4ba9-86b2-41eef9dc366b.m4a	27	7	f	f	\N	\N	\N	\N
182	2020-03-03 04:46:35.392567+00	7e46d98a-1658-4432-a226-2b65152b1377.m4a	7	27	f	f	\N	\N	\N	\N
183	2020-03-03 04:46:45.204191+00	88e49759-d74d-4860-8fba-f7fc456aa512.m4a	32	7	f	f	\N	\N	\N	\N
184	2020-03-03 04:47:07.796354+00	46c5f15c-9eec-4444-aaef-6c5176f2248d.m4a	32	7	f	f	\N	\N	\N	\N
185	2020-03-03 04:49:35.352925+00	83994a09-dab5-4ee7-9df8-eb432c3c91d4.m4a	7	32	f	f	\N	\N	\N	\N
186	2020-03-03 04:50:37.217831+00	9c7c81ca-10e1-4daf-9393-1b38842ac19a.m4a	7	32	f	f	\N	\N	\N	\N
187	2020-03-03 04:51:40.346202+00	61475413-e6ce-4f40-86f3-0eadd6ab9eed.m4a	7	27	f	f	\N	\N	\N	\N
188	2020-03-03 05:10:31.94857+00	946fde26-1a88-4068-8d51-a977b0919c3b.m4a	8	19	f	f	\N	\N	\N	\N
189	2020-03-03 05:11:00.066705+00	30d63eb5-e9d1-451b-a3bc-3fcb5bb559ce.m4a	8	19	f	f	\N	\N	\N	\N
190	2020-03-03 05:28:56.701268+00	d9f56968-d8ec-4826-a788-3b3e0226dc34.m4a	29	7	f	f	\N	\N	\N	\N
191	2020-03-03 05:36:41.320392+00	b2eda246-4c01-45bb-b71b-2b3e82148003.m4a	7	29	f	f	\N	\N	\N	\N
192	2020-03-03 05:37:01.217954+00	c03977a0-108d-4698-8301-04712dbce579.m4a	7	29	f	f	\N	\N	\N	\N
193	2020-03-03 05:52:51.100927+00	5270e133-6648-4877-99b6-acd71c9943cf.m4a	32	7	f	f	\N	\N	\N	\N
194	2020-03-03 05:56:02.087833+00	352ea492-8f86-4968-9ce5-3a3d6aa45604.m4a	7	32	f	f	\N	\N	\N	\N
195	2020-03-03 05:56:54.04623+00	de592ab3-d09b-47d6-87c1-f3cf05827e45.m4a	7	32	f	f	\N	\N	\N	\N
196	2020-03-03 12:20:07.993084+00	a5984ccd-bec0-4594-99ba-e007bc62fc2d.m4a	7	35	f	f	\N	\N	\N	\N
197	2020-03-03 12:36:48.491645+00	2fc8c7e8-9504-40c0-87a4-c1a0edd60a0b.m4a	35	7	f	f	\N	\N	\N	\N
198	2020-03-03 13:32:36.886731+00	21033ad3-09e4-46c3-a48c-5a4e00a641c9.m4a	19	8	f	f	\N	\N	\N	\N
199	2020-03-03 13:32:52.559245+00	d46b6d5c-fca9-4365-8014-0941a0a61b84.m4a	19	8	f	f	\N	\N	\N	\N
200	2020-03-03 13:46:49.277562+00	cd0b0c60-f5b6-46ab-a004-1cf89585f19a.m4a	7	35	f	f	\N	\N	\N	\N
201	2020-03-03 13:51:32.809578+00	f9255c0d-1414-40e7-bac0-856f54649df8.m4a	17	37	f	f	\N	\N	\N	\N
202	2020-03-03 14:14:45.094713+00	e79cba9a-05db-4852-be93-c60f7eece873.m4a	40	7	f	f	\N	\N	\N	\N
203	2020-03-03 14:15:03.505452+00	9d9ac22a-ad28-47b2-ae5a-c2392d4ded1b.m4a	40	38	f	f	\N	\N	\N	\N
204	2020-03-03 14:15:39.559344+00	4bf9e404-e89c-4d55-a796-1a5b74440dd3.m4a	40	38	f	f	\N	\N	\N	\N
205	2020-03-03 15:39:42.05933+00	3d2f2607-3197-4129-93c3-f73165cf34a8.m4a	41	24	f	f	\N	\N	\N	\N
206	2020-03-03 15:40:00.224235+00	01af40c6-70d4-45d7-8887-1fa92ae6a4f4.m4a	41	24	f	f	\N	\N	\N	\N
207	2020-03-03 15:40:51.915828+00	cdce6497-2b06-43fa-859d-0a6b602b20d9.m4a	41	24	f	f	\N	\N	\N	\N
208	2020-03-03 15:42:15.022798+00	e39e4965-6abf-42dd-bf6a-0f6f56895382.m4a	7	40	f	f	\N	\N	\N	\N
209	2020-03-03 15:44:30.44868+00	1f1bc366-af54-4f4f-852a-d2ffb495e3eb.m4a	24	41	f	f	\N	\N	\N	\N
210	2020-03-03 15:46:21.927525+00	19c86c55-8f2d-46d4-b8a4-1e9dcaaf7454.m4a	24	41	f	f	\N	\N	\N	\N
211	2020-03-03 17:33:11.917237+00	4ea4b6cf-0e27-4812-9327-7da365a96eeb.m4a	43	7	f	f	\N	\N	\N	\N
212	2020-03-03 17:40:37.001106+00	b29d5d2b-9750-43d8-a770-6b5e0ce470bf.m4a	41	24	f	f	\N	\N	\N	\N
213	2020-03-03 20:06:08.252867+00	fefd1764-5e14-4dd9-9132-0e50f9441868.m4a	24	41	f	f	\N	\N	\N	\N
214	2020-03-03 20:52:22.44382+00	3ec46fd0-d929-4789-a77e-268b7d39377c.m4a	7	34	f	f	\N	\N	\N	\N
215	2020-03-03 20:53:06.693031+00	00e72fc3-9998-4c02-9598-28de12c5b507.m4a	7	34	f	f	\N	\N	\N	\N
216	2020-03-03 20:53:46.867219+00	7f95fce7-1281-4096-bbbc-62d2b2532c1e.m4a	7	43	f	f	\N	\N	\N	\N
217	2020-03-03 21:02:15.243219+00	48efb12f-5b4d-458c-ac5a-053f067ad3e6.m4a	7	39	f	f	\N	\N	\N	\N
218	2020-03-03 21:27:41.097452+00	2763fcea-b8a7-440e-9be0-367c739134de.m4a	7	46	f	f	\N	\N	\N	\N
219	2020-03-03 21:28:39.708532+00	5226b7a5-b570-46e2-9a1b-db469089e784.m4a	7	46	f	f	\N	\N	\N	\N
220	2020-03-03 21:31:38.483557+00	bc08b85a-952c-4cf9-8121-d035b4c13fcb.m4a	8	19	f	f	\N	\N	\N	\N
221	2020-03-03 22:01:30.967318+00	a74c8fdf-f02b-4f1a-bbae-bdb8ce937407.m4a	17	47	f	f	\N	\N	\N	\N
222	2020-03-03 23:02:27.576842+00	b3f67ef5-ed38-4bac-9db1-7b3d45e2653b.m4a	7	45	f	f	\N	\N	\N	\N
223	2020-03-04 00:12:21.761603+00	773befdb-b20b-4792-a2e8-ee0717d47015.m4a	50	46	f	f	\N	\N	\N	\N
224	2020-03-04 00:56:59.11406+00	dd4f47e3-e098-4dc5-9234-6173017db449.m4a	7	53	f	f	\N	\N	\N	\N
225	2020-03-04 00:57:09.270879+00	adcec9df-0b62-4728-bc09-19c9193b0472.m4a	7	53	f	f	\N	\N	\N	\N
226	2020-03-04 00:57:37.61065+00	840150a5-069e-4b0e-8f8f-e8d7df134f54.m4a	7	48	f	f	\N	\N	\N	\N
227	2020-03-04 01:27:15.153539+00	6a3e4c61-0c0f-4e1a-bad7-e21b23f9874a.m4a	23	7	f	f	\N	\N	\N	\N
228	2020-03-04 01:27:54.040344+00	998ce8d7-5f94-47bb-ab74-941b2609a6e2.m4a	23	7	f	f	\N	\N	\N	\N
229	2020-03-04 01:28:24.90633+00	ff51c3d3-e46e-4622-9de5-ea6c3a568a3f.m4a	23	30	f	f	\N	\N	\N	\N
230	2020-03-04 04:00:28.543565+00	1e651d51-f07d-4168-9bab-39592b9a82c5.m4a	7	23	f	f	\N	\N	\N	\N
231	2020-03-04 04:01:52.712346+00	27ec7b1d-10f9-4380-b6a6-c330c00d0324.m4a	7	23	f	f	\N	\N	\N	\N
232	2020-03-04 04:02:58.955823+00	da7c19e3-85c0-44e6-8b63-e7ae6a79a03c.m4a	7	23	f	f	\N	\N	\N	\N
233	2020-03-04 12:54:25.92929+00	467702d2-abcb-40dd-8071-f8875d2a3a5e.m4a	19	8	f	f	\N	\N	\N	\N
234	2020-03-04 12:55:03.283834+00	d7c0637c-21d3-42a3-b9e7-b71b52b22533.m4a	19	8	f	f	\N	\N	\N	\N
235	2020-03-04 12:55:41.544182+00	6e189468-3ccf-4333-bc96-f945d9c243f9.m4a	19	8	f	f	\N	\N	\N	\N
236	2020-03-04 15:13:58.046475+00	6f837629-06d9-49cf-89de-db1356c571e5.m4a	7	56	f	f	\N	\N	\N	\N
237	2020-03-04 18:50:32.382102+00	a42194e1-3eb0-4eeb-ae1c-b10831980c5b.m4a	7	38	f	f	\N	\N	\N	\N
238	2020-03-04 20:43:21.515461+00	e1dc4379-b0a2-4b78-a1f2-23851329c35e.m4a	7	59	f	f	\N	\N	\N	\N
239	2020-03-04 22:45:05.032822+00	1bfe8695-88e5-44fa-83a1-c84ee3cd8716.m4a	8	19	f	f	\N	\N	\N	\N
240	2020-03-04 22:45:38.964426+00	3eb7aa85-4247-490c-afe2-0cc46578dde4.m4a	8	19	f	f	\N	\N	\N	\N
241	2020-03-05 00:25:42.840526+00	463b0dd6-0b51-4da5-8b84-26d94201038b.m4a	17	47	f	f	\N	\N	\N	\N
242	2020-03-05 00:26:27.069251+00	1e19699d-8615-4cd7-8b08-f0504d4b7181.m4a	17	7	f	f	\N	\N	\N	\N
243	2020-03-05 00:41:05.387353+00	280a7201-2b24-4040-9536-8db2c64d75e6.m4a	47	17	f	f	\N	\N	\N	\N
244	2020-03-05 00:41:43.125422+00	bbb72de2-0e7a-49c1-b701-ddfbfe9a739c.m4a	17	47	f	f	\N	\N	\N	\N
245	2020-03-05 00:41:56.820227+00	37c637c9-3392-4eb6-ac2b-0fcc8ef5e87c.m4a	47	17	f	f	\N	\N	\N	\N
246	2020-03-05 01:21:32.349454+00	c2578ddc-2ea2-4cd5-be98-e71b603811d8.m4a	62	40	f	f	\N	\N	\N	\N
247	2020-03-05 01:43:36.806633+00	03f619f4-a4a9-48a3-b8fc-5edb28d18356.m4a	7	17	f	f	\N	\N	\N	\N
248	2020-03-05 01:43:57.408913+00	4f693eca-c25f-457a-b0d6-1e48222f1121.m4a	7	59	f	f	\N	\N	\N	\N
249	2020-03-05 01:45:00.458322+00	53542df0-9d62-4c82-b15c-73a19c5a0899.m4a	7	59	f	f	\N	\N	\N	\N
250	2020-03-05 01:46:39.122692+00	1842fbb3-7869-490a-906e-ef581eef7dbf.m4a	7	43	f	f	\N	\N	\N	\N
251	2020-03-05 01:47:18.167739+00	b024d742-b0a8-4f43-8416-e9ee121f0906.m4a	7	56	f	f	\N	\N	\N	\N
252	2020-03-05 01:48:31.211029+00	a30b2cc1-7b56-483d-a780-936d7c00b79e.m4a	7	19	f	f	\N	\N	\N	\N
253	2020-03-05 01:51:37.249718+00	27b7d244-11cc-4522-a0b3-c70b32131c84.m4a	7	32	f	f	\N	\N	\N	\N
254	2020-03-05 01:52:44.244614+00	cc93fd9d-c982-489a-9374-c7d93786a639.m4a	32	33	f	f	\N	\N	\N	\N
255	2020-03-05 01:53:45.215072+00	385c64ff-0e09-4322-94dd-727d0743bb61.m4a	33	32	f	f	\N	\N	\N	\N
256	2020-03-05 01:55:59.125418+00	1f3c6f42-6208-4c42-acb5-eb8821551001.m4a	7	8	f	f	\N	\N	\N	\N
257	2020-03-05 01:56:49.078134+00	991c9c6c-4d15-4cff-9d36-021f54a07877.m4a	7	20	f	f	\N	\N	\N	\N
258	2020-03-05 02:00:33.169068+00	54cd9664-eccc-40a5-a3da-d7d41f9c4999.m4a	7	16	f	f	\N	\N	\N	\N
259	2020-03-05 02:02:34.826808+00	c72b469a-ef6c-4492-a579-419504a0fbfc.m4a	7	27	f	f	\N	\N	\N	\N
260	2020-03-05 02:03:23.399087+00	e488fdc8-cdd8-4703-bcb9-514af386ef87.m4a	7	27	f	f	\N	\N	\N	\N
261	2020-03-05 02:05:34.610649+00	c2ae025d-4a81-46d8-a55a-98780b22c3cb.m4a	32	33	f	f	\N	\N	\N	\N
262	2020-03-05 02:05:45.590871+00	90a95699-d1c3-474e-96cd-4b03f84e1327.m4a	32	33	f	f	\N	\N	\N	\N
263	2020-03-05 02:06:30.299893+00	d74693da-3eaf-4974-b050-7df9b2148438.m4a	33	32	f	f	\N	\N	\N	\N
264	2020-03-05 02:07:37.828816+00	06dc5388-77e9-4204-ac25-b89361f3055d.m4a	32	33	f	f	\N	\N	\N	\N
265	2020-03-05 02:13:03.033777+00	0dbc6ef4-2f59-4b1a-8606-4aa671557f97.m4a	32	7	f	f	\N	\N	\N	\N
266	2020-03-05 02:13:18.117868+00	3fcdb7dc-668c-4efe-b2c1-2d6ce2deac5f.m4a	32	7	f	f	\N	\N	\N	\N
267	2020-03-05 03:00:22.018407+00	8562a01d-8b52-4cc0-9d54-da48355f4f24.m4a	7	32	f	f	\N	\N	\N	\N
268	2020-03-05 03:01:23.816601+00	3fe4ba7f-1c2e-4ab4-ad5c-d0d2a7b7d04a.m4a	7	32	f	f	\N	\N	\N	\N
269	2020-03-05 03:02:50.674924+00	9a561e75-838e-4813-9e96-d0d9cdb54675.m4a	7	17	f	f	\N	\N	\N	\N
270	2020-03-05 03:03:13.6742+00	f1a101e7-7761-4b4e-88cf-346105b6ae90.m4a	7	45	f	f	\N	\N	\N	\N
271	2020-03-05 03:04:06.942254+00	de58c262-9a56-4cce-ba0b-6f4075a8e3a7.m4a	17	7	f	f	\N	\N	\N	\N
272	2020-03-05 03:05:38.542776+00	f97eb074-6aaf-4a7a-8b10-b05fa0722d53.m4a	7	17	f	f	\N	\N	\N	\N
273	2020-03-05 03:08:47.509166+00	193be527-207c-48c6-b073-b6562bf6b3f9.m4a	7	30	f	f	\N	\N	\N	\N
274	2020-03-05 03:09:12.157354+00	d52fa758-3690-402b-ae5a-8c62463da7cc.m4a	7	30	f	f	\N	\N	\N	\N
275	2020-03-05 03:16:48.90673+00	e82f551c-6c4a-43ca-b519-f68f593a732c.m4a	7	17	f	f	\N	\N	\N	\N
276	2020-03-05 05:01:21.098745+00	513380e3-1183-4e79-9cbb-b8884ac4cb4e.m4a	19	8	f	f	\N	\N	\N	\N
277	2020-03-05 05:01:45.418426+00	749a1724-8942-4d5a-830b-b27e6af5b23e.m4a	19	8	f	f	\N	\N	\N	\N
278	2020-03-05 15:36:28.441713+00	5c357926-89c5-4dee-9d95-c162fd9bac8c.m4a	50	20	f	f	\N	\N	\N	\N
279	2020-03-05 15:36:38.212452+00	21b76c15-924d-4b9c-8513-5644299e4a19.m4a	50	20	f	f	\N	\N	\N	\N
280	2020-03-05 18:38:29.281102+00	896c1a25-aab9-4a92-bc64-959ed8d3aec7.m4a	40	62	f	f	\N	\N	\N	\N
281	2020-03-05 19:01:10.455886+00	b98e4fc2-c642-4770-8efb-b381df389ca3.m4a	40	2	f	f	\N	\N	\N	\N
282	2020-03-05 19:01:29.078706+00	def4e754-04b0-4acc-915b-f4a4db8c07a5.m4a	40	2	f	f	\N	\N	\N	\N
283	2020-03-05 20:47:52.800654+00	fdc65421-fbe7-4530-b7e3-cd274afa5569.m4a	30	23	f	f	\N	\N	\N	\N
284	2020-03-05 22:51:03.876392+00	dd1f625a-7f3a-48ef-9764-59f344188f8b.m4a	69	40	f	f	\N	\N	\N	\N
285	2020-03-06 00:44:48.590082+00	0f9e519d-0f92-492c-9369-92d39f2f81fa.m4a	45	7	f	f	\N	\N	\N	\N
286	2020-03-06 00:56:26.574972+00	7923d7a9-24b3-42e8-8381-c51f93c94576.m4a	43	7	f	f	\N	\N	\N	\N
287	2020-03-06 00:57:23.278864+00	8b82d7a3-691a-4054-86be-ded0f40f0d13.m4a	43	26	f	f	\N	\N	\N	\N
288	2020-03-06 00:57:32.873533+00	5d81851f-ed7a-4151-b5e7-313ca1f77548.m4a	43	26	f	f	\N	\N	\N	\N
289	2020-03-06 01:45:21.004121+00	82fc4920-924f-46fd-8a3b-292af8eab6ca.m4a	71	8	f	f	\N	\N	\N	\N
290	2020-03-06 03:52:43.657062+00	b04d3edf-621a-43aa-bcc8-ca3d19663629.m4a	7	43	f	f	\N	\N	\N	\N
291	2020-03-06 03:53:35.65306+00	1e7bffe8-88d2-43c1-be68-d73d0a1e3651.m4a	7	45	f	f	\N	\N	\N	\N
292	2020-03-06 04:00:01.745539+00	cee9a852-4319-4f3e-856e-dfd3f4b0a2fc.m4a	45	7	f	f	\N	\N	\N	\N
293	2020-03-06 04:00:44.896703+00	ebb71305-ef86-41a0-80e9-c137526de7f5.m4a	45	7	f	f	\N	\N	\N	\N
294	2020-03-06 04:03:50.904023+00	f1e04b53-98cd-40de-8af8-0ad8ec7691a7.m4a	7	57	f	f	\N	\N	\N	\N
295	2020-03-06 04:06:15.112335+00	9d7419bb-df37-4821-bb3b-cb30da28ebc8.m4a	7	57	f	f	\N	\N	\N	\N
296	2020-03-06 04:57:26.968276+00	e995e600-bb39-4d02-bd12-6e3217086f21.m4a	7	45	f	f	\N	\N	\N	\N
297	2020-03-06 04:58:08.610879+00	748911e6-4159-42c1-a949-309f64cda387.m4a	7	45	f	f	\N	\N	\N	\N
298	2020-03-06 04:59:20.160687+00	3b845c4d-8788-4437-ae18-a35145a70434.m4a	45	7	f	f	\N	\N	\N	\N
299	2020-03-06 05:03:57.073712+00	9a56aada-d31e-44dc-b869-3c21ca80c995.m4a	7	45	f	f	\N	\N	\N	\N
300	2020-03-06 05:48:57.586461+00	56bba14a-40d0-4d37-8a2d-492649497c9b.m4a	23	30	f	f	\N	\N	\N	\N
301	2020-03-06 05:49:48.729732+00	78355760-5d69-4064-957f-e4d411d4a597.m4a	30	23	f	f	\N	\N	\N	\N
302	2020-03-06 06:16:53.011872+00	88b7fb1b-12c9-4f18-9614-6a2206b6f313.m4a	45	7	f	f	\N	\N	\N	\N
303	2020-03-06 06:23:32.784308+00	b6d8fa0e-3c62-4fa0-b1f5-af53c679ae27.m4a	7	45	f	f	\N	\N	\N	\N
304	2020-03-06 06:24:08.270526+00	1baa651b-5845-4265-817e-906ae666235d.m4a	7	45	f	f	\N	\N	\N	\N
305	2020-03-06 12:10:57.532408+00	f8780b90-457a-4a7c-bca6-e6d6957cd68d.m4a	73	7	f	f	\N	\N	\N	\N
306	2020-03-06 14:28:32.740198+00	338f066d-effa-4843-b33e-ca699082e2cc.m4a	7	73	f	f	\N	\N	\N	\N
307	2020-03-06 14:29:53.299278+00	acddade6-c66b-429c-8781-2897c60a1b68.m4a	7	73	f	f	\N	\N	\N	\N
308	2020-03-06 16:05:40.969758+00	2ecdb154-5363-442c-ac6b-acd31771707a.m4a	7	74	f	f	\N	\N	\N	\N
309	2020-03-06 18:37:55.906948+00	58226a73-3ec6-4593-85c4-0681bfbab6c4.m4a	7	56	f	f	\N	\N	\N	\N
310	2020-03-06 19:31:12.2278+00	c887194d-4c0d-404d-b7e9-7b2db7d80119.m4a	78	35	f	f	\N	\N	\N	\N
311	2020-03-06 21:40:48.907691+00	a5bfdef2-97bc-490c-90ce-45c1a300d86f.m4a	16	7	f	f	\N	\N	\N	\N
312	2020-03-06 22:26:55.076079+00	967d4c25-066e-46a4-84c0-77f801600e16.m4a	7	16	f	f	\N	\N	\N	\N
313	2020-03-07 01:27:31.987031+00	17b03437-bcb5-40b5-a9e0-98d235367e60.m4a	81	7	f	f	\N	\N	\N	\N
314	2020-03-07 02:09:13.992837+00	bcd29b58-98b0-443c-ad7b-6551d2ad4863.m4a	81	7	f	f	\N	\N	\N	\N
315	2020-03-07 05:13:24.820553+00	abb09abe-bdc5-4785-886a-4e8fa848b0cf.m4a	7	73	f	f	\N	\N	\N	\N
316	2020-03-07 08:02:49.004587+00	e74db05b-f3dd-4d28-a467-51710d11de44.m4a	17	83	f	f	\N	\N	\N	\N
317	2020-03-07 13:51:22.008821+00	762d3055-7981-4f08-9ae7-811b57b8ccdf.m4a	7	45	f	f	\N	\N	\N	\N
318	2020-03-07 14:01:37.529805+00	e13a3038-5ba5-465e-ac93-8a05830085bb.m4a	7	59	f	f	\N	\N	\N	\N
319	2020-03-07 14:02:23.512642+00	d1c566f9-a090-4352-b4e5-b5cfbfc3fa8f.m4a	7	59	f	f	\N	\N	\N	\N
320	2020-03-07 18:20:49.316776+00	ebefcbe4-9447-402f-8002-4e66dac55229.m4a	35	78	f	f	\N	\N	\N	\N
321	2020-03-07 19:17:59.603458+00	9c17553a-d265-4619-93e4-a601cb048dff.m4a	45	7	f	f	\N	\N	\N	\N
322	2020-03-07 19:18:34.739519+00	d58342d0-fc2a-44ec-bb49-c44352524e0d.m4a	45	7	f	f	\N	\N	\N	\N
323	2020-03-07 21:56:41.436667+00	754df5cf-0ff4-464b-8c95-0f90ba74cd0f.m4a	7	45	f	f	\N	\N	\N	\N
324	2020-03-07 21:57:00.352566+00	dc7f9d2d-d9a7-43ac-96de-ee6572b90357.m4a	7	45	f	f	\N	\N	\N	\N
325	2020-03-07 21:57:54.417895+00	ca2b6ef7-3ba8-4731-ba44-ce89faa4b1d2.m4a	7	24	f	f	\N	\N	\N	\N
326	2020-03-07 21:59:41.484661+00	3f5dcae3-5113-48dd-893e-7595f3408f02.m4a	45	7	f	f	\N	\N	\N	\N
327	2020-03-07 21:59:54.451346+00	568cd280-f773-4ba4-8402-afecc6c51e4b.m4a	45	7	f	f	\N	\N	\N	\N
328	2020-03-07 22:05:27.021713+00	4b5fa223-28c6-4817-a542-440b1545f106.m4a	7	53	f	f	\N	\N	\N	\N
329	2020-03-07 22:06:57.790764+00	a8994e55-82cd-480f-86c9-82ca0cb36d18.m4a	7	45	f	f	\N	\N	\N	\N
330	2020-03-07 22:07:13.552384+00	897ef97a-220a-4af9-8586-151bdd660d06.m4a	7	45	f	f	\N	\N	\N	\N
331	2020-03-07 22:09:41.623908+00	cda09b4c-806e-4ca8-9dc7-9bcf67133e9a.m4a	45	7	f	f	\N	\N	\N	\N
332	2020-03-07 22:20:16.405522+00	2ec55dad-cdad-4266-9f83-047b5590fd2f.m4a	7	45	f	f	\N	\N	\N	\N
333	2020-03-07 22:25:25.41364+00	368bc922-d3b9-4c99-9834-d730be0b000f.m4a	45	7	f	f	\N	\N	\N	\N
334	2020-03-07 22:28:48.453965+00	e9acbe2b-35a0-4f4e-9c8d-5f3edda8e586.m4a	7	45	f	f	\N	\N	\N	\N
335	2020-03-08 00:32:01.011383+00	af2e6f7a-9cb9-4936-935d-cb7a4bed2560.m4a	69	24	f	f	\N	\N	\N	\N
336	2020-03-08 03:19:33.021951+00	a392523e-96a3-4fbf-a846-c92d260c36aa.m4a	87	17	f	f	\N	\N	\N	\N
337	2020-03-08 04:28:46.310275+00	d377cf82-6848-4072-8f8c-319ac29dc050.m4a	81	7	f	f	\N	\N	\N	\N
338	2020-03-08 04:29:39.617338+00	4a6c01f1-8cc4-4595-977b-de0c70c574f8.m4a	7	81	f	f	\N	\N	\N	\N
339	2020-03-08 07:16:22.693875+00	124b0104-fc45-44cd-bfc8-3f626e5e06e7.m4a	17	87	f	f	\N	\N	\N	\N
340	2020-03-08 18:43:13.858342+00	6a343c40-393a-4cbb-be9d-e673c301a6ed.m4a	78	35	f	f	\N	\N	\N	\N
341	2020-03-08 18:43:38.020894+00	64b5f388-fc4b-4f1d-9d53-8720b39bfc79.m4a	78	35	f	f	\N	\N	\N	\N
342	2020-03-08 18:43:57.368247+00	e511fa5d-fb80-4a87-98bf-6941a9561c74.m4a	78	35	f	f	\N	\N	\N	\N
343	2020-03-08 18:44:18.670977+00	6217d39f-0182-4382-ac2d-65111f9b863b.m4a	78	35	f	f	\N	\N	\N	\N
344	2020-03-08 18:44:44.738654+00	f7a85c7f-18b7-4dbf-bb12-0b99a9520665.m4a	78	35	f	f	\N	\N	\N	\N
345	2020-03-08 23:10:05.210501+00	b921b776-a4fa-46e0-9488-65f56efeea9e.m4a	81	7	f	f	\N	\N	\N	\N
346	2020-03-09 00:47:57.657888+00	e0509f9f-ce97-4dd2-9b0b-df5ff8a6701b.m4a	81	7	f	f	\N	\N	\N	\N
347	2020-03-09 00:49:31.402754+00	4ae7ae1c-88f4-42f5-8a96-8c9dd3e26758.m4a	7	81	f	f	\N	\N	\N	\N
348	2020-03-09 00:50:38.728307+00	c3a5c726-063c-4b13-9a56-4bf287084942.m4a	7	45	f	f	\N	\N	\N	\N
349	2020-03-09 00:58:33.574746+00	af21c82e-592f-4cc9-a3e2-416dc69b53fa.m4a	81	7	f	f	\N	\N	\N	\N
350	2020-03-09 00:59:18.290044+00	1665d1b9-c94a-4984-9c90-69835aa7638a.m4a	81	7	f	f	\N	\N	\N	\N
351	2020-03-09 01:00:59.649088+00	ab9166fc-ef4e-4290-a94e-57c3b42ebdc1.m4a	81	7	f	f	\N	\N	\N	\N
352	2020-03-09 01:05:08.163067+00	982ea34a-2247-4708-8cf1-1829220cbf01.m4a	81	7	f	f	\N	\N	\N	\N
353	2020-03-09 01:07:04.392238+00	50e53564-b5dd-45b7-89e6-8abcca9d7327.m4a	81	31	f	f	\N	\N	\N	\N
354	2020-03-09 01:08:33.718085+00	24b0be77-e1d8-4ac6-80c7-f01a8bcbcd07.m4a	7	81	f	f	\N	\N	\N	\N
355	2020-03-09 01:12:40.979486+00	0bae6790-0c91-4b7a-89aa-6f0528aee820.m4a	81	7	f	f	\N	\N	\N	\N
356	2020-03-09 01:13:13.461753+00	347de8c3-b993-48b4-aaff-b3582cd1975f.m4a	81	7	f	f	\N	\N	\N	\N
357	2020-03-09 01:13:25.750028+00	6f1aef3b-8ccd-4df8-b2af-0fa0f45228e9.m4a	81	7	f	f	\N	\N	\N	\N
358	2020-03-09 01:18:51.210142+00	0a71e0a8-bdf9-425f-9944-a272eb4924e5.m4a	7	31	f	f	\N	\N	\N	\N
359	2020-03-09 01:20:16.832612+00	69ddcb38-9a79-48ec-8e7b-ae70c8aa33f8.m4a	81	7	f	f	\N	\N	\N	\N
360	2020-03-09 01:34:43.485568+00	014fb5a1-9a44-462f-971f-86a035b6f68e.m4a	31	81	f	f	\N	\N	\N	\N
361	2020-03-09 01:42:34.60639+00	8d19d0f2-4179-4991-b994-83748f38e298.m4a	7	81	f	f	\N	\N	\N	\N
362	2020-03-09 01:47:51.754826+00	a5de0acd-b9f7-4a01-aab3-7a813bc48d21.m4a	81	7	f	f	\N	\N	\N	\N
363	2020-03-09 01:55:42.047727+00	2b51fb4e-b1de-456f-a5f5-8ff1659f586c.m4a	7	81	f	f	\N	\N	\N	\N
364	2020-03-09 01:55:45.017456+00	3c793786-eeb0-45ac-af94-c7280d819560.m4a	81	56	f	f	\N	\N	\N	\N
365	2020-03-09 01:58:29.528726+00	7a7bffc7-092d-4e69-8ca5-54b1fa519333.m4a	56	81	f	f	\N	\N	\N	\N
366	2020-03-09 02:01:34.773122+00	2ad45413-b254-4a89-a983-a43d46713ee3.m4a	7	81	f	f	\N	\N	\N	\N
367	2020-03-09 02:09:58.857096+00	2af8b99c-1095-4d14-baa1-5b622a0010f2.m4a	81	56	f	f	\N	\N	\N	\N
368	2020-03-09 02:23:59.542959+00	626e230b-c605-4fa8-80d7-484007706d76.m4a	31	7	f	f	\N	\N	\N	\N
369	2020-03-09 02:26:44.028979+00	2239f392-83fe-43ba-944c-049957d48bd5.m4a	81	31	f	f	\N	\N	\N	\N
370	2020-03-09 03:10:54.210129+00	bdd2df8d-a53c-49e4-a474-c9731398dbe9.m4a	45	7	f	f	\N	\N	\N	\N
371	2020-03-09 03:24:48.922931+00	53a15f0b-fbe2-4642-8337-009653064722.m4a	81	31	f	f	\N	\N	\N	\N
372	2020-03-09 03:26:14.545348+00	5ade9ac9-0b05-4b0d-b136-2a26d5b449a7.m4a	81	31	f	f	\N	\N	\N	\N
373	2020-03-09 04:02:53.701368+00	25c8dd30-f8fa-468b-bd40-2b76882e1563.m4a	7	45	f	f	\N	\N	\N	\N
374	2020-03-09 04:03:05.221981+00	87fe4609-cf43-445b-b809-5fa7fb46d99c.m4a	7	81	f	f	\N	\N	\N	\N
375	2020-03-09 14:47:40.614304+00	5aa6948d-089e-49d5-b392-ca87863b35a0.m4a	16	7	f	f	\N	\N	\N	\N
376	2020-03-09 14:55:23.240883+00	5abd5d8d-0466-4a4a-8917-a548cdbacaac.m4a	7	93	f	f	\N	\N	\N	\N
377	2020-03-09 14:58:29.81538+00	00737a9b-077d-45ee-8ce3-739d167e0cbf.m4a	81	31	f	f	\N	\N	\N	\N
378	2020-03-09 15:22:16.461885+00	19d362ec-95b1-4019-a9df-80b7c376c729.m4a	95	7	f	f	\N	\N	\N	\N
379	2020-03-09 15:49:36.773714+00	067bbf16-4d87-4943-a8f9-1df0c4c8f50a.m4a	7	92	f	f	\N	\N	\N	\N
380	2020-03-09 15:52:40.075616+00	dfbf72f9-c2f8-49cc-8d4c-9efc2fdea2c0.m4a	7	96	f	f	\N	\N	\N	\N
381	2020-03-09 16:03:08.665632+00	8b093944-daa8-4087-a525-e378b891f8ed.m4a	97	93	f	f	\N	\N	\N	\N
382	2020-03-09 16:04:41.481747+00	04e09f9a-8283-43a2-a928-90241365fe1a.m4a	98	99	f	f	\N	\N	\N	\N
383	2020-03-09 16:05:24.216732+00	38720c46-875f-40c7-aa26-e74e5b3a2f4a.m4a	93	97	f	f	\N	\N	\N	\N
384	2020-03-09 16:12:36.375423+00	b027382c-9cf5-4288-b0ad-88db61cdf7b8.m4a	7	97	f	f	\N	\N	\N	\N
385	2020-03-09 16:13:09.602141+00	840d32b5-36ca-4a68-8f2f-703db29e7bc0.m4a	7	98	f	f	\N	\N	\N	\N
386	2020-03-09 16:13:32.439131+00	51666de0-bfdd-405e-b52e-036cba80e86c.m4a	7	98	f	f	\N	\N	\N	\N
387	2020-03-09 16:36:30.326208+00	724fa2dc-fdcc-488c-b3df-94820f8c292e.m4a	81	31	f	f	\N	\N	\N	\N
388	2020-03-09 16:41:10.418636+00	78623c63-9ec2-439e-bf3e-3dc8acb09ec6.m4a	101	100	f	f	\N	\N	\N	\N
389	2020-03-09 16:41:29.762716+00	ecebf5dd-0ca9-43ea-9ada-0c27bcd1733b.m4a	101	100	f	f	\N	\N	\N	\N
390	2020-03-09 18:00:14.354946+00	8df922b1-2d48-4509-9a45-bb60e9a1aa7b.m4a	103	7	f	f	\N	\N	\N	\N
391	2020-03-09 18:04:20.738293+00	1ea6e9d6-5ada-4a61-8986-f87134745994.m4a	31	81	f	f	\N	\N	\N	\N
392	2020-03-09 18:04:31.87946+00	b03c1648-5088-466b-906a-12278e6c81c8.m4a	31	81	f	f	\N	\N	\N	\N
393	2020-03-09 18:22:14.920334+00	04405889-f80e-4466-94fc-2b9658ea9a82.m4a	93	98	f	f	\N	\N	\N	\N
394	2020-03-09 18:22:54.863407+00	e9f175e5-a6ab-4c32-b088-63ea00b525b9.m4a	98	93	f	f	\N	\N	\N	\N
395	2020-03-09 19:00:17.277625+00	4d076d88-d399-4802-9cc3-15591c81a9aa.m4a	7	103	f	f	\N	\N	\N	\N
396	2020-03-09 19:12:47.946472+00	2c34f048-1769-417e-9fcb-157155a054da.m4a	107	69	f	f	\N	\N	\N	\N
397	2020-03-09 19:14:40.440104+00	4dc35f3a-8825-4253-8791-2c2ddceac216.m4a	7	107	f	f	\N	\N	\N	\N
398	2020-03-09 19:15:22.547297+00	da51ba87-01dd-4693-be92-9131af9ea54f.m4a	107	7	f	f	\N	\N	\N	\N
399	2020-03-09 19:37:22.367287+00	9581105c-2441-433b-b1e2-5cf7e78e0323.m4a	27	7	f	f	\N	\N	\N	\N
400	2020-03-09 19:38:19.842005+00	30baa561-3458-407c-a115-65d31fd6ed0c.m4a	7	109	f	f	\N	\N	\N	\N
401	2020-03-09 20:52:47.152503+00	5746a24d-ec10-4156-8f1b-ae09f334955f.m4a	40	38	f	f	\N	\N	\N	\N
402	2020-03-09 20:52:51.684502+00	ed3ddfb6-9939-4c33-b040-8feb800e512e.m4a	40	38	f	f	\N	\N	\N	\N
403	2020-03-09 20:52:56.262407+00	264a9ea5-b784-428a-aa11-3ad530f427cf.m4a	40	38	f	f	\N	\N	\N	\N
404	2020-03-09 20:55:40.970441+00	6ec6dff2-b65d-474c-b9a6-c92ca4294713.m4a	40	38	f	f	\N	\N	\N	\N
405	2020-03-09 23:01:17.623856+00	0ea64973-88ff-44f3-b0fa-c314d8d9a6a8.m4a	81	31	f	f	\N	\N	\N	\N
406	2020-03-09 23:25:38.535699+00	7a968369-3b35-45d4-9616-f7059967f397.m4a	97	7	f	f	\N	\N	\N	\N
407	2020-03-10 00:14:49.384988+00	2b09584c-b4d6-4683-afdf-818fe2fd2274.m4a	7	97	f	f	\N	\N	\N	\N
408	2020-03-10 00:15:44.348638+00	5649a523-db3b-4a4e-a298-2c1d41eb040f.m4a	97	7	f	f	\N	\N	\N	\N
409	2020-03-10 00:15:51.62948+00	5fea1cf7-94fc-439f-ae33-8298dcb06642.m4a	97	7	f	f	\N	\N	\N	\N
410	2020-03-10 00:17:07.184341+00	4a14bf0e-c0bc-4219-a257-7b708a869f38.m4a	7	27	f	f	\N	\N	\N	\N
411	2020-03-10 00:17:46.576451+00	205657e2-4e06-489d-8950-73093e67f5d3.m4a	7	27	f	f	\N	\N	\N	\N
412	2020-03-10 00:19:57.909402+00	b0e94803-8034-4109-8b03-07c07ee9ce0c.m4a	7	97	f	f	\N	\N	\N	\N
413	2020-03-10 00:20:57.081856+00	becc4e4b-a937-468f-be67-89c15e8481f0.m4a	7	97	f	f	\N	\N	\N	\N
414	2020-03-10 00:29:33.091462+00	8854429c-0d66-43a6-9281-22b0cf6afbc1.m4a	97	7	f	f	\N	\N	\N	\N
415	2020-03-10 01:57:33.139524+00	db541d35-dfe5-45fc-a3c7-d4dde78459e9.m4a	7	97	f	f	\N	\N	\N	\N
416	2020-03-10 01:58:44.212876+00	df4f7d3c-9d69-4681-94ca-f1bb337b0443.m4a	7	97	f	f	\N	\N	\N	\N
417	2020-03-10 01:59:10.930786+00	78c72a0c-a8ed-48fa-888e-6c2b5fdb086f.m4a	7	97	f	f	\N	\N	\N	\N
418	2020-03-10 02:00:31.177582+00	a2995633-a4f1-47a5-a094-de2b22f62e0f.m4a	7	69	f	f	\N	\N	\N	\N
419	2020-03-10 02:31:51.760326+00	62aec9de-c35b-4cc0-8f2c-04e28993ac75.m4a	81	31	f	f	\N	\N	\N	\N
420	2020-03-10 02:41:19.474286+00	c98e0660-4940-4255-a73c-c91a122aa863.m4a	23	30	f	f	\N	\N	\N	\N
421	2020-03-10 02:45:27.116859+00	7388f75d-d8e2-4f1f-8558-730c11a098a2.m4a	113	23	f	f	\N	\N	\N	\N
422	2020-03-10 02:46:19.490597+00	7b019d68-3fb3-4f59-9b3e-cec180a1846d.m4a	23	30	f	f	\N	\N	\N	\N
423	2020-03-10 02:48:52.044983+00	c41f23d4-cc4c-4682-9a3f-2f311c0c0806.m4a	30	23	f	f	\N	\N	\N	\N
424	2020-03-10 02:49:37.157705+00	f3c0d6e2-30be-4825-b62d-0bc42de7b684.m4a	30	113	f	f	\N	\N	\N	\N
425	2020-03-10 02:49:45.118549+00	7c8e6f9a-9b23-4d85-acf7-bd2504bb38cc.m4a	30	113	f	f	\N	\N	\N	\N
426	2020-03-10 04:02:33.52279+00	56cd9ad4-f9e8-4364-82b0-965d276f3403.m4a	101	107	f	f	\N	\N	\N	\N
427	2020-03-10 04:03:15.377827+00	716fde03-1426-44e6-b6f8-f661ac8f700c.m4a	101	111	f	f	\N	\N	\N	\N
428	2020-03-10 04:27:03.182807+00	fdb8423e-5f24-4bc9-b6b0-94fb145bbb24.m4a	69	53	f	f	\N	\N	\N	\N
429	2020-03-10 04:31:04.309595+00	03125260-73f2-4f69-a4d0-caff19134015.m4a	107	101	f	f	\N	\N	\N	\N
430	2020-03-10 14:46:33.614502+00	dfbde35a-d3d3-444d-948e-8dab442dda2b.m4a	69	7	f	f	\N	\N	\N	\N
431	2020-03-10 14:47:38.955694+00	599f74a5-de4a-4cd4-a325-795a9c85aefb.m4a	69	7	f	f	\N	\N	\N	\N
432	2020-03-10 14:48:55.533821+00	d5e76374-306b-49cf-b93b-02f9aa974f50.m4a	69	107	f	f	\N	\N	\N	\N
433	2020-03-10 14:49:10.998093+00	24eb350c-a5c0-4bdb-86a4-76e89bbbf4de.m4a	69	107	f	f	\N	\N	\N	\N
434	2020-03-10 15:53:02.483714+00	3bcd7fcc-d34f-4b6b-9b7a-00b86b20f988.m4a	40	116	f	f	\N	\N	\N	\N
435	2020-03-10 15:53:15.351323+00	36778eae-c9f5-49c4-a3ce-17cb555c7272.m4a	40	116	f	f	\N	\N	\N	\N
436	2020-03-10 15:53:37.595183+00	75fea2bd-88c0-4bbd-b733-1ab3759edc51.m4a	40	116	f	f	\N	\N	\N	\N
437	2020-03-10 17:20:03.612364+00	6808ac09-0d38-4e21-87f6-ad5561b33cca.m4a	116	40	f	f	\N	\N	\N	\N
438	2020-03-10 17:20:23.754378+00	2cadad57-fb15-4d99-a234-9ab66ca6a05d.m4a	116	40	f	f	\N	\N	\N	\N
439	2020-03-10 17:20:54.744196+00	efe666f9-1e0c-4cc3-aca7-2f30103f46c6.m4a	116	40	f	f	\N	\N	\N	\N
440	2020-03-10 17:44:03.128998+00	236ae1f7-16d1-4261-be3c-a0acf65efb2a.m4a	111	101	f	f	\N	\N	\N	\N
441	2020-03-10 20:00:55.762763+00	be6a2a13-36a3-4040-8c06-ad8a69641c44.m4a	40	116	f	f	\N	\N	\N	\N
442	2020-03-10 20:01:14.304502+00	3fbe7028-0ed6-4077-8af1-33d02267fc45.m4a	40	116	f	f	\N	\N	\N	\N
443	2020-03-10 20:02:38.612402+00	e3efaccc-609c-41f5-bee0-8fbb26d91a50.m4a	40	101	f	f	\N	\N	\N	\N
444	2020-03-10 20:37:20.323553+00	02a3b53e-7946-41dc-a9dc-039adfd18eba.m4a	19	112	f	f	\N	\N	\N	\N
445	2020-03-10 20:38:22.65388+00	78817e8e-a6c4-4f15-a980-a455fd65ec66.m4a	19	112	f	f	\N	\N	\N	\N
446	2020-03-10 20:39:30.296133+00	4c59490a-2ed1-4eb3-aa3a-126f68170cc3.m4a	19	112	f	f	\N	\N	\N	\N
447	2020-03-10 20:54:36.838446+00	b6924ee3-134d-4df4-8f70-b64faecf8ece.m4a	7	69	f	f	\N	\N	\N	\N
448	2020-03-10 20:55:09.805459+00	dbe8d5f4-baea-4907-9ff1-1199d4a29407.m4a	7	69	f	f	\N	\N	\N	\N
449	2020-03-10 20:56:18.124139+00	969d41b9-08be-4378-9c71-c34a71aa66ad.m4a	7	45	f	f	\N	\N	\N	\N
450	2020-03-10 21:13:38.135375+00	21d7443d-758e-4de3-a9a6-5c5ca5a3bcfc.m4a	112	19	f	f	\N	\N	\N	\N
451	2020-03-10 21:19:54.500289+00	b0556698-2606-4f7b-b27d-57bb8c637106.m4a	19	112	f	f	\N	\N	\N	\N
452	2020-03-10 23:11:33.710021+00	d5e79c77-4819-4287-be8e-02701b9e530d.m4a	112	19	f	f	\N	\N	\N	\N
453	2020-03-10 23:13:15.49369+00	78790379-885e-4bb1-873b-8c0724ed0494.m4a	112	19	f	f	\N	\N	\N	\N
454	2020-03-11 00:37:49.484576+00	fa6a9162-99de-4a7f-8ca3-33246322377d.m4a	114	49	f	f	\N	\N	\N	\N
455	2020-03-11 02:28:36.608012+00	a79471ce-ddd8-4169-bfd3-88825b05d3ea.m4a	81	31	f	f	\N	\N	\N	\N
456	2020-03-11 03:03:32.088671+00	b9fbb17f-c242-44fb-ba8f-1912b760a32a.m4a	81	56	f	f	\N	\N	\N	\N
457	2020-03-11 03:04:12.971331+00	ff4d472e-9c98-49db-a8fb-8714fb766269.m4a	81	31	f	f	\N	\N	\N	\N
458	2020-03-11 03:06:03.294212+00	0a92d92b-c6ed-4b42-8165-fa06b9890db0.m4a	81	42	f	f	\N	\N	\N	\N
459	2020-03-11 03:47:58.531742+00	8b1ba07e-4477-4b4e-aa70-8678dd4810bc.m4a	7	116	f	f	\N	\N	\N	\N
460	2020-03-11 03:51:33.206354+00	9462cadd-c8f4-43f5-8433-69a470334fae.m4a	81	104	f	f	\N	\N	\N	\N
461	2020-03-11 03:57:56.086656+00	8bf277eb-f259-432d-a71a-c5790f91db0c.m4a	91	7	f	f	\N	\N	\N	\N
462	2020-03-11 03:58:49.209367+00	55b99b70-9db0-47ed-8044-7d90c3423ff1.m4a	7	91	f	f	\N	\N	\N	\N
463	2020-03-11 03:58:56.709439+00	72a817e4-e591-439c-be36-ba679709f5ab.m4a	91	31	f	f	\N	\N	\N	\N
464	2020-03-11 04:00:06.079251+00	c30a5560-f6fc-4291-a125-1647539dacb0.m4a	91	7	f	f	\N	\N	\N	\N
465	2020-03-11 04:01:16.983177+00	cbd17fc6-22be-47c9-85fa-cddfa675e0c1.m4a	7	91	f	f	\N	\N	\N	\N
466	2020-03-11 04:29:44.133757+00	3483c184-f113-4e53-b669-dbdb26165b68.m4a	91	31	f	f	\N	\N	\N	\N
467	2020-03-13 20:14:04.49822+00	76c9d84c-2cd1-416a-b69c-7fd06a90db0b.m4a	91	31	f	f	\N	\N	\N	\N
468	2020-03-13 21:04:18.756095+00	fef84411-f819-4a93-8dbe-53cd9c04c61e.m4a	49	114	f	f	\N	\N	\N	\N
470	2020-03-15 02:25:52.780719+00	4041fbb5-5070-41b5-97ca-59a75cb215d9.m4a	17	100	f	f	\N	\N	\N	\N
471	2020-03-16 17:13:59.877404+00	decbc1a8-1fde-48b4-9e37-4bf903659268.m4a	122	32	f	f	\N	\N	\N	\N
472	2020-03-19 15:47:26.171747+00	de2103c9-a243-466f-8bc6-470dacf30079.m4a	7	124	f	f	\N	\N	\N	\N
473	2020-03-20 03:14:09.12372+00	8162006e-2c4b-4826-885a-3cf722814436.m4a	7	119	f	f	\N	\N	\N	\N
474	2020-03-20 16:53:13.219534+00	5f682f05-7a86-495d-8175-f90d090cf7a8.m4a	17	68	f	f	\N	\N	\N	\N
475	2020-03-20 16:53:40.503519+00	5d8830ec-85c4-4aee-b160-7357c01ec921.m4a	17	124	f	f	\N	\N	\N	\N
476	2020-03-21 18:11:34.305006+00	bc034830-693c-4412-b0c4-ee6ae813346c.m4a	71	8	f	f	\N	\N	\N	\N
477	2020-03-21 18:33:13.034473+00	4e686ea0-c950-48ff-a109-ab41b6890365.m4a	8	71	f	f	\N	\N	\N	\N
478	2020-03-21 18:33:53.191697+00	99e2b12d-8d45-407c-8b04-ede8d286bc2f.m4a	8	71	f	f	\N	\N	\N	\N
479	2020-03-21 18:51:16.298198+00	abdb42e2-377b-4b15-9d01-a3c8a1fd2df5.m4a	71	8	f	f	\N	\N	\N	\N
480	2020-03-21 19:12:30.174697+00	f1e3b1df-afa6-416d-847f-bc514f906d39.m4a	8	71	f	f	\N	\N	\N	\N
481	2020-03-24 01:39:32.400762+00	09bcb9f5-94ca-431d-88ae-ff6302445088.m4a	71	8	f	f	\N	\N	\N	\N
482	2020-03-24 01:49:50.906749+00	3a7dea6a-83ae-41d8-b8ac-c4a78cd0e48c.m4a	8	71	f	f	\N	\N	\N	\N
483	2020-03-24 01:49:57.937977+00	1e0ff7b2-a982-45c6-92df-e794683b8058.m4a	8	71	f	f	\N	\N	\N	\N
484	2020-03-24 15:21:13.784411+00	9b818388-bd47-4e8a-a340-bf5d19fbfa5f.m4a	126	124	f	f	\N	\N	\N	\N
485	2020-03-25 04:10:19.991076+00	aef9c551-2dcc-4341-b4ae-85e0f159061c.m4a	133	120	f	f	\N	\N	\N	\N
486	2020-03-25 04:10:45.996759+00	21077708-39d0-4a4c-85fe-fc0e197eec90.m4a	133	120	f	f	\N	\N	\N	\N
487	2020-03-25 04:11:07.102483+00	cdfc269c-a43f-411f-8da1-81c4d9234ec4.m4a	133	120	f	f	\N	\N	\N	\N
488	2020-03-25 18:48:51.711253+00	862b4ef5-f789-4ce1-a6e4-c50d5a518e26.m4a	126	133	f	f	\N	\N	\N	\N
489	2020-03-25 19:51:12.201126+00	831df945-8e71-46db-a9a3-558b613af0ad.m4a	126	24	f	f	\N	\N	\N	\N
490	2020-03-26 05:57:49.358551+00	c9f24f0c-e7bf-4413-bc2a-334761bc1e91.m4a	137	127	f	f	\N	\N	\N	\N
491	2020-03-26 05:59:09.807391+00	883dc419-fdd2-4fed-8702-258575712af1.m4a	137	133	f	f	\N	\N	\N	\N
492	2020-03-26 07:20:03.353643+00	e70f10c1-21fe-4a25-a249-040da9455575.m4a	137	127	f	f	\N	\N	\N	\N
493	2020-03-26 07:20:28.749531+00	1aeb88c3-e8cf-48e8-b8e2-872ec7c3ac77.m4a	137	127	f	f	\N	\N	\N	\N
494	2020-03-27 18:24:30.065639+00	efa86da5-1599-4927-8649-2ed22f8cd694.m4a	38	40	f	f	\N	\N	\N	\N
495	2020-03-27 18:24:47.852071+00	83a6b119-b7a2-4254-8aeb-140b88f977be.m4a	38	40	f	f	\N	\N	\N	\N
496	2020-04-18 01:07:39.990272+00	bf5269d4-2229-47b5-8b39-3acda69a06e5.m4a	126	2	f	f	\N	\N	\N	\N
497	2020-04-18 01:16:10.757014+00	d39c3f7a-56b5-4e4a-a2c3-d4a463942975.m4a	126	2	f	f	\N	\N	\N	\N
500	2020-04-21 12:31:34.643639+00	1e75fc68-5a5e-4330-a3e3-52f93b920e12.m4a	141	143	f	f	\N	\N	\N	\N
502	2020-04-24 19:23:19.416609+00	074355e3-886e-4d83-96bd-624fd0cc0b0d.m4a	141	143	f	f		\N	\N	\N
504	2020-04-24 20:15:05.711625+00	73d9705b-f475-4cb3-9a38-02c2cb4c5d8b.m4a	141	143	f	f		\N	\N	\N
507	2020-04-25 20:18:31.783572+00		49	114	f	f	44206145_IMG_1412.PNG	\N	qwer	\N
508	2020-04-25 20:19:56.233445+00	06d4c929-ac1a-4d5f-afe2-1f7014ef6533_313RZPm.m4a	49	114	f	f	44206145_IMG_1412_JDGEcTH.PNG	\N	qwer	\N
509	2020-04-25 21:04:32.750589+00	dabadc96-bfa4-4f9e-9379-88fbd53ac6ed.m4a	141	143	f	f		\N	\N	\N
510	2020-04-27 23:59:14.246178+00	f91bc045-4af8-46b8-8978-7ce460162616.m4a	49	140	f	f		\N	\N	\N
511	2020-04-28 00:14:16.360235+00		141	143	f	f		\N	\N	\N
512	2020-04-28 18:40:57.959202+00		141	143	f	f		\N	\N	\N
498	2020-04-18 19:59:48.62368+00	5a58fa8d-4b90-4cf4-8b5b-be9114290867.m4a	141	142	t	t	\N	\N	\N	\N
514	2020-04-28 18:59:16.474916+00	25537C20-CBBF-4C8C-891A-2BBE6CC43801.png	141	141	f	f		\N	\N	\N
515	2020-04-28 20:34:48.337799+00	6A9F315B-389B-439C-B45F-4A5D8096230A.png	141	141	f	f		\N	\N	\N
516	2020-04-28 20:41:59.1634+00	6FD3E1D6-F146-491F-AF0F-C220A4ECD3DE.png	141	141	f	f		\N	\N	\N
517	2020-04-28 20:49:20.873633+00	092E856E-E9B1-4917-B219-7AD24BA1B4EC.png	141	141	f	f		\N	\N	\N
518	2020-04-28 21:01:53.747505+00	7DE18097-F1A6-4C55-A6A3-A958F59CA78C.png	141	141	f	f		\N	\N	\N
519	2020-04-29 17:45:27.02134+00	5DD90EEB-2DA7-4206-ADE9-D9F02C0A3C3Ajpeg	141	141	f	f		\N	\N	\N
520	2020-04-29 17:46:28.231678+00	2001C054-F6CB-4F64-AE09-86F5A59CABD2jpeg	141	141	f	f		\N	\N	\N
521	2020-04-29 17:48:34.701197+00	30A2B6A6-5C17-42A6-BFA0-05CADEAEAB9Ajpeg	141	141	f	f		\N	\N	\N
523	2020-04-29 18:15:46.62808+00	69C3A927-B17D-46DC-BC56-1BC30D141395.jpeg	141	143	f	f		image	\N	\N
525	2020-04-29 18:37:33.865817+00		141	143	f	f	702DA37A-6030-410B-964F-6F77E576CB3A.jpeg	image	\N	\N
530	2020-04-29 18:57:36.816608+00		141	142	t	t	97A54FD8-5F0B-4BDF-A1C3-7870F705CEC0.jpeg	image	\N	\N
531	2020-04-29 20:41:19.355041+00		141	142	t	t	B1588BE8-D20A-460D-BD33-84713203A152.jpeg	image	\N	\N
532	2020-04-29 20:44:39.835076+00		141	142	t	t	3C4FA774-4C44-4F34-A5F5-B485C610EF90.jpeg	image	\N	\N
529	2020-04-29 18:55:55.75892+00		141	142	t	t	9CB71F5B-4AD6-47A3-8B4A-B8E6ADEC990C.jpeg	image	\N	\N
533	2020-04-30 16:04:30.069064+00		141	142	t	t	91958B38-5B72-48C3-B89C-9EE71B7D06CD.jpeg	image	\N	\N
558	2020-05-12 14:26:13.634155+00		132	127	t	t	9B5E15ED-37D5-4F06-9603-7C10C4163B20.MOV	video	\N	\N
543	2020-05-01 18:18:44.041788+00	22dd1d7b-ad45-4cbf-9dc4-c6cdccc96e87.m4a	132	127	t	t		\N	\N	\N
544	2020-05-01 18:23:02.852802+00	0aba2298-cd00-44b7-b808-065a2c559e08.m4a	132	127	t	t		\N	\N	\N
534	2020-05-01 07:32:33.582812+00		132	6	t	t	622FADD4-34D8-4D15-A8F2-A3CC77D3B035.jpeg	image	\N	\N
545	2020-05-05 15:53:38.898454+00		126	6	t	t	EC4605D7-1D31-4C7A-8C89-1F9ECB9961B5.jpeg	image	\N	\N
535	2020-05-01 08:51:59.356105+00		132	6	t	t	60286BEA-F121-4433-B8AD-1431CA7A2C02.jpeg	image	\N	\N
579	2020-06-07 21:53:19.715443+00		143	\N	t	t	AB10B589-995B-40EB-8A22-E0C798404EE2.jpeg	image	\N	9
536	2020-05-01 09:03:25.463293+00		132	6	t	t	CB7E8AB8-A5B2-4B88-ACE9-EC116560569E.jpeg	image	\N	\N
537	2020-05-01 09:05:33.298348+00		132	127	t	t	25A6B9F4-9AAF-4E3F-9874-B4723D2817CA.jpeg	image	\N	\N
559	2020-05-12 14:50:51.228488+00		132	127	t	t	F4161BC6-7E2B-437E-9AD2-AC2960775D50.MOV	video	\N	\N
539	2020-05-01 11:11:04.675737+00		132	127	t	t	ECEDF7BE-7948-40CA-BE0E-34CF83AAD8B2.MOV	video	\N	\N
546	2020-05-05 15:55:02.835099+00	1670616f-c40e-46b3-b462-14e6458ad826.m4a	126	6	t	t		\N	\N	\N
547	2020-05-05 15:55:23.150247+00		126	6	t	t	71EDF32A-1861-4DDC-962B-0304AE532EE3.jpeg	image	\N	\N
548	2020-05-08 18:16:27.945786+00		132	127	t	t	6700E1A5-6F42-45FC-BEFE-0B8B304FDCFF.jpeg	image	\N	\N
541	2020-05-01 14:45:47.797408+00	e9eaf173-c373-44f3-935a-4090c165682e.m4a	132	132	t	t		\N	\N	\N
549	2020-05-12 05:51:19.21274+00		132	127	t	t	004ABEBC-A823-4813-AE2C-A0299A4383EA.jpeg	image	\N	\N
542	2020-05-01 14:48:16.356573+00	d692b6b3-b7b3-44fb-99ad-2ab41e24890c.m4a	132	127	t	t		\N	\N	\N
550	2020-05-12 06:07:35.253117+00		132	127	t	t	A163DB82-EECE-4B1E-BD11-4DDFD13BE4B4.jpeg	image	\N	\N
594	2020-06-08 08:15:02.372571+00		132	127	f	f	B37E3B68-FF64-43D4-9162-94F7B19B1975.jpeg	image	\N	\N
551	2020-05-12 10:39:24.945491+00		132	127	t	t	341A7015-6F51-4488-9F1E-BB9CE69112EF.jpeg	image	\N	\N
552	2020-05-12 13:34:45.034169+00		132	127	t	t	42ABB60F-5B04-42F8-B3D6-3DA093BE63C1.jpeg	image	\N	\N
561	2020-06-07 19:11:21.054855+00		143	143	t	t	CC380446-60B2-438A-B02C-35258AFBB0D9.jpeg	image	\N	\N
553	2020-05-12 13:42:25.66817+00		132	127	t	t	996A2F98-8583-4188-9D17-6A2520C59EC5.jpeg	image	\N	\N
554	2020-05-12 13:48:47.19893+00		132	127	t	t	5CA13B30-A444-49ED-A042-853AFEA04992.jpeg	image	\N	\N
555	2020-05-12 13:56:35.372325+00		132	127	t	t	9325F7F9-4744-4C3C-9B43-CE7086F273E1.jpeg	image	\N	\N
556	2020-05-12 14:14:36.69769+00		132	127	t	t	40858FB5-7A81-4FDD-8216-A75D715ADD55.jpeg	image	\N	\N
562	2020-06-07 19:14:51.125398+00		143	17	t	t	9BE9EF55-85FC-4E4C-8F3A-EF868460B468.jpeg	image	\N	\N
557	2020-05-12 14:18:47.316266+00		132	127	t	t	83C34B15-69BD-4DEC-9288-C83A43427981.png	image	\N	\N
563	2020-06-07 19:24:30.392529+00		143	\N	f	f		\N	\N	\N
564	2020-06-07 19:30:18.585285+00		143	\N	f	f		\N	\N	\N
565	2020-06-07 20:09:32.818389+00		143	\N	f	f		\N	\N	\N
566	2020-06-07 20:12:11.190837+00		143	\N	f	f		\N	\N	\N
567	2020-06-07 20:23:15.267511+00		143	\N	f	f		\N	\N	\N
568	2020-06-07 20:26:52.155965+00		143	\N	f	f		\N	\N	\N
569	2020-06-07 20:30:06.824377+00		143	\N	f	f		\N	\N	\N
570	2020-06-07 20:33:00.758685+00		143	\N	f	f		\N	\N	\N
571	2020-06-07 20:35:16.579505+00		143	\N	f	f		\N	\N	\N
572	2020-06-07 20:39:13.441738+00		143	\N	f	f		\N	\N	\N
573	2020-06-07 20:45:58.033511+00		143	\N	f	f		\N	\N	\N
574	2020-06-07 20:48:52.939439+00		143	\N	f	f		\N	\N	\N
575	2020-06-07 21:00:59.00911+00		143	17	t	t	54D6354C-7752-4BE2-9212-14ACD7F20FA4.jpeg	image	\N	\N
576	2020-06-07 21:42:49.220145+00		143	17	t	t	0C4C1679-55E4-4A33-BD9C-B1F0419C6791.jpeg	image	\N	\N
577	2020-06-07 21:45:55.617157+00		143	\N	f	f		\N	\N	\N
578	2020-06-07 21:48:35.223439+00		143	\N	f	f		\N	\N	\N
580	2020-06-07 21:57:51.520619+00		143	\N	t	t	AA8F2A83-A4F3-4AA7-9A64-9B5BB78914AD.jpeg	image	\N	15
583	2020-06-07 22:11:28.403604+00		143	\N	t	t	406BFC40-8B2C-451C-B0AA-F7811A939329.jpeg	image	\N	17
585	2020-06-07 22:53:56.415971+00		143	\N	t	t	CDE166DA-E792-412D-8F9C-F546B2EA8863.jpeg	image	\N	17
587	2020-06-07 23:57:40.107773+00		143	144	t	t	0D510E7E-F55C-4FCE-AE9F-B1B2C57346BF.jpeg	image	\N	\N
590	2020-06-08 00:47:21.140373+00		143	\N	t	t	B7847636-5CF2-438F-8EFA-4EB54362EBED.jpeg	image	\N	17
593	2020-06-08 05:38:34.31961+00		143	\N	t	t	8A816572-F74D-49CC-A468-B096110E5544.jpeg	image	\N	16
595	2020-06-08 10:04:12.07855+00	4529b412-7415-4e10-a033-34e236141147.m4a	132	132	t	t		\N	\N	\N
597	2020-06-08 10:49:05.84669+00		143	\N	t	t	DADBF72A-A0E5-4E04-BB8D-1A1903D08014.jpeg	image	\N	18
598	2020-06-08 11:31:18.12355+00		132	\N	t	t	0EA4D879-F181-4E75-96DB-476B53BC2087.jpeg	image	\N	3
624	2020-06-11 14:48:51.681497+00		143	6	t	t	74218D84-1E04-4F09-9AFD-2F7B3649AE00.png	image	\N	\N
599	2020-06-08 12:05:26.20239+00		132	\N	t	t	463EE920-0FD6-4B79-AF14-3736351AF777.jpeg	image	\N	3
600	2020-06-08 12:07:33.294185+00		132	\N	t	t	A92F2B1B-B615-4D17-B057-01A4393D19BB.jpeg	image	\N	3
601	2020-06-08 12:10:01.307026+00		132	\N	t	t	99B44AC9-4774-46FA-BCDA-B001DF36B55B.jpeg	image	\N	3
602	2020-06-08 14:15:00.540514+00		143	\N	t	t	C97D1AA8-A432-464B-8E61-E3F04BE7AE18.png	image	\N	15
603	2020-06-08 14:26:02.228079+00		143	\N	t	t	2F1B6249-62A3-4FBA-9204-8CD2632D6E3F.png	image	\N	19
604	2020-06-08 17:22:57.249914+00		143	\N	t	t	9EB27F1B-7332-4700-A2D1-670D1FA4E60F.png	image	\N	20
605	2020-06-08 17:26:07.332367+00		143	\N	t	t	CB50B53F-9B3E-410B-974E-30943B3921D0.png	image	\N	19
606	2020-06-08 17:27:27.32098+00		143	\N	t	t	D72DE2D0-F143-4799-815F-C54AB78AB28F.png	image	\N	31
607	2020-06-08 17:33:42.77648+00		143	\N	t	t	12CB947E-F7FA-491F-BDD6-AC64CE676A83.png	image	\N	32
608	2020-06-08 17:51:26.798481+00		143	\N	t	t	0C86FC7E-E871-4900-848D-01314D93BBA9.png	image	\N	32
609	2020-06-08 17:53:25.23173+00		143	\N	t	t	80E88CDA-EFCE-4022-A5E6-9569CC443899.png	image	\N	32
610	2020-06-08 17:54:21.244161+00		143	\N	t	t	1303D7CD-B4CB-40A1-A255-63CDED065E48.png	image	\N	31
612	2020-06-10 12:48:00.253067+00		132	6	t	t	96FC52B9-8485-4811-A858-C2052DCE2A9D.jpeg	image	\N	\N
613	2020-06-10 12:56:21.430077+00		132	6	t	t	AA3935F0-3860-4B6F-AF25-CA75D10041AF.jpeg	image	\N	\N
615	2020-06-10 13:07:59.121254+00		143	144	t	t	487FB70E-5A5C-4BA6-8F29-3072D3721B50.jpeg	image	\N	\N
657	2020-06-15 06:11:43.760836+00		143	32	t	t	AE30F26F-9CF5-4D33-8A86-785455274C71.pdf	doc	\N	\N
616	2020-06-10 13:17:53.206711+00		143	144	t	t	9ED2E003-DFF0-48AE-AC2E-7B6BD6777826.png	image	\N	\N
619	2020-06-10 14:06:06.166037+00		143	144	t	t	AFDF4EB1-A32A-4139-9E79-72472EAEBC8B.jpeg	image	\N	\N
621	2020-06-11 06:55:31.711996+00		143	144	t	t	07FD93BA-6C9B-4819-9F78-3D0AC80E9B58.jpeg	image	\N	\N
668	2020-06-15 16:25:26.947084+00	3ac470ba-0dca-4fb0-84aa-4da95e9aa73e.m4a	143	132	t	t		\N	\N	\N
623	2020-06-11 14:39:26.526545+00		143	6	t	t	01970387-2B33-415B-A725-1AF98E361E08.jpeg	image	\N	\N
658	2020-06-15 06:15:15.008966+00		143	32	f	f	0DC3D12C-BB5B-4095-9506-6007227AEA25.pdf	doc	\N	\N
639	2020-06-12 07:29:01.050849+00		143	144	t	t	A5907B24-630E-4543-84C4-1E5E8C7D8931.png	image	\N	\N
642	2020-06-12 08:11:44.335119+00		143	132	t	t	74CC9CFB-615F-43E3-A040-4B39C146F67E.MOV	video	\N	\N
659	2020-06-15 06:18:30.442819+00		143	\N	t	t	F6BF68F8-8DD0-4C08-B1BE-529818C5086B.pdf	doc	\N	31
644	2020-06-12 08:21:44.113125+00		143	144	t	t	6F1F94A0-CBBC-4BFC-9019-148635A8755C.MOV	video	\N	\N
625	2020-06-12 01:35:15.634473+00		143	144	t	t	62FAF77F-5050-437E-8253-C2BF58F4453C.jpeg	image	\N	\N
627	2020-06-12 01:45:55.632846+00	ae91d5ee-ccb9-4d7f-aad1-00d86148608d.m4a	143	144	t	t		\N	\N	\N
626	2020-06-12 01:45:35.981488+00	d1c30a22-94a1-4cb9-8fb3-4e5b69576eef.m4a	143	144	t	t		\N	\N	\N
628	2020-06-12 03:39:45.279758+00		144	143	t	t	1DC29B0F-523C-4AB6-B1A3-EE6FB3550990.jpeg	image	\N	\N
629	2020-06-12 03:52:27.823586+00		144	143	t	t	6D1A5038-7CA8-48A2-B505-1B6C7A85D3C2.jpeg	image	\N	\N
631	2020-06-12 06:20:17.302367+00		132	143	t	t	D5B64640-A91A-4822-90EE-42B79C59C700.MOV	video	\N	\N
660	2020-06-15 13:13:28.977629+00		143	\N	t	t	49838CA6-AAC9-4D4E-854B-2056E404FDCE.pdf	doc	\N	32
640	2020-06-12 07:29:17.856995+00		143	132	t	t	D57BB484-AE86-481D-A505-407D22CFA41A.png	image	\N	\N
650	2020-06-13 10:30:19.632459+00		143	144	t	t	88B1E1A7-8050-49A9-8336-8E1A2A4C9BA9.pdf	doc	\N	\N
651	2020-06-15 02:32:37.724387+00		143	144	t	t	778FF7D0-1C4C-4437-A2E7-57BD8B439C30.pdf	doc	\N	\N
620	2020-06-11 00:22:21.07717+00		143	\N	t	t	A7CCA79E-7D80-4DC0-B39D-C564BDDDE180.png	image	\N	16
653	2020-06-15 05:41:33.462079+00		143	132	t	t	BB285FCE-7A92-40E1-9CBD-F4424D544E00.pdf	doc	\N	\N
654	2020-06-15 05:42:31.691645+00		143	132	t	t	E2EEA5A5-AF01-4B92-9202-5A8E25B4161F.png	image	\N	\N
655	2020-06-15 05:42:37.505841+00		143	132	t	t	54124AB1-2F14-4E27-BE05-ADCB61BB621F.jpeg	image	\N	\N
656	2020-06-15 05:43:24.437295+00		143	132	t	t	7931F713-B3D4-4E77-BB4B-819C749F5016.pdf	doc	\N	\N
662	2020-06-15 13:55:20.723753+00	DB3B7211-9F53-4959-9D04-7267829625F0.m4a	143	132	t	t		\N	\N	\N
630	2020-06-12 06:15:58.263253+00		143	6	t	t	73418990-6F3D-4A1C-BA2A-D7696DF09547.png	image	\N	\N
663	2020-06-15 14:29:40.185135+00	aeaca45f-e540-4b0a-9eee-76aab7976790.m4a	132	143	t	t		\N	\N	\N
669	2020-06-15 18:29:57.853651+00	FC728397-7C34-446D-821F-381DA90BC87D.m4a	143	6	t	t		\N	\N	\N
666	2020-06-15 14:56:51.524393+00	99f7acb6-e4ac-4e82-bd0f-e4489f5f4055.m4a	143	132	t	t		\N	\N	\N
664	2020-06-15 14:33:19.306304+00	FB3B8FCD-5F06-4613-BF74-D8E434351615.m4a	143	144	t	t		\N	\N	\N
665	2020-06-15 14:34:04.735572+00	515FF5C8-2CD0-4E8C-986F-AB77F31152A1.m4a	143	132	t	t		\N	\N	\N
672	2020-06-15 18:54:13.485362+00		143	132	t	t	D589B5A1-C730-4D9B-85D6-6D699198E79C.pdf	doc	\N	\N
671	2020-06-15 18:53:27.227327+00		143	132	t	t	30540AD0-4C64-4347-ACFB-2EFC68150FA5.png	image	\N	\N
678	2020-06-17 07:30:02.734494+00		143	132	t	t	14EE1A72-8288-47EE-9451-B26A0875BDB1.png	image	\N	\N
677	2020-06-17 05:17:56.407568+00		143	132	t	t	2644F664-80AC-460D-BC9F-1AF7D5199CBB.jpeg	image	\N	\N
685	2020-06-17 07:58:54.82003+00		143	144	t	t	B594B0EE-053E-42F2-8881-3AB18B6BBDEC.pdf	doc	\N	\N
724	2020-06-24 10:12:57.427652+00		143	132	t	t	4A7C49DE-DE73-4AB5-83DB-ED15C5F12BB6.pdf	doc	\N	\N
703	2020-06-18 06:04:44.466281+00		143	132	t	t	2A21F3F0-B6A6-421E-A67E-9B45C6965458.png	image	\N	\N
757	2020-07-02 15:58:22.517697+00		143	132	t	t	42F4BEA5-816B-4DCE-AEE9-E5C2C81563F3.jpeg	image	\N	\N
704	2020-06-18 06:20:07.580013+00		143	132	t	t	286DF9CB-F3EE-422A-B86D-271AD2BE3D82.pdf	doc	\N	\N
705	2020-06-18 06:20:44.626193+00		132	143	t	t	6BADD80E-1287-4C4F-91BC-C53C976C49BA.pages	doc	\N	\N
706	2020-06-18 06:22:20.18126+00		132	143	t	t	D9534413-F1AB-473D-93FB-FDE26EFC5006.pages	doc	\N	\N
758	2020-07-03 12:20:44.332083+00		143	144	t	t	1D4617FB-60FC-4A7D-9543-6643043263F9.png	image	\N	\N
806	2020-07-22 11:44:50.850188+00		132	143	f	f	8C609BD7-DFD1-4C6C-9A49-2C4B606E5D6F.jpeg	image	\N	\N
743	2020-06-30 19:04:09.791818+00		146	143	f	f	4C06C1B3-6F09-4679-8E8C-D00A55D38CC0.jpeg	image	\N	\N
807	2020-07-22 17:47:38.525469+00		143	132	f	f	9C32597B-219A-460B-9CE6-87692D626D03.jpeg	image	\N	\N
701	2020-06-18 05:18:55.000119+00		132	143	t	t	E4EFC8D1-51A5-4224-B845-9BEF5483CF74.jpeg	image	\N	\N
728	2020-06-24 22:11:03.082706+00		143	\N	t	t	17C9A94E-4A95-4FBF-9399-B0EC7ADBF346.png	image	\N	38
745	2020-06-30 19:52:25.108503+00		143	144	t	t	161850B6-99C8-4925-A017-8FD8090D6BC5.png	image	\N	\N
714	2020-06-18 08:23:47.037244+00		143	\N	t	t	8EA69154-5AF9-4DC6-8CAF-42361DE7B04C.pdf	doc	\N	37
715	2020-06-18 08:27:22.8874+00		143	\N	t	t	4411C6C6-55C3-483D-ABAA-B20D53997946.pdf	doc	\N	28
746	2020-06-30 19:55:27.033555+00		143	144	t	t	646EE2D7-AA95-42B7-AC13-AB99BA5B9695.png	image	\N	\N
747	2020-06-30 19:58:34.914998+00		143	144	t	t	1A294518-98B1-4A6D-B0B7-32EC083F205E.png	image	\N	\N
748	2020-06-30 20:08:08.478452+00		144	143	t	t	BF2C2E03-41E6-4B9A-9735-F3534A136290.jpeg	image	\N	\N
749	2020-07-01 01:32:22.084198+00		143	144	t	t	CEF67835-A589-468E-87CB-82C0B088DE55.png	image	\N	\N
721	2020-06-24 10:05:47.849865+00		143	132	t	t	93062357-9D16-4D73-A770-7A29C7D32ED5.MOV	video	\N	\N
722	2020-06-24 10:07:35.800317+00		143	132	t	t	C412E3F8-22B5-4ADE-8966-70B96A774E50.png	image	\N	\N
729	2020-06-24 22:11:39.166466+00		143	\N	t	t	0D7F0438-0609-4620-9E83-24C8B438670C.png	image	\N	38
750	2020-07-01 01:35:09.222285+00		143	144	t	t	9CD43210-87A4-493C-83CA-ABCB73BC2D32.png	image	\N	\N
732	2020-06-29 13:19:48.036861+00		143	144	t	t	D53098EF-8CF9-49A7-A2F9-CF38226547D9.png	image	\N	\N
733	2020-06-29 13:21:27.585592+00		143	144	t	t	D92EC524-1AE7-4902-98F0-FAC3AADF0E73.png	image	\N	\N
751	2020-07-01 14:47:16.050901+00		143	144	t	t	25E7D01C-DCA8-4632-8A4E-A86144571D7B.png	image	\N	\N
752	2020-07-01 15:08:21.527461+00		143	144	t	t	11EE783C-8AC7-4D10-B541-F3A1CA29DFE6.png	image	\N	\N
753	2020-07-01 16:09:02.461327+00		144	143	t	t	97AE6224-334D-4F86-BF3D-A9184F25DA1C.png	image	\N	\N
754	2020-07-01 16:11:53.610966+00		144	143	t	t	52CB9908-9F1D-4EA4-88C2-25D2A147835F.png	image	\N	\N
755	2020-07-02 15:36:57.503669+00	887ddb7d-e6d8-4f50-9404-732819d1f57e.m4a	132	143	t	t		\N	\N	\N
808	2020-07-23 04:23:06.375309+00		143	132	f	f	22ECFAB2-92D4-45F1-9A95-BEFD8481EBD0.jpeg	image	\N	\N
756	2020-07-02 15:39:56.02831+00	397e4fc9-71ca-439e-8e81-bf41e198598f.m4a	143	132	t	t		\N	\N	\N
798	2020-07-03 17:50:39.178271+00	46999408-77ee-4d76-8ef4-4f79c24e3ee7.m4a	143	144	t	t		\N	\N	\N
809	2020-07-23 17:31:38.504527+00		132	143	f	f	A24CDF6B-39DC-4D7E-801F-ECE25510E0FA.pdf	doc	\N	\N
770	2020-07-03 14:37:39.190779+00	9d08c47b-d461-4368-b488-212b74f5996d.m4a	132	143	t	t		\N	\N	\N
771	2020-07-03 14:38:05.431705+00	095672eb-54e6-4cdd-9fd6-1578f7a894c3.m4a	132	143	t	t		\N	\N	\N
810	2020-07-23 17:52:02.403136+00		132	143	f	f	849C3838-1A41-4AB2-A791-D3FEB9E1F41A.pdf	doc	\N	\N
777	2020-07-03 14:56:45.630898+00	f692760c-6d11-4ff5-ba90-1bc7c41701d2.m4a	144	143	t	t		\N	\N	\N
769	2020-07-03 14:37:04.34094+00	ce013b1d-be44-4894-9b43-60a3cb538139.m4a	132	143	t	t		\N	\N	\N
795	2020-07-03 17:50:03.123004+00	1bf43b58-c000-4aef-882f-0ba39b3f4731.m4a	144	143	t	t		\N	\N	\N
796	2020-07-03 17:50:07.948759+00	2d8b33e3-623d-41e9-9940-cb1bfbfd80fc.m4a	143	144	t	t		\N	\N	\N
783	2020-07-03 15:45:58.803201+00	0fe41d5f-d290-4e5d-a4fb-f0eb27841f2d.m4a	143	144	t	t		\N	\N	\N
797	2020-07-03 17:50:36.292712+00	656b6f4e-737e-4339-8552-e9b53e04509d.m4a	144	143	t	t		\N	\N	\N
799	2020-07-03 18:36:20.642999+00	733fd43f-5a6c-468b-9796-f33b462fe793.m4a	132	142	t	t		\N	\N	\N
800	2020-07-04 02:04:53.177947+00		132	147	t	t	5DB5D64F-FB76-472B-B76D-9C4DDC4FFC33.png	image	\N	\N
788	2020-07-03 16:03:54.169521+00	7404c191-8893-4f36-bc86-33b2f1408b7b.m4a	143	144	t	t		\N	\N	\N
801	2020-07-07 14:18:39.314232+00		132	143	t	t	A578BEE5-AB3C-4D79-BA75-C29F548F01CE.jpeg	image	\N	\N
802	2020-07-14 03:49:43.410219+00	0c846528-32e0-409e-8c3b-b895451f8eda.m4a	132	131	t	t		\N	\N	\N
803	2020-07-14 14:49:53.969729+00		143	132	t	t	F95CA27A-96B7-4C93-AB1E-A65E217D1E3F.jpeg	image	\N	\N
811	2020-07-23 18:08:51.983747+00		132	143	f	f	744A458C-3E93-4EBA-9BC0-A5C891E57CA3.pdf	doc	\N	\N
812	2020-07-23 18:10:43.369441+00		132	143	f	f	DC27516D-8939-4D67-8731-AA9962C502B5.pdf	doc	\N	\N
813	2020-07-23 18:17:04.395896+00		132	143	f	f	3D735F62-2B67-44AB-9C5C-ABD5800A55D0.jpeg	image	\N	\N
804	2020-07-14 15:15:17.346894+00		132	143	t	t	7D02F1C5-A377-4820-B52A-9908899532A1.png	image	\N	\N
805	2020-07-22 11:39:10.059832+00		143	132	f	f	9DEA11D1-E43F-48C3-86F9-7FB05549A030.jpeg	image	\N	\N
814	2020-07-23 18:19:23.739831+00		132	143	f	f	CDEB01F0-BE63-4953-B71E-E89F7D47965E.pdf	doc	\N	\N
815	2020-07-23 18:26:17.989248+00		132	143	f	f	CA19E3BB-53B1-4B20-A360-40C04BEBC30A.pages	doc	\N	\N
\.


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: weaveuser
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
21	Can add Token	6	add_token
22	Can change Token	6	change_token
23	Can delete Token	6	delete_token
24	Can view Token	6	view_token
25	Can add user	7	add_customuser
26	Can change user	7	change_customuser
27	Can delete user	7	delete_customuser
28	Can view user	7	view_customuser
29	Can add OTP Token	8	add_phonetoken
30	Can change OTP Token	8	change_phonetoken
31	Can delete OTP Token	8	delete_phonetoken
32	Can view OTP Token	8	view_phonetoken
33	Can add voice message	9	add_voicemessage
34	Can change voice message	9	change_voicemessage
35	Can delete voice message	9	delete_voicemessage
36	Can view voice message	9	view_voicemessage
37	Can add Friendship Request	10	add_friendshiprequest
38	Can change Friendship Request	10	change_friendshiprequest
39	Can delete Friendship Request	10	delete_friendshiprequest
40	Can view Friendship Request	10	view_friendshiprequest
41	Can add Friend	11	add_friend
42	Can change Friend	11	change_friend
43	Can delete Friend	11	delete_friend
44	Can view Friend	11	view_friend
45	Can add like message	12	add_likemessage
46	Can change like message	12	change_likemessage
47	Can delete like message	12	delete_likemessage
48	Can view like message	12	view_likemessage
49	Can add APNS device	13	add_apnsdevice
50	Can change APNS device	13	change_apnsdevice
51	Can delete APNS device	13	delete_apnsdevice
52	Can view APNS device	13	view_apnsdevice
53	Can add GCM device	14	add_gcmdevice
54	Can change GCM device	14	change_gcmdevice
55	Can delete GCM device	14	delete_gcmdevice
56	Can view GCM device	14	view_gcmdevice
57	Can add WNS device	15	add_wnsdevice
58	Can change WNS device	15	change_wnsdevice
59	Can delete WNS device	15	delete_wnsdevice
60	Can view WNS device	15	view_wnsdevice
61	Can add WebPush device	16	add_webpushdevice
62	Can change WebPush device	16	change_webpushdevice
63	Can delete WebPush device	16	delete_webpushdevice
64	Can view WebPush device	16	view_webpushdevice
65	Can add call info	17	add_callinfo
66	Can change call info	17	change_callinfo
67	Can delete call info	17	delete_callinfo
68	Can view call info	17	view_callinfo
69	Can add group	18	add_group
70	Can change group	18	change_group
71	Can delete group	18	delete_group
72	Can view group	18	view_group
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.authtoken_token (key, created, user_id) FROM stdin;
5e835f39823ca750e19098cdf6b027722a41029a	2019-12-23 17:39:57.218666+00	2
8a3620625f034d068b329dc015852d80b5eb39f4	2019-12-24 03:03:22.933072+00	3
0bfb6e53c32757a62d147d82e5bdba6cab067146	2020-01-07 16:29:55.425876+00	1
fa03c9216f732b61740ca9b2acd624a4f5a8a5b3	2020-02-01 20:15:43.427296+00	6
71504618b506ba00effdac967b0b7b12365c6417	2020-02-07 15:52:49.090101+00	7
dd93e2a714459d27ed48736d1c70655b561f90a2	2020-02-07 19:45:25.58597+00	8
324daaafd1472cac49ae26c991eebad751242b02	2020-02-17 19:01:27.698047+00	10
7bfbddd04782d1b1fbfcee35124ff5436a6ce70f	2020-02-19 18:26:38.799171+00	11
4a4624913a9796844b7e922c34d2d9224cda881b	2020-02-21 14:08:01.931267+00	12
691295d58acca1d24942a21117576a4768b4a1c9	2020-02-26 05:53:18.346425+00	13
c3378eaade82dd0bdc2ed5d825f0c520e7ba9cca	2020-02-26 12:16:26.498219+00	14
3858fbe700adc1f043478379b4a8671530b4ac2f	2020-03-02 23:26:10.142336+00	15
6e715074d8a4cf3c55a380eea562cccf4b23c64d	2020-03-02 23:33:17.825524+00	16
537d76b5ff942e482e8f8954fa3ede8e3f7d2078	2020-03-02 23:39:18.586528+00	17
a106f1e4387f1948a0c564adbb3e34028cbbb644	2020-03-02 23:40:58.806341+00	18
4f39728da90c40c63aebcc627c5ea55ee4e13678	2020-03-02 23:45:40.301466+00	19
6a4f192f6d8be6fe55f4ed11cf20df82ed8cefec	2020-03-02 23:47:06.229656+00	20
75fb1de65af298da3bd8534c10a80ac11b8ef4fc	2020-03-02 23:49:00.182359+00	21
5b82a234a059bb02ed3039c82273d43e7809ec70	2020-03-02 23:49:31.41973+00	22
dab757c4cb89b7d3fe49761282ead2ae432819e4	2020-03-03 00:35:36.388084+00	23
54373c8823324e8bc4688c8dc7e7c7a52fb4f385	2020-03-03 00:46:02.884232+00	24
95f6a19c27065f2510dc2b4eebdefd2f6c9c7c4a	2020-03-03 01:09:46.106711+00	25
f87ae158552c91cd95fb6d16fa22842ab70ad8ed	2020-03-03 01:27:52.201727+00	26
1232026ebe59c304951ee5a9a72d99a79b3ef712	2020-03-03 01:44:16.784575+00	27
3a14f32f2be26b3d69781277b26804127b456ff8	2020-03-03 01:58:49.48165+00	28
1e1ceb22b2a4236f70029588254822cacf61d76c	2020-03-03 01:59:14.845325+00	29
6dd9da2a8e53309587f833bb3c30036b64db933f	2020-03-03 02:35:09.351283+00	30
0fa7563eace60ab5b1843637245e701be338c3fd	2020-03-03 02:54:59.379045+00	31
785463c7199dd8439cf9c4f1156e9d34662ceb5e	2020-03-03 02:59:23.547083+00	32
df9bff2d06f1b236630bc89a33111f9176ad4123	2020-03-03 06:50:32.011911+00	33
a28263c9ce0be6914df29641722fa109711e6143	2020-03-03 09:26:42.423905+00	34
18adcf14f1fdb974da67457335603d85e085a900	2020-03-03 12:00:19.585269+00	35
9c16d395461e7e2750c1cda6bcd681fd3a9cd3eb	2020-03-03 12:51:38.588856+00	36
70ed453c27f995d4a2b7504db5fa12a0f2ec4cc5	2020-03-03 13:04:02.504394+00	37
a0dbe7ee7688402938d834e2842711201ff8793b	2020-03-03 13:29:17.61162+00	38
0ce0b36ef62a5253a4f3374c4d3d434673fc8f1c	2020-03-03 14:01:47.12895+00	39
1255a135595adf7f8dd0e9e85088c8efeb34aca0	2020-03-03 14:02:44.661401+00	40
c09e0ad1800581e66db5e88086573d256a148bcc	2020-03-03 15:36:47.385004+00	41
6880fb17b67c3d444f6248a1427aaefb10bed622	2020-03-03 16:56:25.055108+00	42
c6f362ebe6f7c26dfcb1fe6b96b3c600515211d5	2020-03-03 17:31:00.724972+00	43
7fbda4010e4492fe3f21a17df3be25356efce41f	2020-03-03 18:12:19.236416+00	44
c256c3a41d79c2fdf8d8634501851612804f5a2f	2020-03-03 18:23:16.280437+00	45
b996d2c74ffd228d97d123ece2243c1dc3bfd17f	2020-03-03 21:19:22.472307+00	46
fcf658545b10a476091e4f84697faf3a5d9b6288	2020-03-03 21:57:32.523522+00	47
2d1c7d292b0c42debfa115ae9774451518bd8e0e	2020-03-03 23:17:38.05159+00	48
007058560db7f1cb093e496c7716298a9cc9f3fe	2020-03-04 00:07:23.05528+00	49
684404f9f6227d7ddbe251d1658c6e25fe2b2472	2020-03-04 00:10:49.349731+00	50
84c80f5317e41c331ec9c7badd4e5b3cfb8317d5	2020-03-04 00:25:05.521609+00	51
f6f6bee7038519358007282769e91338c920ccfe	2020-03-04 00:39:55.074144+00	52
5d468d91a495fc4dae60d1de48d455a83630edc4	2020-03-04 00:40:49.018257+00	53
78c2583d596a774a545e7a864ece1b99d41e89b1	2020-03-04 04:29:19.310956+00	54
3f7ff2ef6cf72dd2d559be11589a5e33196cd675	2020-03-04 15:04:22.979178+00	55
13421c5fe0edff70e4939d73655cf5e83fffadc3	2020-03-04 15:06:39.440668+00	56
453386c6644414a550be15fe9b6cfee4163f756e	2020-03-04 17:42:29.035267+00	57
f655462d5284e7db2f65a49e4b50a920be6e5805	2020-03-04 19:43:03.43138+00	58
ddd5296f325772083383fedb09c12774caa6b997	2020-03-04 20:28:50.822817+00	59
aa5117807cc9842496e881ec0b6b62c63c0c9f9e	2020-03-05 00:49:21.251652+00	60
e975f72c1e983bf7de7bda650f6bde9e4a86533a	2020-03-05 01:11:30.451702+00	61
ced7ef45d9e5fd2952b99d89b8fb9f8058a86a7d	2020-03-05 01:19:16.550451+00	62
1eca26f5ad9dc3d476c5f3ae236fa419a0cd3879	2020-03-05 01:59:35.974631+00	63
4eee2e13219a2b013e1f58bb75c76bafb11669a7	2020-03-05 02:19:28.906659+00	64
433a424c401414a1ea64a4d0f8513bd440fa3c85	2020-03-05 02:57:08.63692+00	65
b0ffd821d00df728c1ccf426cd3e5cca799a7476	2020-03-05 03:32:10.197733+00	66
c92aa5c35439af5f70ea9ceb935abd3a94ec94c2	2020-03-05 14:15:52.914456+00	67
e6c46520325d1619b03cbb04ab7712d114d2528f	2020-03-05 15:22:35.490739+00	68
ca456ddcf0f165524a15c113df973be519262d49	2020-03-05 20:57:57.044071+00	69
56877daa59a671a9d39d2e86be6480f19f60be48	2020-03-05 22:49:28.009868+00	70
333edb11a7621664004b11b3007ab17624e95847	2020-03-06 01:40:24.519513+00	71
581bd97ac877042267ebe9e07415deec4abb6073	2020-03-06 02:12:02.346583+00	72
68a2836fa6bdc917639875762f3a8661e3e403b7	2020-03-06 03:56:03.884546+00	73
d4efc499da4958670b43d143bd507a928305d5f5	2020-03-06 15:57:10.620352+00	74
686a8a5b18d250b1c8c540f389b0b6265d42f6e7	2020-03-06 16:09:11.195434+00	75
39d60780d17194b6a0901bed86eb52f06d00da59	2020-03-06 18:24:50.057986+00	76
72ac6c6fef6e50692782f4bb2f74e92d7552fb2a	2020-03-06 19:15:50.687485+00	77
b9acdd7ae27fea1c295736a59d1e1948ddda34d7	2020-03-06 19:27:11.604977+00	78
4d76b97357feaa9816e4233f0576b069c96d7ec7	2020-03-06 21:54:52.887561+00	79
53d0e68bc87ec38d3c2f6bc8172ffb296cb4b928	2020-03-06 23:33:45.599335+00	80
da8bb30c2f1955b5884457818f45b9c1c6f585dd	2020-03-07 01:23:16.539489+00	81
35608fc8c9808e0ad59394a232a92e61303846df	2020-03-07 06:01:17.0187+00	82
60c0b9deaae4e0e1f962acb8523f3bda59f9bf87	2020-03-07 07:59:14.28329+00	83
ae836540ae0f8ecccaf8dc2fe0342fa77c2e2f44	2020-03-07 16:26:28.605648+00	84
0b0b243dbf0c3ce38a99b247395d3c819612ec34	2020-03-07 16:33:15.283786+00	85
c374d9e62a7440113bc593a3a14dfd95940a542d	2020-03-08 00:25:01.047146+00	86
d2259a30ad7684089ddd773c2aed619e94bd436b	2020-03-08 03:08:42.652546+00	87
048b39953f181dcada9315c44b2f4d44078e7315	2020-03-08 07:39:31.466582+00	88
5663b669a7e7bda7b3fad0b33a6adcd36fe1e006	2020-03-09 03:15:38.607126+00	89
3dc0e6cf4fdb7e95f55a0b9e18e2077fc2879f7c	2020-03-09 14:37:01.667827+00	92
295bf6505321f60658957890f045909572b034d2	2020-03-09 14:52:45.885584+00	93
109b17e3674a6d1146727d45fa8f40816f024c76	2020-03-09 15:12:50.677153+00	94
9db0001595dd4b719c799d44a0d15f7da9138155	2020-03-09 15:20:31.285603+00	95
1e2d6d3e92b690cc9dd54bd2e4578e30f54bea10	2020-03-09 15:47:23.425209+00	96
d0f812588c362c4873097e3189d355ca297f4d34	2020-03-09 16:01:38.775772+00	97
01f9b857629a4b0376ac162da590e4e7d21f1582	2020-03-09 16:02:12.52228+00	98
6d25875861c128053f915b9c1653a683240b5710	2020-03-09 16:02:50.265546+00	99
e7627bb2d5c7a5ab3805eb4a281acde88741da76	2020-03-09 16:38:53.500391+00	100
9e428845b46de3099e6b108c3ecb53f656196add	2020-03-09 16:39:34.459875+00	101
21a74ef252d064ac6b73f3646886df70a4dcf65d	2020-03-09 17:49:21.88151+00	102
3e612c2f7650161e1f1adfad468278a1462d733f	2020-03-09 17:57:04.376605+00	103
1b58def4e2defe397ae883ebcad5bb1533917a85	2020-03-09 18:24:02.219051+00	104
64d20d68c13d5416de0ee8a60fa387636043944c	2020-03-09 18:38:22.422841+00	105
c7db201e87635d0c2cb24519efd255237163f790	2020-03-09 18:49:25.6159+00	106
e80337b3908f082d9e1e3e25bbfe1f2b34285339	2020-03-09 19:06:17.52176+00	107
d2524dad933d7ee31d535629bab2b80d4ff5cd41	2020-03-09 19:28:45.081664+00	108
4ac539ec65bc49b795d4d744f3f0a54c7d5ecba2	2020-03-09 19:30:44.9149+00	109
f4e939a35b71bb194e55ed7f674858952045c980	2020-03-09 19:49:41.408227+00	110
c894abe0a6f4e0f169c180a839788f9016653236	2020-03-09 21:23:54.463447+00	111
167ef2606ba207fbbddb75b7a41490605e137eb2	2020-03-09 23:22:28.095394+00	112
54132aa012fe14208cea1bc0418a10b8356e3d60	2020-03-10 02:39:09.735042+00	113
ec031cc54b064d2bd31e15ca7b3152b4214901f9	2020-03-10 04:19:28.323675+00	114
e911525b8105758791dc4249a26a50e23691f0b0	2020-03-10 07:24:03.546533+00	115
bc2bb1e1d6fae75e70d4db3c7f98c511007d2800	2020-03-10 12:43:24.940807+00	116
bdfb1b9c091c42fd922004d25a569e0e1af19093	2020-03-10 13:55:01.46305+00	117
74999e0145e9a4c67b02114f248158c70196b1b5	2020-03-11 03:56:28.766202+00	91
174fb3d806e382ff0c8a8b9af920257822466d10	2020-03-11 04:49:19.906799+00	118
b83026c511e07ed5417b51ce68c32a7bdb97d99c	2020-03-11 09:19:41.263797+00	119
a00b998cfe141dd8244762ae48239957b524a5d2	2020-03-12 06:04:11.404807+00	120
499b6395a738ac455892f6fff9f1df8f986aea34	2020-03-13 05:58:48.183169+00	121
ed70dd4ae604594cae032e800760c93fca921798	2020-03-16 17:11:06.141496+00	122
5f345314666aed43cc4d1b173d8cd6e3d07f916e	2020-03-18 02:08:05.43475+00	123
749581716895c1964001f1c4c8c1731feee03659	2020-03-18 10:32:26.433316+00	124
b50a48854846782b2b81312861db976601b75d1e	2020-03-19 02:53:12.0056+00	125
e1df1a7c8f35fbe3fe941dea7cbe1f1891e312f4	2020-03-19 20:09:08.986654+00	126
100d1dfd3f3a43f485cf69afaf611fc60a2bbbd7	2020-03-19 20:20:24.553485+00	127
3fbceda506645bb4f0820a9b49bd47fcc5137764	2020-03-22 04:03:28.268594+00	128
bf553dc0ecd24e40c064a482744dd632dcd9f338	2020-03-23 03:37:34.742854+00	129
e30dcd39d663609182170291ed6dd347ff93a4a0	2020-03-23 09:20:13.738418+00	130
912582b9318638a951072e8ec4a9fc8c96f9f9d3	2020-03-24 05:57:30.696529+00	131
904bb84a8c1237d881fd4f6ab97f9548c68339e6	2020-03-24 07:03:55.697877+00	132
83e7f74ccfcd648feff60a426f9fbb1bc6b95e5c	2020-03-24 13:51:29.422273+00	133
bac0f5ad198ff6ad48d2a098b6fb6b6050447c53	2020-03-24 17:08:26.133843+00	134
2144e15247a7feaf821b0a4f9bfddcf280203bb0	2020-03-25 04:49:02.964298+00	135
14f11be4405b7240148e987f3d77dcbac9b66ead	2020-03-25 18:38:22.285709+00	136
f744e38446a33f7cf7590b324caf0dd4dca1eeda	2020-03-26 04:50:17.38421+00	137
93a5c1af7f96095cfba4ec5422573e17c556071c	2020-03-28 13:38:41.102328+00	138
fb885d2e041f1cd7bb57bfd9653d28477fab2213	2020-03-31 15:59:49.141586+00	139
42df25f33401bf2220856686d143a55c2f095b98	2020-04-10 15:14:17.553401+00	140
1af6efca149e6d64ea7455606fb8804b8c0ce5cb	2020-04-18 19:49:39.086758+00	141
e0c2b3f0137081dc21bc6f5262ecc4067cff5742	2020-04-18 19:56:25.20285+00	142
3b1ca99c95f05e5578dca6f74add336c8abbb597	2020-04-21 07:32:54.013272+00	143
788255d493a8531d62f3e0b4f4d29729ae185dc1	2020-04-24 09:31:54.509527+00	144
a2d42e5d67094b2c6ec68d7b852745d7166f2fc0	2020-04-27 18:30:06.247609+00	145
7eace5f014dfce350de1a11daf68061b6917183a	2020-06-30 18:40:46.5065+00	146
3e9de23d5116ae83ca5c5ba129d9548fe3c3c1c0	2020-07-02 16:04:22.839604+00	147
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2019-12-23 17:41:26.308519+00	1	longx695	2	[{"changed": {"fields": ["full_name", "dob", "address", "location", "is_location", "photo"]}}]	7	1
2	2019-12-24 03:25:43.225728+00	2	513a3006-e96c-4be8-9bca-25b46d99d5dc	2	[{"changed": {"fields": ["address", "location"]}}]	7	1
3	2019-12-24 03:26:09.805875+00	2	513a3006-e96c-4be8-9bca-25b46d99d5dc	2	[{"changed": {"fields": ["is_location"]}}]	7	1
4	2020-01-08 19:02:47.760524+00	1	longx695	2	[{"changed": {"fields": ["location", "is_location"]}}]	7	1
5	2020-01-08 19:08:26.173376+00	1	longx695	2	[{"changed": {"fields": ["is_location"]}}]	7	1
6	2020-01-08 19:08:26.950446+00	1	longx695	2	[]	7	1
7	2020-01-08 19:08:47.432597+00	1	longx695	2	[{"changed": {"fields": ["is_location"]}}]	7	1
8	2020-01-08 19:09:35.943008+00	1	longx695	2	[{"changed": {"fields": ["is_location"]}}]	7	1
9	2020-01-09 19:46:26.508115+00	3	d7cdd263-a715-4c7c-9452-5e3f9af28459	2	[{"changed": {"fields": ["address", "location"]}}]	7	1
10	2020-01-09 19:48:42.144659+00	3	d7cdd263-a715-4c7c-9452-5e3f9af28459	2	[{"changed": {"fields": ["location"]}}]	7	1
11	2020-01-09 19:51:37.412195+00	3	d7cdd263-a715-4c7c-9452-5e3f9af28459	2	[{"changed": {"fields": ["location"]}}]	7	1
12	2020-01-14 10:04:51.287247+00	2	User #2 is friends with #1	3		11	1
13	2020-01-14 10:04:51.291531+00	1	User #1 is friends with #2	3		11	1
14	2020-01-14 10:06:39.716736+00	6	User #3 is friends with #2	3		11	1
15	2020-01-14 10:06:39.72147+00	5	User #2 is friends with #3	3		11	1
16	2020-01-14 10:06:39.726867+00	4	User #3 is friends with #1	3		11	1
17	2020-01-14 10:06:39.729306+00	3	User #1 is friends with #3	3		11	1
18	2020-01-15 16:24:02.369833+00	7	1	3		10	1
19	2020-01-15 16:28:07.499356+00	10	User #1 is friends with #3	3		11	1
20	2020-01-15 16:28:07.504333+00	9	User #3 is friends with #1	3		11	1
21	2020-01-15 16:28:07.507082+00	8	User #2 is friends with #1	3		11	1
22	2020-01-15 16:28:07.50952+00	7	User #1 is friends with #2	3		11	1
23	2020-01-31 04:58:01.507855+00	44	VoiceMessage object (44)	3		9	1
24	2020-01-31 04:58:01.513111+00	43	VoiceMessage object (43)	3		9	1
25	2020-01-31 04:58:01.515614+00	42	VoiceMessage object (42)	3		9	1
26	2020-01-31 04:58:01.518105+00	41	VoiceMessage object (41)	3		9	1
27	2020-01-31 04:58:01.520583+00	40	VoiceMessage object (40)	3		9	1
28	2020-01-31 04:58:01.523129+00	39	VoiceMessage object (39)	3		9	1
29	2020-01-31 04:58:01.525912+00	38	VoiceMessage object (38)	3		9	1
30	2020-01-31 04:58:01.528228+00	37	VoiceMessage object (37)	3		9	1
31	2020-01-31 04:58:01.530559+00	36	VoiceMessage object (36)	3		9	1
32	2020-01-31 04:58:01.532999+00	35	VoiceMessage object (35)	3		9	1
33	2020-01-31 04:58:01.535365+00	34	VoiceMessage object (34)	3		9	1
34	2020-01-31 04:58:01.537484+00	33	VoiceMessage object (33)	3		9	1
35	2020-01-31 04:58:01.539661+00	32	VoiceMessage object (32)	3		9	1
36	2020-01-31 04:58:01.541595+00	31	VoiceMessage object (31)	3		9	1
37	2020-01-31 04:58:01.543855+00	30	VoiceMessage object (30)	3		9	1
38	2020-01-31 04:58:01.54598+00	29	VoiceMessage object (29)	3		9	1
39	2020-01-31 04:58:01.548146+00	28	VoiceMessage object (28)	3		9	1
40	2020-01-31 04:58:01.550445+00	27	VoiceMessage object (27)	3		9	1
41	2020-01-31 04:58:01.552582+00	26	VoiceMessage object (26)	3		9	1
42	2020-01-31 04:58:01.554571+00	25	VoiceMessage object (25)	3		9	1
43	2020-01-31 04:58:01.557083+00	24	VoiceMessage object (24)	3		9	1
44	2020-01-31 04:58:01.559426+00	23	VoiceMessage object (23)	3		9	1
45	2020-01-31 04:58:01.561656+00	22	VoiceMessage object (22)	3		9	1
46	2020-01-31 04:58:01.563994+00	21	VoiceMessage object (21)	3		9	1
47	2020-01-31 04:58:01.568126+00	20	VoiceMessage object (20)	3		9	1
48	2020-01-31 04:58:01.571376+00	19	VoiceMessage object (19)	3		9	1
49	2020-01-31 04:58:01.573865+00	18	VoiceMessage object (18)	3		9	1
50	2020-01-31 04:58:01.576763+00	17	VoiceMessage object (17)	3		9	1
51	2020-01-31 04:58:01.578789+00	16	VoiceMessage object (16)	3		9	1
52	2020-01-31 04:58:01.581434+00	15	VoiceMessage object (15)	3		9	1
53	2020-01-31 04:58:01.583751+00	14	VoiceMessage object (14)	3		9	1
54	2020-01-31 04:58:01.586321+00	13	VoiceMessage object (13)	3		9	1
55	2020-01-31 04:58:01.58892+00	12	VoiceMessage object (12)	3		9	1
56	2020-01-31 04:58:01.592106+00	11	VoiceMessage object (11)	3		9	1
57	2020-01-31 04:58:01.597968+00	10	VoiceMessage object (10)	3		9	1
58	2020-01-31 04:58:01.601275+00	9	VoiceMessage object (9)	3		9	1
59	2020-01-31 04:58:01.605439+00	8	VoiceMessage object (8)	3		9	1
60	2020-01-31 04:58:01.615048+00	7	VoiceMessage object (7)	3		9	1
61	2020-01-31 04:58:01.618138+00	6	VoiceMessage object (6)	3		9	1
62	2020-01-31 04:58:01.620109+00	5	VoiceMessage object (5)	3		9	1
63	2020-01-31 04:58:01.6223+00	4	VoiceMessage object (4)	3		9	1
64	2020-01-31 04:58:01.624509+00	3	VoiceMessage object (3)	3		9	1
65	2020-01-31 04:58:01.626797+00	2	VoiceMessage object (2)	3		9	1
66	2020-01-31 04:58:01.629152+00	1	VoiceMessage object (1)	3		9	1
67	2020-01-31 17:57:36.345056+00	2	513a3006-e96c-4be8-9bca-25b46d99d5dc	2	[{"changed": {"fields": ["location"]}}]	7	1
68	2020-02-01 20:21:09.143545+00	1	longx695	2	[{"changed": {"fields": ["location"]}}]	7	1
69	2020-02-03 02:07:37.014008+00	4	David	3		13	1
70	2020-02-03 02:26:52.431047+00	53	+14387942375 - 7297	2	[{"changed": {"fields": ["used"]}}]	8	1
71	2020-02-03 02:53:17.015084+00	53	+14387942375 - 7297	2	[{"changed": {"fields": ["used"]}}]	8	1
72	2020-02-04 01:44:47.785979+00	26	User	3		13	1
73	2020-02-04 01:44:47.790063+00	25	Test User	3		13	1
74	2020-02-04 02:36:20.162497+00	28	Test User	3		13	1
75	2020-02-04 02:40:22.842874+00	22	Test User	3		13	1
76	2020-02-04 02:40:22.847629+00	5	Test User	3		13	1
77	2020-02-04 02:40:22.850438+00	2	Test User	3		13	1
78	2020-02-04 02:40:22.853388+00	1	Test User	3		13	1
79	2020-02-04 02:41:34.232939+00	21	User	3		13	1
80	2020-02-04 02:41:34.236974+00	20	User	3		13	1
81	2020-02-04 02:41:34.239518+00	19	Admin User	3		13	1
82	2020-02-04 02:41:34.241842+00	18	User	3		13	1
83	2020-02-04 02:41:34.244169+00	17	Admin User	3		13	1
84	2020-02-04 02:41:34.24698+00	16	User	3		13	1
85	2020-02-04 02:41:34.249482+00	15	Admin User	3		13	1
86	2020-02-04 02:41:34.251989+00	14	Admin User	3		13	1
87	2020-02-04 02:41:34.25437+00	13	User	3		13	1
88	2020-02-04 02:41:34.256684+00	12	Admin User	3		13	1
89	2020-02-04 02:41:34.258905+00	11	User	3		13	1
90	2020-02-04 02:41:34.261205+00	10	Admin User	3		13	1
91	2020-02-04 02:41:34.263408+00	9	User	3		13	1
92	2020-02-04 02:41:34.265776+00	8	Admin User	3		13	1
93	2020-02-04 02:41:34.2685+00	7	User	3		13	1
94	2020-02-04 02:41:34.271901+00	6	Admin User	3		13	1
95	2020-02-05 01:48:17.840151+00	2	513a3006-e96c-4be8-9bca-25b46d99d5dc	2	[{"changed": {"fields": ["full_name"]}}]	7	1
96	2020-02-05 01:48:43.227275+00	1	longx695	2	[{"changed": {"fields": ["full_name"]}}]	7	1
97	2020-02-05 01:48:56.215851+00	3	d7cdd263-a715-4c7c-9452-5e3f9af28459	2	[{"changed": {"fields": ["full_name"]}}]	7	1
98	2020-02-05 01:49:33.552167+00	2	stanley	2	[{"changed": {"fields": ["username"]}}]	7	1
99	2020-02-05 01:49:45.191891+00	3	henry	2	[{"changed": {"fields": ["username"]}}]	7	1
100	2020-02-05 01:49:59.642905+00	4	david	2	[{"changed": {"fields": ["username"]}}]	7	1
101	2020-02-05 01:51:26.838913+00	5	lionel	2	[{"changed": {"fields": ["username", "address"]}}]	7	1
102	2020-02-07 02:59:38.302009+00	1	longx695	2	[{"changed": {"fields": ["photo"]}}]	7	1
103	2020-02-07 09:05:42.258883+00	18	User #3 is friends with #2	3		11	1
104	2020-02-07 09:05:42.264398+00	17	User #2 is friends with #3	3		11	1
105	2020-02-07 09:40:02.994369+00	2	stanley	2	[{"changed": {"fields": ["photo"]}}]	7	1
106	2020-02-07 10:17:45.982367+00	3	henry	2	[{"changed": {"fields": ["location"]}}]	7	1
107	2020-02-07 10:40:58.353377+00	105	VoiceMessage object (105)	3		9	1
108	2020-02-07 10:40:58.357488+00	104	VoiceMessage object (104)	3		9	1
109	2020-02-07 10:40:58.360157+00	103	VoiceMessage object (103)	3		9	1
110	2020-02-07 10:40:58.362576+00	102	VoiceMessage object (102)	3		9	1
111	2020-02-07 10:40:58.365006+00	101	VoiceMessage object (101)	3		9	1
112	2020-02-07 10:40:58.367593+00	100	VoiceMessage object (100)	3		9	1
113	2020-02-07 10:40:58.370296+00	99	VoiceMessage object (99)	3		9	1
114	2020-02-07 10:40:58.372224+00	98	VoiceMessage object (98)	3		9	1
115	2020-02-07 10:40:58.374352+00	97	VoiceMessage object (97)	3		9	1
116	2020-02-07 10:40:58.376448+00	96	VoiceMessage object (96)	3		9	1
117	2020-02-07 10:40:58.378568+00	95	VoiceMessage object (95)	3		9	1
118	2020-02-07 10:40:58.380603+00	94	VoiceMessage object (94)	3		9	1
119	2020-02-07 10:40:58.38241+00	93	VoiceMessage object (93)	3		9	1
120	2020-02-07 10:40:58.38462+00	92	VoiceMessage object (92)	3		9	1
121	2020-02-07 10:40:58.38751+00	91	VoiceMessage object (91)	3		9	1
122	2020-02-07 10:40:58.390634+00	90	VoiceMessage object (90)	3		9	1
123	2020-02-07 10:40:58.392918+00	89	VoiceMessage object (89)	3		9	1
124	2020-02-07 10:40:58.39527+00	88	VoiceMessage object (88)	3		9	1
125	2020-02-07 10:40:58.397518+00	87	VoiceMessage object (87)	3		9	1
126	2020-02-07 10:40:58.399752+00	86	VoiceMessage object (86)	3		9	1
127	2020-02-07 10:40:58.401723+00	85	VoiceMessage object (85)	3		9	1
128	2020-02-07 10:40:58.403825+00	84	VoiceMessage object (84)	3		9	1
129	2020-02-07 10:40:58.405919+00	83	VoiceMessage object (83)	3		9	1
130	2020-02-07 10:40:58.407883+00	82	VoiceMessage object (82)	3		9	1
131	2020-02-07 10:40:58.40992+00	81	VoiceMessage object (81)	3		9	1
132	2020-02-07 10:40:58.41193+00	80	VoiceMessage object (80)	3		9	1
133	2020-02-07 10:40:58.41427+00	79	VoiceMessage object (79)	3		9	1
134	2020-02-07 10:40:58.416893+00	78	VoiceMessage object (78)	3		9	1
135	2020-02-07 10:40:58.418902+00	77	VoiceMessage object (77)	3		9	1
136	2020-02-07 10:40:58.420951+00	76	VoiceMessage object (76)	3		9	1
137	2020-02-07 10:40:58.422745+00	75	VoiceMessage object (75)	3		9	1
138	2020-02-07 10:40:58.424697+00	74	VoiceMessage object (74)	3		9	1
139	2020-02-07 10:40:58.426909+00	73	VoiceMessage object (73)	3		9	1
140	2020-02-07 10:40:58.429169+00	72	VoiceMessage object (72)	3		9	1
141	2020-02-07 10:40:58.431117+00	71	VoiceMessage object (71)	3		9	1
142	2020-02-07 10:40:58.433009+00	70	VoiceMessage object (70)	3		9	1
143	2020-02-07 10:40:58.435078+00	69	VoiceMessage object (69)	3		9	1
144	2020-02-07 10:40:58.43688+00	68	VoiceMessage object (68)	3		9	1
145	2020-02-07 10:40:58.438999+00	67	VoiceMessage object (67)	3		9	1
146	2020-02-07 10:40:58.441734+00	66	VoiceMessage object (66)	3		9	1
147	2020-02-07 10:40:58.444052+00	65	VoiceMessage object (65)	3		9	1
148	2020-02-07 10:40:58.446668+00	64	VoiceMessage object (64)	3		9	1
149	2020-02-07 10:40:58.448504+00	63	VoiceMessage object (63)	3		9	1
150	2020-02-07 10:40:58.450718+00	62	VoiceMessage object (62)	3		9	1
151	2020-02-07 10:40:58.452681+00	61	VoiceMessage object (61)	3		9	1
152	2020-02-07 10:40:58.454869+00	60	VoiceMessage object (60)	3		9	1
153	2020-02-07 10:40:58.457213+00	59	VoiceMessage object (59)	3		9	1
154	2020-02-07 10:40:58.459583+00	58	VoiceMessage object (58)	3		9	1
155	2020-02-07 10:40:58.461504+00	57	VoiceMessage object (57)	3		9	1
156	2020-02-07 10:40:58.464144+00	56	VoiceMessage object (56)	3		9	1
157	2020-02-07 10:40:58.466464+00	55	VoiceMessage object (55)	3		9	1
158	2020-02-07 10:40:58.468667+00	54	VoiceMessage object (54)	3		9	1
159	2020-02-07 10:40:58.470657+00	53	VoiceMessage object (53)	3		9	1
160	2020-02-07 10:40:58.473101+00	52	VoiceMessage object (52)	3		9	1
161	2020-02-07 10:40:58.474924+00	51	VoiceMessage object (51)	3		9	1
162	2020-02-07 10:40:58.47667+00	50	VoiceMessage object (50)	3		9	1
163	2020-02-07 10:40:58.478424+00	49	VoiceMessage object (49)	3		9	1
164	2020-02-07 10:40:58.480284+00	48	VoiceMessage object (48)	3		9	1
165	2020-02-07 10:40:58.482453+00	47	VoiceMessage object (47)	3		9	1
166	2020-02-07 10:40:58.484302+00	46	VoiceMessage object (46)	3		9	1
167	2020-02-07 10:40:58.486493+00	45	VoiceMessage object (45)	3		9	1
168	2020-02-07 10:41:11.225571+00	5	lionel	3		7	1
169	2020-02-07 10:41:11.229513+00	4	david	3		7	1
170	2020-02-07 16:06:42.396973+00	1	longx695	2	[{"changed": {"fields": ["location"]}}]	7	1
171	2020-02-08 00:46:27.857406+00	24	User #2 is friends with #3	3		11	1
172	2020-02-08 00:46:27.862315+00	23	User #3 is friends with #2	3		11	1
173	2020-02-08 00:46:27.864665+00	12	User #1 is friends with #3	3		11	1
174	2020-02-08 00:46:27.866606+00	11	User #3 is friends with #1	3		11	1
175	2020-02-08 19:19:00.302213+00	2	stanley	2	[{"changed": {"fields": ["location"]}}]	7	1
176	2020-02-09 03:39:36.121645+00	28	User #3 is friends with #2	3		11	1
177	2020-02-09 03:39:36.125852+00	27	User #2 is friends with #3	3		11	1
178	2020-02-10 01:25:29.628441+00	30	User #3 is friends with #2	3		11	1
179	2020-02-10 01:25:29.636844+00	29	User #2 is friends with #3	3		11	1
180	2020-02-10 02:40:09.497505+00	20	2	3		10	1
181	2020-02-10 02:40:09.503286+00	18	7	3		10	1
182	2020-02-10 02:40:33.048307+00	32	User #7 is friends with #2	3		11	1
183	2020-02-10 02:40:33.053444+00	31	User #2 is friends with #7	3		11	1
184	2020-02-10 02:40:33.056733+00	26	User #7 is friends with #1	3		11	1
185	2020-02-10 02:40:33.05942+00	25	User #1 is friends with #7	3		11	1
186	2020-02-10 02:40:33.062419+00	20	User #1 is friends with #6	3		11	1
187	2020-02-10 02:40:33.064554+00	19	User #6 is friends with #1	3		11	1
188	2020-02-10 16:16:29.045435+00	6	test	2	[{"changed": {"fields": ["username", "address"]}}]	7	1
189	2020-02-10 16:26:02.816786+00	36	User #1 is friends with #2	3		11	1
190	2020-02-10 16:26:02.822559+00	35	User #2 is friends with #1	3		11	1
191	2020-02-10 16:26:02.82582+00	34	User #2 is friends with #6	3		11	1
192	2020-02-10 16:26:02.828658+00	33	User #6 is friends with #2	3		11	1
193	2020-02-10 16:35:47.815041+00	38	User #7 is friends with #1	3		11	1
194	2020-02-10 16:35:47.819449+00	37	User #1 is friends with #7	3		11	1
195	2020-02-10 16:43:55.061169+00	21	2	3		10	1
196	2020-02-10 16:44:11.496299+00	44	User #7 is friends with #1	3		11	1
197	2020-02-10 16:44:11.500149+00	43	User #1 is friends with #7	3		11	1
198	2020-02-10 16:44:11.502557+00	42	User #2 is friends with #6	3		11	1
199	2020-02-10 16:44:11.50517+00	41	User #6 is friends with #2	3		11	1
200	2020-02-10 16:44:11.508437+00	40	User #7 is friends with #8	3		11	1
201	2020-02-10 16:44:11.511086+00	39	User #8 is friends with #7	3		11	1
202	2020-02-10 16:51:37.513162+00	52	User #1 is friends with #6	3		11	1
203	2020-02-10 16:51:37.517454+00	51	User #6 is friends with #1	3		11	1
204	2020-02-10 16:51:37.519609+00	50	User #1 is friends with #3	3		11	1
205	2020-02-10 16:51:37.522242+00	49	User #3 is friends with #1	3		11	1
206	2020-02-10 16:51:37.524826+00	48	User #1 is friends with #2	3		11	1
207	2020-02-10 16:51:37.527711+00	47	User #2 is friends with #1	3		11	1
208	2020-02-10 16:51:37.530368+00	46	User #7 is friends with #1	3		11	1
209	2020-02-10 16:51:37.532878+00	45	User #1 is friends with #7	3		11	1
210	2020-02-10 16:51:51.103251+00	54	User #2 is friends with #6	3		11	1
211	2020-02-10 16:51:51.107175+00	53	User #6 is friends with #2	3		11	1
212	2020-02-10 16:52:11.162488+00	60	User #2 is friends with #6	3		11	1
213	2020-02-10 16:52:11.166712+00	59	User #6 is friends with #2	3		11	1
214	2020-02-10 16:52:11.170153+00	58	User #2 is friends with #7	3		11	1
215	2020-02-10 16:52:11.172798+00	57	User #7 is friends with #2	3		11	1
216	2020-02-10 16:52:11.175652+00	56	User #2 is friends with #3	3		11	1
217	2020-02-10 16:52:11.178576+00	55	User #3 is friends with #2	3		11	1
218	2020-02-10 20:39:06.632588+00	9	1c96cd51-8697-4be3-849c-6df66a9962bb	3		7	1
219	2020-02-13 01:23:05.134293+00	74	User #7 is friends with #8	3		11	1
220	2020-02-13 01:23:05.141598+00	73	User #8 is friends with #7	3		11	1
221	2020-02-13 01:23:05.143907+00	72	User #8 is friends with #1	3		11	1
222	2020-02-13 01:23:05.146004+00	71	User #1 is friends with #8	3		11	1
223	2020-02-13 01:23:05.148098+00	70	User #7 is friends with #1	3		11	1
224	2020-02-13 01:23:05.150239+00	69	User #1 is friends with #7	3		11	1
225	2020-02-13 01:23:05.152299+00	68	User #2 is friends with #8	3		11	1
226	2020-02-13 01:23:05.155032+00	67	User #8 is friends with #2	3		11	1
227	2020-02-13 01:23:05.15721+00	66	User #2 is friends with #6	3		11	1
228	2020-02-13 01:23:05.15944+00	65	User #6 is friends with #2	3		11	1
229	2020-02-13 01:23:05.161591+00	64	User #2 is friends with #7	3		11	1
230	2020-02-13 01:23:05.163585+00	63	User #7 is friends with #2	3		11	1
231	2020-02-13 01:23:05.165534+00	62	User #2 is friends with #3	3		11	1
232	2020-02-13 01:23:05.167437+00	61	User #3 is friends with #2	3		11	1
233	2020-02-13 01:23:45.958279+00	43	7	3		10	1
234	2020-02-16 15:01:05.352031+00	53	+14387942375 - 7297	2	[{"changed": {"fields": ["used"]}}]	8	1
235	2020-02-26 10:24:47.286024+00	53	+14387942375 - 7297	2	[{"changed": {"fields": ["used"]}}]	8	1
236	2020-02-27 15:52:22.651662+00	53	+14387942375 - 7297	2	[{"changed": {"fields": ["used"]}}]	8	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	authtoken	token
7	api	customuser
8	api	phonetoken
9	api	voicemessage
10	friendship	friendshiprequest
11	friendship	friend
12	api	likemessage
13	push_notifications	apnsdevice
14	push_notifications	gcmdevice
15	push_notifications	wnsdevice
16	push_notifications	webpushdevice
17	api	callinfo
18	api	group
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2019-12-23 17:21:20.819784+00
2	contenttypes	0002_remove_content_type_name	2019-12-23 17:21:20.842988+00
3	auth	0001_initial	2019-12-23 17:21:20.909857+00
4	auth	0002_alter_permission_name_max_length	2019-12-23 17:21:20.954646+00
5	auth	0003_alter_user_email_max_length	2019-12-23 17:21:20.970658+00
6	auth	0004_alter_user_username_opts	2019-12-23 17:21:20.985978+00
7	auth	0005_alter_user_last_login_null	2019-12-23 17:21:20.998977+00
8	auth	0006_require_contenttypes_0002	2019-12-23 17:21:21.008918+00
9	auth	0007_alter_validators_add_error_messages	2019-12-23 17:21:21.025746+00
10	auth	0008_alter_user_username_max_length	2019-12-23 17:21:21.041264+00
11	auth	0009_alter_user_last_name_max_length	2019-12-23 17:21:21.054579+00
12	auth	0010_alter_group_name_max_length	2019-12-23 17:21:21.073685+00
13	auth	0011_update_proxy_permissions	2019-12-23 17:21:21.092298+00
14	api	0001_initial	2019-12-23 17:21:21.186304+00
15	admin	0001_initial	2019-12-23 17:21:21.303596+00
16	admin	0002_logentry_remove_auto_add	2019-12-23 17:21:21.341537+00
17	admin	0003_logentry_add_action_flag_choices	2019-12-23 17:21:21.36622+00
18	authtoken	0001_initial	2019-12-23 17:21:21.407952+00
19	authtoken	0002_auto_20160226_1747	2019-12-23 17:21:21.486806+00
20	friendship	0001_initial	2019-12-23 17:21:21.5485+00
21	sessions	0001_initial	2019-12-23 17:21:21.612551+00
22	api	0002_auto_20200107_1608	2020-01-07 16:08:28.378504+00
23	api	0003_auto_20200123_0316	2020-01-23 03:16:58.040449+00
24	push_notifications	0001_initial	2020-01-23 03:16:58.135645+00
25	push_notifications	0002_auto_20160106_0850	2020-01-23 03:16:58.20088+00
26	push_notifications	0003_wnsdevice	2020-01-23 03:16:58.246234+00
27	push_notifications	0004_fcm	2020-01-23 03:16:58.309167+00
28	push_notifications	0005_applicationid	2020-01-23 03:16:58.388628+00
29	push_notifications	0006_webpushdevice	2020-01-23 03:16:58.438586+00
30	api	0004_auto_20200130_2024	2020-01-30 20:24:32.203508+00
31	api	0005_auto_20200131_0720	2020-01-31 07:20:30.70971+00
32	api	0006_callinfo	2020-01-31 08:05:42.496773+00
33	api	0002_auto_20200201_2012	2020-02-01 20:13:04.926381+00
34	api	0002_customuser_is_blocked	2020-04-10 13:04:40.503383+00
35	api	0003_customuser_black_list	2020-04-10 18:05:56.996462+00
36	api	0004_auto_20200417_2144	2020-04-17 21:44:55.591329+00
37	api	0004_auto_20200416_1422	2020-04-22 14:43:08.193389+00
38	api	0005_voicemessage_viewed	2020-04-22 14:43:08.298659+00
39	api	0006_auto_20200422_1401	2020-04-22 14:43:08.357969+00
40	api	0007_merge_20200422_1442	2020-04-22 14:43:08.367363+00
41	api	0007_auto_20200424_1419	2020-04-24 18:08:31.571833+00
42	api	0008_merge_20200424_1808	2020-04-24 18:08:31.582425+00
43	api	0008_auto_20200521_0718	2020-05-29 13:40:50.544374+00
44	api	0009_auto_20200522_0649	2020-05-29 13:40:50.675566+00
45	api	0010_auto_20200522_0704	2020-05-29 13:40:50.743456+00
46	api	0011_merge_20200529_1340	2020-05-29 13:40:50.745732+00
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
2fs0vhnqlt1hzcxpt627dadu0brweik2	YzJkNTY0ZWM1MzZiZmE2YmI2NTU4NDcyOTEyNzE3Njk4ZTc2MjdhNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZDQyZDA1ZjhiMzIwNWM5ZDc4MzI2NWQyOTA3NDU1Y2M1OTA4MjdiIn0=	2020-01-06 17:38:09.024969+00
tw02gymfqtrxyaquxakyabfdr3v45p15	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-01-06 17:39:57.224354+00
nxafq9hqmfiy99jum5j6rhkfc4mhw3u0	YzJkNTY0ZWM1MzZiZmE2YmI2NTU4NDcyOTEyNzE3Njk4ZTc2MjdhNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZDQyZDA1ZjhiMzIwNWM5ZDc4MzI2NWQyOTA3NDU1Y2M1OTA4MjdiIn0=	2020-01-07 03:01:38.140309+00
dggazmagsvn3s308h5djbkytx901mxle	NjdmY2UzYTg1ZGM2MmFlZGI1NGI0Y2VlY2I0NzBjODcyZDczM2Q5Yzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNWRkYTdiYTMyNmEyYjMwYWIwN2UzZmM2OTY5YmU0ODg0ZWFiNzFhNyJ9	2020-01-07 03:03:22.938936+00
h56ghe983e12a0w12w6gn3ae25i3afme	YzJkNTY0ZWM1MzZiZmE2YmI2NTU4NDcyOTEyNzE3Njk4ZTc2MjdhNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZDQyZDA1ZjhiMzIwNWM5ZDc4MzI2NWQyOTA3NDU1Y2M1OTA4MjdiIn0=	2020-01-21 16:09:05.642998+00
av2v2dy2rky0wo6qh2c6j5f7xilr0igb	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-01-21 16:09:40.980283+00
u3belaxyyqr3mctxlb2n5zlh883p9jum	NjdmY2UzYTg1ZGM2MmFlZGI1NGI0Y2VlY2I0NzBjODcyZDczM2Q5Yzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNWRkYTdiYTMyNmEyYjMwYWIwN2UzZmM2OTY5YmU0ODg0ZWFiNzFhNyJ9	2020-01-21 16:12:18.727954+00
jhi2znwba37xh8unu6relreftoc5wula	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-01-21 16:29:55.428843+00
ho12fkl43zceyepmnikbs26aieakimo1	NmU5ZTFjMzk4NzA4ZmZkODQ3OTQ1NjNkMmQ0YmY3OGNlMDdjYjBmNzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzg2N2FlNmQwODQzNDZjYTI5MmNlM2VmYjg1OWNjMTg2NzgyYTQxZSJ9	2020-01-22 18:47:57.889786+00
74quqjiu7ula69nisak8dmdshpfrolrc	NmU5ZTFjMzk4NzA4ZmZkODQ3OTQ1NjNkMmQ0YmY3OGNlMDdjYjBmNzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzg2N2FlNmQwODQzNDZjYTI5MmNlM2VmYjg1OWNjMTg2NzgyYTQxZSJ9	2020-01-22 18:53:43.854571+00
4f4q7h6zdohfepzw33g5dgkskpjbcukb	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-01-22 19:20:57.712849+00
xjeb5w6p44xpjd2odtueaiw2pqhjaj4r	NmU5ZTFjMzk4NzA4ZmZkODQ3OTQ1NjNkMmQ0YmY3OGNlMDdjYjBmNzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzg2N2FlNmQwODQzNDZjYTI5MmNlM2VmYjg1OWNjMTg2NzgyYTQxZSJ9	2020-01-23 01:38:37.85978+00
r4z1vmg65juk3hyktkj4zhrvpr9t6lbu	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-01-23 02:07:05.144851+00
1hhj62epd0dyqecfgxr03qk27du1fpqj	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-01-23 03:24:01.356204+00
tacgc5wgbysd0ttr93zcoo4cb6qmvgmg	YmMwNmIxZWFlMDk5ODA0MjBiZTliNGVmNjVmNjQ4NWRkYzg4NmVlZjp7Il9hdXRoX3VzZXJfaWQiOiI1IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOWRkYmM0ZTY4NzgzOTliZDI0ZmYzODY1NzYyYzM3MDM0YWEyNDU5MSJ9	2020-01-24 01:44:41.522092+00
ovdp11u3nh0ee3e3sggwmb4akact2x2r	NmU5ZTFjMzk4NzA4ZmZkODQ3OTQ1NjNkMmQ0YmY3OGNlMDdjYjBmNzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzg2N2FlNmQwODQzNDZjYTI5MmNlM2VmYjg1OWNjMTg2NzgyYTQxZSJ9	2020-01-24 20:10:40.706648+00
yi3zrz2re2dh0fex01ttlrbaq7vyznjg	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-01-28 10:09:52.708748+00
ammsklw2wazxek4v21xjw3hdkd149llx	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-01-29 15:50:46.198987+00
2bpdqraja18lkkxftutqyjraq2oec8v0	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-01-29 16:17:34.983251+00
ybo2k2sdw5sjn56xyxbel4r0zdtwuwy8	NjdmY2UzYTg1ZGM2MmFlZGI1NGI0Y2VlY2I0NzBjODcyZDczM2Q5Yzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNWRkYTdiYTMyNmEyYjMwYWIwN2UzZmM2OTY5YmU0ODg0ZWFiNzFhNyJ9	2020-01-29 16:18:25.495766+00
uejuslhqlu0b7yimrx5dlx86l8egpkm5	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-01-29 17:51:36.944892+00
6z16un73fbeu4219vz9gfdcxtgsnlll3	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-01-29 17:54:08.079084+00
68x77x20aujfdip98p84jlm4xb9tdo8w	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-01-30 01:21:04.941281+00
rcmf34pmzyiputy5yyw6tp3f07mf526k	YzJkNTY0ZWM1MzZiZmE2YmI2NTU4NDcyOTEyNzE3Njk4ZTc2MjdhNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZDQyZDA1ZjhiMzIwNWM5ZDc4MzI2NWQyOTA3NDU1Y2M1OTA4MjdiIn0=	2020-02-04 21:22:09.942063+00
mb2xyxjdc12lcrztrjht9gi78ykbcn8n	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-06 02:34:52.03861+00
9c48h8uk2h5mdtmlldorhuxehlu8nmry	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-02-13 20:05:39.581758+00
f0extfvw2wr7ior42jaj8r1ehny1qr2s	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-02-14 01:39:03.707002+00
xadgwqw7c7w6dnypalg2jcwxcx7f19e5	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-02-14 02:09:53.08022+00
dtyzhj320o72y95hfpnsfvu8g207sxul	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-02-14 03:27:24.267472+00
d0mnrxzjje2rfguompbaeqc8lgggnbtg	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-14 03:29:47.689429+00
k7ojbbqgl4u476cisq0xisoh18zq5ir0	NmU5ZTFjMzk4NzA4ZmZkODQ3OTQ1NjNkMmQ0YmY3OGNlMDdjYjBmNzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzg2N2FlNmQwODQzNDZjYTI5MmNlM2VmYjg1OWNjMTg2NzgyYTQxZSJ9	2020-02-14 04:07:51.151367+00
hp7lf9lfp0cg3a9u2taz2uzq8gcm6hmq	NmU5ZTFjMzk4NzA4ZmZkODQ3OTQ1NjNkMmQ0YmY3OGNlMDdjYjBmNzp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYzg2N2FlNmQwODQzNDZjYTI5MmNlM2VmYjg1OWNjMTg2NzgyYTQxZSJ9	2020-02-14 04:54:19.478139+00
9wr57z07ebofr03n3hm3ai5cbsvj3qf6	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-14 07:25:58.286274+00
gob7j3uqv8nsiam796rc9suxp7ykehqy	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-02-14 07:28:35.49912+00
rcg9eoi7h7n4rlrp742wreolkal4zn9f	NjdmY2UzYTg1ZGM2MmFlZGI1NGI0Y2VlY2I0NzBjODcyZDczM2Q5Yzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNWRkYTdiYTMyNmEyYjMwYWIwN2UzZmM2OTY5YmU0ODg0ZWFiNzFhNyJ9	2020-02-14 07:34:15.370907+00
bbgs18lmku01n7506d90edgjil69iukh	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-02-14 08:32:19.357037+00
7aupoy62ce83ecywoeyfowaxlfxxgoyl	NjdmY2UzYTg1ZGM2MmFlZGI1NGI0Y2VlY2I0NzBjODcyZDczM2Q5Yzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNWRkYTdiYTMyNmEyYjMwYWIwN2UzZmM2OTY5YmU0ODg0ZWFiNzFhNyJ9	2020-02-14 08:35:41.059108+00
sfw8khnjsjvokp89j9ysrx6pfahpfg2x	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-02-14 09:40:02.593394+00
sncxzed4wrl304e99efqdunzg8ju44r5	NjdmY2UzYTg1ZGM2MmFlZGI1NGI0Y2VlY2I0NzBjODcyZDczM2Q5Yzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNWRkYTdiYTMyNmEyYjMwYWIwN2UzZmM2OTY5YmU0ODg0ZWFiNzFhNyJ9	2020-02-14 09:43:18.019399+00
ens5056klesp3tn414w648dlqikjt0pj	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-02-14 17:42:25.445603+00
hr3rj0l1jyhva2homfn4xnoa95t8gq9l	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-02-14 21:09:34.150176+00
yufwb4pyw80jze4nrqvc55pequa6ms8z	NjdmY2UzYTg1ZGM2MmFlZGI1NGI0Y2VlY2I0NzBjODcyZDczM2Q5Yzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNWRkYTdiYTMyNmEyYjMwYWIwN2UzZmM2OTY5YmU0ODg0ZWFiNzFhNyJ9	2020-02-14 21:13:30.430949+00
7vujt24wqllpiffcy37dyhnqoviqndd9	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-02-14 23:11:33.915179+00
ybnqlqz6y7p5ihmvnf6360i1tdkw3wlv	NjdmY2UzYTg1ZGM2MmFlZGI1NGI0Y2VlY2I0NzBjODcyZDczM2Q5Yzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNWRkYTdiYTMyNmEyYjMwYWIwN2UzZmM2OTY5YmU0ODg0ZWFiNzFhNyJ9	2020-02-14 23:15:57.94559+00
7vvvpah6hsgb24b22hycoenp4ahjiqkt	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-14 23:31:27.459096+00
gcdu2vgmfc3tppsp0e66auvt6bnwpmck	ZjJiN2NjYmFiM2MzNzY1YTRkNGM0NzdkMWY4Y2IyMTVhMTIwM2Y4Yzp7Il9hdXRoX3VzZXJfaWQiOiI2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOTRhMGExZDFiMDcwOTI3YzZhYTA3YjAxZjQ4NzJkYmVmYTJhODQyNSJ9	2020-02-15 20:15:43.431159+00
9gmgib1mhm8uq1dx4d3f7je9am8kmg9r	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-02-15 20:20:15.87371+00
n32qckl10l0rjfg9p4lek1l1e7k6i9c6	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-02-17 02:53:05.266416+00
g8v6ea6hzccbmam1olryuu7gc1qaj4kh	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-17 10:58:23.527014+00
v54bxubn914baple5j2mvy88homkkqz6	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-18 02:38:51.943964+00
3ylx5l5h7y13d5a93fpi461hud8fpf30	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-18 01:36:00.751363+00
wdig7gnua5tdvvkfk4jwd8r7ydg30zw7	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-18 15:21:53.213606+00
bcsfu6pb46owrwjl9z58zwnok6xoqlrh	NjdmY2UzYTg1ZGM2MmFlZGI1NGI0Y2VlY2I0NzBjODcyZDczM2Q5Yzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNWRkYTdiYTMyNmEyYjMwYWIwN2UzZmM2OTY5YmU0ODg0ZWFiNzFhNyJ9	2020-02-18 01:39:24.828288+00
z8ls13mjswhexbta7vzmxbo16sip7ad2	YzJkNTY0ZWM1MzZiZmE2YmI2NTU4NDcyOTEyNzE3Njk4ZTc2MjdhNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZDQyZDA1ZjhiMzIwNWM5ZDc4MzI2NWQyOTA3NDU1Y2M1OTA4MjdiIn0=	2020-02-19 01:47:37.126174+00
5jb78a9h81ofyu3zn97e4inkrj91zycs	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-18 01:46:06.236574+00
dvios7jy5b0exx8tlmvymi2m99f81ae2	YzJkNTY0ZWM1MzZiZmE2YmI2NTU4NDcyOTEyNzE3Njk4ZTc2MjdhNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZDQyZDA1ZjhiMzIwNWM5ZDc4MzI2NWQyOTA3NDU1Y2M1OTA4MjdiIn0=	2020-02-21 02:43:29.428581+00
jp6285lii1tmx605abvxg3orklak992u	NjdmY2UzYTg1ZGM2MmFlZGI1NGI0Y2VlY2I0NzBjODcyZDczM2Q5Yzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNWRkYTdiYTMyNmEyYjMwYWIwN2UzZmM2OTY5YmU0ODg0ZWFiNzFhNyJ9	2020-02-18 01:46:50.49549+00
s1qdrayqdkl3oxoe8xnb03cf0x2063w8	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-21 09:05:05.730479+00
2vw2rpmp3nranwx49l4r9vpsmrlnxkrx	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-18 01:52:33.043309+00
i1teiopzabx94kn7vlsa3pbagal017a9	NjdmY2UzYTg1ZGM2MmFlZGI1NGI0Y2VlY2I0NzBjODcyZDczM2Q5Yzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNWRkYTdiYTMyNmEyYjMwYWIwN2UzZmM2OTY5YmU0ODg0ZWFiNzFhNyJ9	2020-02-21 09:13:05.606264+00
yd4cs3f7tan27o8ni4v4hqmun8y4sqad	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-18 02:01:42.137739+00
ctf0iquw8bti1v637d2bui1c7p3zgdst	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-21 09:41:36.028383+00
jt4bw8qmtt355qrx7gh49takqklnrv36	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-21 10:33:54.417118+00
zj0i8285ctrl4sjiedic9adonqsgkcvr	NDY3OWNiMThhYWM1MGE4ZWUzYTQ4YjllNjNjZmI2NzUxMTczOTIzZjp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZGM1OGY5MjlkNzBkOTNkMmRiYmY5ODhkN2YwNjg2YjI4ZjNhM2ZiMCJ9	2020-02-21 15:52:49.094179+00
examvb10gpc5a8ldusai660zw39sdv69	YWI3MDgzYjllMzMxZmZkM2I1NzU3NmZlNjEyMTY3OWZmMDBlNDQyNzp7Il9hdXRoX3VzZXJfaWQiOiI4IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2FiYWJjZmIxYWM0MTM2NWE3NDMzZjBiMTg1ZDgzNmVmMzQ5NDJhMyJ9	2020-02-21 19:45:25.589497+00
805xpx0jcbg7zyazn3ei7sslamt7vf62	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-22 10:26:26.276442+00
632hf05a574q2spqplyyvc5ww5x6ee4g	NjdmY2UzYTg1ZGM2MmFlZGI1NGI0Y2VlY2I0NzBjODcyZDczM2Q5Yzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNWRkYTdiYTMyNmEyYjMwYWIwN2UzZmM2OTY5YmU0ODg0ZWFiNzFhNyJ9	2020-02-22 10:30:36.214179+00
c8t16keuzolg7sqxudzin625pxmu3owq	NjdmY2UzYTg1ZGM2MmFlZGI1NGI0Y2VlY2I0NzBjODcyZDczM2Q5Yzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNWRkYTdiYTMyNmEyYjMwYWIwN2UzZmM2OTY5YmU0ODg0ZWFiNzFhNyJ9	2020-02-22 10:34:21.384032+00
f89vkhlgkipmwobbkxtk3n1g7w6e4ckh	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-22 10:37:09.169217+00
petcx4v579vwz3c5d0nhjt5dcgz30ih5	NDY3OWNiMThhYWM1MGE4ZWUzYTQ4YjllNjNjZmI2NzUxMTczOTIzZjp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZGM1OGY5MjlkNzBkOTNkMmRiYmY5ODhkN2YwNjg2YjI4ZjNhM2ZiMCJ9	2020-02-23 02:42:47.399065+00
n6jke8ivq4hbrpm6k38v9reus79d4wad	YWI3MDgzYjllMzMxZmZkM2I1NzU3NmZlNjEyMTY3OWZmMDBlNDQyNzp7Il9hdXRoX3VzZXJfaWQiOiI4IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2FiYWJjZmIxYWM0MTM2NWE3NDMzZjBiMTg1ZDgzNmVmMzQ5NDJhMyJ9	2020-02-24 00:03:27.490755+00
ks4dwhqe7jsfxtzq358lidmuvupm4s3m	ZjJiN2NjYmFiM2MzNzY1YTRkNGM0NzdkMWY4Y2IyMTVhMTIwM2Y4Yzp7Il9hdXRoX3VzZXJfaWQiOiI2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOTRhMGExZDFiMDcwOTI3YzZhYTA3YjAxZjQ4NzJkYmVmYTJhODQyNSJ9	2020-02-24 20:21:59.327246+00
38t3jpi0oo3l85spgk8gsn1eh6hgubsn	YTI1NTExN2QwNTUwYmUxZTY5OTc0YzY1Yzg1ZDc1MTM2MzAwYWVjYTp7Il9hdXRoX3VzZXJfaWQiOiI5IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiODU4OWZmYzYzZDhmZmU4MTc2MTcwNzk3YzAxNWQ5NTJhODU3ZTg2MCJ9	2020-02-24 20:36:37.113217+00
phtxfwd2aci2aa9bnyqof2yv0pdy59x1	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-24 20:38:54.763178+00
znknxh0kelrxd9fsrymbf981d6t4yjh8	OGM0OTM2NWJjM2MxNDU1MDY2YTNhMzkxNmU0Njg5NzM3MTgwYzk2Nzp7Il9hdXRoX3VzZXJfaWQiOiIzMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjAxZDY4MTI0MDc4ZmUyZDg2Yzg4Y2IyNzY5MDk1Y2YxOTUyMjYxZTYifQ==	2020-03-17 02:59:23.551156+00
e904mkhnmkxty70c1fp546s67y0diczh	OWY4OTAzMWNhYTQzN2NhZGY4ODY2ZmIwMjg2M2ViMjEzZWEwOTdhZTp7Il9hdXRoX3VzZXJfaWQiOiI0NyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjkzNjhiMGMwMDg5MDY5ZTFjNmNhZDI3YmY4OTY5YTQ3MzU1ZTk2MzMifQ==	2020-03-17 21:57:32.527859+00
u9h46z2aztal6vn1web34hzeo18dprqx	ZmNmYWZmOWJiYzUwYWM5MTgzMjc0M2Q0NTJjNDBiZTkzYjRiZWJmMTp7Il9hdXRoX3VzZXJfaWQiOiIxMDQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NjIxODkxNTVhMTVlZmM2YWUyMTRkODZlNjFmNDI2ZjljODZkMzUxIn0=	2020-03-23 18:24:02.230871+00
gt3yw6vlaajxepw5aqqk4aaqrjnryg0o	ZTQyZjU3ZDJjNGQwNzE2YjUyZWEwMjZlODViODdlZWQzZTkxNWE1NDp7Il9hdXRoX3VzZXJfaWQiOiI2MyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImZmNWE5MTMzNzdlODViMDVkMTcwOTY1Yjg0NmQ1Yzg3OTA2NmFlYjgifQ==	2020-03-19 01:59:35.978078+00
x20t7ewzxt74m28k1qnm8f7y7irbpjlb	ZjUxOTA5NDA1Y2UyMTAyMTIwM2U0MDFhOTQ0M2QwMzdjZTJhZWQyMzp7Il9hdXRoX3VzZXJfaWQiOiI5MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImExZDJhYzBjODI4NmRkY2I0M2ZhYTQ3ZjZmODg0ZGMyYzRiY2E0YzcifQ==	2020-03-25 03:56:28.770112+00
mffn8pmajytkk04ossj67gnnwih2dv8m	YTdlNDZiZDNmMGM5NmUzNGYzNWRlZjdkNTI5MzYxZmZiNDMyMjE3Njp7Il9hdXRoX3VzZXJfaWQiOiI3OCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjU1YjkzYTg0N2U2OWFlYzAxYjQ5YmZmMjdlN2IxNDM2NjgyOTBhODQifQ==	2020-03-20 19:27:11.614207+00
sp5pnvvlpnphtci338jx4jc9m5v6dwpw	N2UyMTFmMzlmYWJkN2RhYjdmMjM5OGJiOGNlNWQ2ZDNjNTRiY2E3NDp7Il9hdXRoX3VzZXJfaWQiOiI5MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImRqYW5nby5jb250cmliLmF1dGguYmFja2VuZHMuTW9kZWxCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYTFkMmFjMGM4Mjg2ZGRjYjQzZmFhNDdmNmY4ODRkYzJjNGJjYTRjNyJ9	2020-03-23 03:26:28.560808+00
qxvrus9fdh0lafuwf0o2t29cizsq5mv6	ZTY4MjZjZjE0MTk2OTE2MDE3NGIzNzNkOWRlMWQ3MmQxZmI2YzhjYzp7Il9hdXRoX3VzZXJfaWQiOiIxMzQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0NjQ3OWExM2ZkMzE0NzBjNTk2NGEzNWY3MDRiOWNiMmUxOGEwNDMzIn0=	2020-04-07 17:08:26.137131+00
f508h3lxlubkixkczeec9786q6pwodcq	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-24 20:57:42.922468+00
7odr67su6zfx0y5zi6a4lggu5fv0vx12	ZmQ5MjcwZmJlZWYxYWQ0ZDMxZmNlMWFkZjk3MDA5YzgyMDY3N2ZjNDp7Il9hdXRoX3VzZXJfaWQiOiIxMDUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmMmEwZjk5YmEyZTllZGNhMzA3NTA2NGEzYzExNDRjNWJiNjg0Y2JhIn0=	2020-03-23 18:38:22.428045+00
wk91ghsv9uqxqm1ykd4ges5wg86zro6r	YjUyMDVmNzE0NzMzYzhjYWE1NmM1Y2FjNjhiNTY3YzRjMGMwNmEzOTp7Il9hdXRoX3VzZXJfaWQiOiI0OCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImU0YTQ1MTE5ODAyYjQ2OTMyMjVkOTJiNzJmMjcwMTdmMTQwYWEyYzEifQ==	2020-03-17 23:17:38.055128+00
fm71jm85jd5752ib1y72cuh5g4fjhxkm	ZGMxMTE0YmZmZjQ4YzdlODliZDgxODM4NDJiZGY3YzRiNGU4OGMyZDp7Il9hdXRoX3VzZXJfaWQiOiIxMTgiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3MjVkODY2MTQ1OWU2NmU2ZDJkZmRhM2EwMzM5N2JjNGI0NTFkZGUxIn0=	2020-03-25 04:49:19.909744+00
tp3fzd4q071q0mja7pcs8tsr9jb50cjy	MzVmMGY5MTBiNmYxYzU0MzNiYjFjYzkwYjE4ZGZiNzllNWFhM2YxZDp7Il9hdXRoX3VzZXJfaWQiOiI2NCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjQ4M2ZjMjA1YWRjMzdkMzhiMWIyMGIyMmFmZGQ0NzQ0YjYwZWFhZTAifQ==	2020-03-19 02:19:28.910617+00
u04a7hut1wudq6vg20zwog0du7erz9ni	ZjYxMGEzYzdkYWUxY2VkNGY3YjI4ODM2NGNiMjAwZmZkYWJiZWVmNTp7Il9hdXRoX3VzZXJfaWQiOiI3OSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImJlODQxZDhkOGM3ZjUyY2I4MGNjYmE2ZDA5NmVmYjZhZDYwODE4YjYifQ==	2020-03-20 21:54:52.896897+00
y3lccrxbo1ncis6hyao41bfrdnlxdjos	OWU4ZDQ1ZWIzYjFhZjcxZDE5YmQ2MjExNTZmNDM4ZDU5YjY4YzYwMDp7Il9hdXRoX3VzZXJfaWQiOiIxMjMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1N2Q5MjdiYzkyNTQ0YmQwYzI4ZDg0NTYxNWMzZDAxMDI2NWY1NGQ1In0=	2020-04-01 02:08:05.439403+00
xzkp7dwly0nqdpb3bd5qc4c6tsyts356	ZjNjYjNjOWJmOTczY2EzZDE0MTc0NzdiNmRiODc3NGNjNWU5YmEwMzp7Il9hdXRoX3VzZXJfaWQiOiI5MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjViODNkNjU3MDIwNzYwYTBmODAzOWJkNjM4NmZiOWM5ZGM2YmM4YmMifQ==	2020-03-23 14:37:01.673187+00
9r98t7xdqtxltyydxt6ssurl70cbow87	YTE4ZjZiOWNlNzE1M2Q4MGEwMTUzOWE2N2MzYzM1NTFkMzYyNGNhZjp7Il9hdXRoX3VzZXJfaWQiOiIxMjYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiNGQ0YWI5NjUzMjVlYTRlYzY1NDdkNGFmYmQ2MzQ3MTZkYTZjMGEwIn0=	2020-04-07 17:16:04.265711+00
hx4xlhm7z2idu048ij7fgkr75dhn372l	YTE4ZjZiOWNlNzE1M2Q4MGEwMTUzOWE2N2MzYzM1NTFkMzYyNGNhZjp7Il9hdXRoX3VzZXJfaWQiOiIxMjYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiNGQ0YWI5NjUzMjVlYTRlYzY1NDdkNGFmYmQ2MzQ3MTZkYTZjMGEwIn0=	2020-04-15 03:07:12.772147+00
ifmjk25n5zaou6r7yntf3a8fmm5pk5qw	YTE4ZjZiOWNlNzE1M2Q4MGEwMTUzOWE2N2MzYzM1NTFkMzYyNGNhZjp7Il9hdXRoX3VzZXJfaWQiOiIxMjYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiNGQ0YWI5NjUzMjVlYTRlYzY1NDdkNGFmYmQ2MzQ3MTZkYTZjMGEwIn0=	2020-04-16 15:25:45.433529+00
ov7bf9j8guldt8xcr8ix8dx9dzp4yn0i	ZjJiN2NjYmFiM2MzNzY1YTRkNGM0NzdkMWY4Y2IyMTVhMTIwM2Y4Yzp7Il9hdXRoX3VzZXJfaWQiOiI2IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiOTRhMGExZDFiMDcwOTI3YzZhYTA3YjAxZjQ4NzJkYmVmYTJhODQyNSJ9	2020-02-24 21:03:20.779344+00
k9p9u67eqyz79fmka7jj1ijd8s8ria1m	Yzc2YTcyNTNhMTkxNDA1NWM0YmU4YTNmZGM0MTU0ZTllZGRjNWE1Yzp7Il9hdXRoX3VzZXJfaWQiOiIzMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjIwYjdiYjRmMGNmMmMyYzM2YjA2ZjRiYmVlNmM3M2NhMTU5ZDA4ZmIifQ==	2020-03-17 06:50:32.015848+00
4ecc3s94e5vnn0q176y2hdn3govzhvg1	NzZjMWQ4OWRhOTNkMWViNzU1Y2I4MmUwN2VjNmE5ZDU1OTIxNWU5NDp7Il9hdXRoX3VzZXJfaWQiOiIxMDYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjMWYxMGJmYTNkNzA1OTk5ZWE3N2QxZGUzNGMxNDJlZjk3NTI0MDg0In0=	2020-03-23 18:49:25.621315+00
la6t0kj081lbnf3itnu7qt17yhbyg1ig	NDUyN2MyMjVhZTlkODk1YzMzOTczODUwNmE2ZTJiZjA3M2Y1MmYzMTp7Il9hdXRoX3VzZXJfaWQiOiI0OSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjE1ZGI5MDVjYjI0MDM3YzY2MWY4ZTYzZGJmNGJhZTNmNTc1MTA0YTEifQ==	2020-03-18 00:07:23.058933+00
8mqtnfn60v80h3efdeuhyf4odrrne0je	MGI2NGQ2ZWJlZWZjY2Y5NGY1NDU4MzY3ZjU5MGI1NDhmYTgyN2Q1Zjp7Il9hdXRoX3VzZXJfaWQiOiI2NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6Ijc2MTE4MzYxMzlhYThmZmZkZmRjZDkxZjZmNzA3NTRhMWZmZjhiNzAifQ==	2020-03-19 02:57:08.64325+00
nfn95i0lnspzaxxacml6kzaon75lx3l8	NGQ4MzZjODhkMTlhZTc0NGMxYzUwNTAxOTZmYzkyYjY1MzUyYTFmYzp7Il9hdXRoX3VzZXJfaWQiOiIxMTkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiYWYwZjFkNGM1MWZmMzI5ODMzM2E0Mzc0YTU0NTBmM2ZlNmU5OWY5In0=	2020-03-25 09:19:41.267261+00
rfzi8hp48ftyls1izyv0baf6gyr3rn8a	MzZjOTUyZTMxODVkN2Y2MTUzMGM3ODg0NTA0M2FhMjNkZjNkZDhiODp7Il9hdXRoX3VzZXJfaWQiOiI4MCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjI1MmYwZWMwOTIwMzA3ZDQ1MWI3YWJlNmIyNmQ0Zjg1ZmNhNjNkNjUifQ==	2020-03-20 23:33:45.603583+00
j7r80py3fr35yb6fjlskjgjwm0s68c3t	NmI1YzNmZjYxZmVhMTEyOTU4ZmMxNTgyMWE5NWUwMDZhYTdiNGRlZDp7Il9hdXRoX3VzZXJfaWQiOiI5MyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjU2NjE2Mzk2NTM5NWMyNzdhYzYwZDMyYzk0YWFjYWFiZGUyMTA5YmUifQ==	2020-03-23 14:52:45.896817+00
iqz56s175awc5e27qwhr6l2ajp8nmljc	ZGU5MzVmNTMwMjFhMzEzNjc4MzM2OGQzYTM5YmMzMmVkNmVlYmZjMjp7Il9hdXRoX3VzZXJfaWQiOiIxMjQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NzQ4MjcwZDRkZGFiMGY4N2VhMzNlN2U4ZDE4OGQ5NTM4MWJkOWEzIn0=	2020-04-01 10:32:26.440772+00
jq4di37v9jvqfvcj9bf1cscyv5ijmljm	YjI1YTQ3NzRlNTVlODg5NjNmYmYzMDAwMzMwZDI1YjVkMjhmNTY3ODp7Il9hdXRoX3VzZXJfaWQiOiIxMzUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0NmJkYzY4OTUwMDYzNTk1YjUwYjllM2EzMWMxNDhkZmEzYTFmNjg3In0=	2020-04-08 04:49:02.967046+00
ysvbg5omap8zzg69pre23smepmeo82cf	NDY3OWNiMThhYWM1MGE4ZWUzYTQ4YjllNjNjZmI2NzUxMTczOTIzZjp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZGM1OGY5MjlkNzBkOTNkMmRiYmY5ODhkN2YwNjg2YjI4ZjNhM2ZiMCJ9	2020-02-25 01:19:47.44878+00
h7hejvnzt6ngc34n28f7vmki0n6achqw	MzEzNDdlNTM3ZmU0ZDYyODNhZDU2NmFiMzNlNzU2MDQ1YzQ5ODVlNDp7Il9hdXRoX3VzZXJfaWQiOiIzNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjdhYWUyOGZkODc3ODUwY2ZhNjRlY2EzYTQyODc0MTUwNjIxNjlhYTgifQ==	2020-03-17 09:26:42.42783+00
4zht87ocwi9gqng5wz7jte43nt3hr3zt	MDViNmY4Y2RhMTZmZTAzYWI2MWMyZmFlNmNmYTlkYzYxMDkxYzQ0MTp7Il9hdXRoX3VzZXJfaWQiOiIxMDciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3MWIxMmFiZTdjM2EwZWNhYWNmZWE0ZWYwYmI1YTFkNzlhMzU3NTJhIn0=	2020-03-23 19:06:17.538048+00
7anrki4yn2hxh9tvv1ih1z35eho5zgaw	NjFjNWRlYmJiZTE3MTFhOWEwYWQ4OTRkNDJjOTMwYTg4ZGNjNzQ1ZDp7Il9hdXRoX3VzZXJfaWQiOiI1MCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImIyOWI4MWQ5ODAwNzM4YzI1Y2NlNTkzNTI1NmI4NzZhMGYyNWEyNmEifQ==	2020-03-18 00:10:49.353116+00
1jwo2gimxyhdezqw6t03u1dy52ioha35	ZGIwZGZhMDhkNjg4Mjg3M2MwNzRmZWNkYTVmNjA4YjQ1YzMwNTZjMzp7Il9hdXRoX3VzZXJfaWQiOiI2NiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjNiYzhkZGNmMjljM2M0Zjg5ZDY1MDQ0M2U1ZmNlMzg0M2Q3ZGYzMTkifQ==	2020-03-19 03:32:10.201568+00
1iyvdlz082kp7krjj8wqv0by4hnftvse	YjdlMjQ4MDdhOGE0Y2U1NGQ5OWUxZjdmODQ2ZWFlMmNmODlhOWI4OTp7Il9hdXRoX3VzZXJfaWQiOiI4MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6Ijk0MThjZDU2NDYyZmJiZjU5ZDQ4OTI1MDU1ODZlNmE3NzBkMTNlMTMifQ==	2020-03-21 01:23:16.544094+00
w3920mzrd065ae5i4hn8mxyk4zw7keam	OTVmODJjYmM5MzFmOTI0OTAwYTI1YzcxNjBhZjgzMWNiMzZjMTY4Mjp7Il9hdXRoX3VzZXJfaWQiOiI5NCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6Ijg2YTZjNzJkMDc1ODY5MDRmZjJjMzdhMDM4OTA4YzQ5ZWM1M2QzZDQifQ==	2020-03-23 15:12:50.681806+00
vhx2b2ligouchs3p7ko9xgvv8amqj4k8	OWRhNDA0MzQ4NmJmZmNkMzM3MTM3YjJkZmYxNjI4NjBjMmU2OWY3MTp7Il9hdXRoX3VzZXJfaWQiOiIxMjAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxNTBjMzY0ODcxNGE5N2EyYjI3Mjk0NTc2ZjQwZDNkNDdlZmVjNWUzIn0=	2020-04-01 13:25:36.412419+00
jnyoe1nxocmi6d26lmhz60p2ypzraogt	MDIxODI5YzJkNWYwNTExNjYxZTU3MjI0NDgyYjcwODhlMjRkNDQ1Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5YTMwMTYwMDU5YTQ1ZDExNTU4ZmU5NTM0MTQxN2E1YTVkNWQ5YzdhIn0=	2020-04-08 18:38:22.288596+00
bldkwisn4383n7thhgmojn3yz956vi30	YWI3MDgzYjllMzMxZmZkM2I1NzU3NmZlNjEyMTY3OWZmMDBlNDQyNzp7Il9hdXRoX3VzZXJfaWQiOiI4IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiY2FiYWJjZmIxYWM0MTM2NWE3NDMzZjBiMTg1ZDgzNmVmMzQ5NDJhMyJ9	2020-02-25 04:08:56.471869+00
mzufmaun8iy83lja92z7gz3qdfn0r0ft	NWU4NGNkZTkxNDBjOWQyZjQyOWZmZWY3ZTdjZWNjYTJjZTE2NWQyZDp7Il9hdXRoX3VzZXJfaWQiOiIzNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjU5YzM3OTdkYWViMmQ0YjVhODJiMDk4NzMxYzI4M2I2YmNhMjNmY2IifQ==	2020-03-17 12:00:19.590517+00
5g6wsmztmcge0u9rg1u0jlxua643gwye	NWE3NTM4ZTM2YjZkMzcxNDc1ODJkYmU1NGNkZDQ2NDg5NTE3NGE2NTp7Il9hdXRoX3VzZXJfaWQiOiIxMDgiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxZmI5Njk2ZTMzYWE1NjQ3OGM4MzM4YTk0MTQ3MzA3ZDIzMjBjNzU5In0=	2020-03-23 19:28:45.08548+00
m7dhmga2ezuk5hfapacohdy424w8eptr	NDk4ZmM5ZmVmZjZlZjFmMDQyMzc0M2U4MGVkNDdiNzFkMGEzZDNhMzp7Il9hdXRoX3VzZXJfaWQiOiI1MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImNhM2IwNTVmMzVmMTNjZGZkODJhOWNhZjIxMTA2YjRhMDc5M2YyN2EifQ==	2020-03-18 00:25:05.525129+00
cfur97m0bbqv6brbjde5vovi4a9ntc0p	Yjk3NTdjMDdmOTljYzIxMTAzZWZlNDg5NzMzYmM3ODg4MTk1ZGYyNTp7Il9hdXRoX3VzZXJfaWQiOiIxMjUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyMjQ1ZGNkMzM5ODNlMjc1N2VkNDlmZTJhNmI4ZTM5ZmIxNGQ0ZGU3In0=	2020-04-02 02:53:12.008822+00
h6kd00qygkg2jb4nkqzxjw46xy6c0taz	MWE4Mzc0NmY4MTEwODZiZmM0YTVhOGIxNGM2MjljNDY1YmEwYzgxZDp7Il9hdXRoX3VzZXJfaWQiOiI5NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImE2NTRjY2Y0NDFjZjlkMTg4NTA5YjhlN2YyNmE4Y2NhOWY2YjY5NTMifQ==	2020-03-23 15:20:31.295487+00
c87v8ikum7mnxr8l56gsn3s64hpowoso	ZWU0ZWYzM2VjMzk4ZmJkYTE4MDY1ZDU3NjJlYWQ1MjliNjlhM2RiMDp7Il9hdXRoX3VzZXJfaWQiOiIxMzciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5ZTNlZmY1MGEzOWQxMDc4Nzc0MjU2NTBlYWY2NTBhNjU5MzE0NjY4In0=	2020-04-09 04:50:17.387707+00
5tvkihmbbz65qzpn70me5fyup7kvt00s	NjdmY2UzYTg1ZGM2MmFlZGI1NGI0Y2VlY2I0NzBjODcyZDczM2Q5Yzp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNWRkYTdiYTMyNmEyYjMwYWIwN2UzZmM2OTY5YmU0ODg0ZWFiNzFhNyJ9	2020-02-25 12:31:58.703116+00
0liotzbaxgqo82qu7z2mlodr3ob7g29q	ZDQwNTIzMmY2NjNkMmEzNWJhMTY5YWI5ODQxNDk0MjdiZmE4OWI1Yzp7Il9hdXRoX3VzZXJfaWQiOiIzNiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImI2ODYwMTFiNDgzNjJiYzc1Y2I0NjRjYTBhNjRjZTFhMGY3NTYxY2IifQ==	2020-03-17 12:51:38.592834+00
x0sqrdi4btf5w51m0kajixgm2o1t2um1	OTBlOTFkZjhjODZkNzhkYjlhZjQxZDdiZjcxZGZmNGM1NjI2Mjc0MTp7Il9hdXRoX3VzZXJfaWQiOiIxMDkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjNWQ3Yzk1N2FiZTFjZWQyNDkxN2IwMWVlNTY3OGE1MjVlNzVmZjEzIn0=	2020-03-23 19:30:44.923546+00
ho1e775qfl4wvm9s4931iqmbwfovsnts	OGI4MDBkMzBiMGM4M2Q2NGM5NjBjZGE2OWJjYTM0OWI0ZjlkNzFmODp7Il9hdXRoX3VzZXJfaWQiOiI1MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImNmNzQ4MDliMTM4NjNjODIyNmE1MWViN2IwZGJkODYzM2Q5MTdmMDEifQ==	2020-03-18 00:39:55.078179+00
jv3brdzuxci42h1d8bag2cad9xv769ny	YTVjNjdjMDZkNWJkMzQ1YWUxNDI0OTE5ZDljMTgxMzFlMTc3MzM4ODp7Il9hdXRoX3VzZXJfaWQiOiI2NyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImVhNWI3M2FlOTFhNzI0ZGQ4OGVkYjQ2YzNiOGJjOTFkZjI0YzRlNjIifQ==	2020-03-19 14:15:52.918254+00
mm1279pcgjwe1ugee6zxxrhuwhruncat	OWRhNDA0MzQ4NmJmZmNkMzM3MTM3YjJkZmYxNjI4NjBjMmU2OWY3MTp7Il9hdXRoX3VzZXJfaWQiOiIxMjAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxNTBjMzY0ODcxNGE5N2EyYjI3Mjk0NTc2ZjQwZDNkNDdlZmVjNWUzIn0=	2020-03-26 06:04:11.409064+00
ozc0ixebxqz55hxi1dx08y8ds3crf3ne	MjgxNjRmODRhZDIwZGFmYjg0NWYwMmUzYTIyZjZhZmYwNDRlYzBlNzp7Il9hdXRoX3VzZXJfaWQiOiI4MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImEyMTZiOTU0ZTQ2MGQ2YzlkM2Y4MGQzNjM4Y2E2MGZhN2E0ZTU4OTcifQ==	2020-03-21 06:01:17.029324+00
oq5fqnge8ujj4p82yxvxolzse0lfnx5x	YzI0OTZkODNhY2MxYWM1OTg5MjE1ZWY0ZDJjYTk1NDU0NDVkNzJiYTp7Il9hdXRoX3VzZXJfaWQiOiI5NiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjAyNTNiYjZkMzFjYmExODEwMjFiNDIwOTc3YTQxYmQ1ZGMzMjY5N2QifQ==	2020-03-23 15:47:23.429665+00
17zbt8a35ufyvpfaw43sl57cqy147dbe	YTE4ZjZiOWNlNzE1M2Q4MGEwMTUzOWE2N2MzYzM1NTFkMzYyNGNhZjp7Il9hdXRoX3VzZXJfaWQiOiIxMjYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiNGQ0YWI5NjUzMjVlYTRlYzY1NDdkNGFmYmQ2MzQ3MTZkYTZjMGEwIn0=	2020-04-02 20:09:08.990963+00
m7xjtk2zx3eeuxlxq0awiyhf48rlxj6m	NmFjZmIzYWJlNDM5OTdiMGQ2Y2RiNjA0Y2JiY2ZjMjdjY2VjMDUyMjp7Il9hdXRoX3VzZXJfaWQiOiIxMzgiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwZjgxMmFjMDViNGFlYzgzMDZjN2EwNzg4YTE0ZTQ2MWY2NzcwZjgxIn0=	2020-04-11 13:38:41.104793+00
9j5659dgczo0kzcpeih9d7b6tbj6cldw	OTI3YWQ1YTRkNWYxZWRhMzRmYTA4ODk4MDAyNDgyMWEzNGM3MGQxODp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiNmE2NTI0Y2EzODU2NjQ0YWE4ZDAxMjVkZmEyMDNkN2FkZTNhZmY1OCJ9	2020-02-26 17:45:56.343964+00
h9k5jg3v1dmhsgs8hxr8ozsknt4s0m34	YTg5MjY1OGI2OTA2MjFiZjc3YTU4ZDllYzY3MzM4NGQ2NWYzNWQ4MTp7Il9hdXRoX3VzZXJfaWQiOiIzNyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImNiNzhiMGY3YWViNTIyN2RhZjA0ZGYwYzFmYWEyNzYzYTY4NDliYzcifQ==	2020-03-17 13:04:02.511573+00
f9ywfs17omz7dsbmx2g7yi2gss93xurj	YTZiYzFmMTFlNDAyNGE0YzVlMDBkMzM2ODRjODZmZTQ3MjVlMmQ1ZTp7Il9hdXRoX3VzZXJfaWQiOiIxMTAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlZjU0MWFjOTJmZDMzOWEzODdlNGMwNDcyODlmM2EwYjdjZTlhMjRiIn0=	2020-03-23 19:49:41.412465+00
jp4nuzm7c9l89p90essodlqe5cflpzai	ODE5NWZlNmQ3Y2JjYzMxNWM1NThkYTI3NGQ3YTg5MzM2M2NmMjY3MDp7Il9hdXRoX3VzZXJfaWQiOiI1MyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjYzMjViOWE2NDc1Y2JkNjUzYTZmZGUxMzk2YWQ5NGEyZDNjYjNmMWUifQ==	2020-03-18 00:40:49.024083+00
63tpx50n06od49p3l4mxkzrx4kd7o9z3	ZjQxODdkMzJhMjM1YTQwN2FmNGQ0ZDc2YzdlYjViZTc2ZDRhMDY2YTp7Il9hdXRoX3VzZXJfaWQiOiI2OCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjIxNDU5ZjdhZjRmOWY5Y2MwMjY4NjA0ZDhkYzliYTU3MDFkN2ZjM2EifQ==	2020-03-19 15:22:35.495494+00
u3ek9o89yxx3xxuhgp7wmglb1oiuju7g	OWRhNDA0MzQ4NmJmZmNkMzM3MTM3YjJkZmYxNjI4NjBjMmU2OWY3MTp7Il9hdXRoX3VzZXJfaWQiOiIxMjAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxNTBjMzY0ODcxNGE5N2EyYjI3Mjk0NTc2ZjQwZDNkNDdlZmVjNWUzIn0=	2020-03-26 06:08:08.572393+00
0tph7no2jf7bfje7fib3jn1c304bn7aj	ZmRjZjdhMDc2OWYzYWQ4MGM4MTk3ZDRlM2VlYzY5NjljYWE4OTYzZjp7Il9hdXRoX3VzZXJfaWQiOiI4MyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjRiNmI0NDc0MzgwYjQyZGZiYjQ0M2JlY2Y1ZjdiZTY3MzFkN2Y2MzUifQ==	2020-03-21 07:59:14.289807+00
1jkoqcab7j9pltnh28q7ayxn41qhub46	NjIyYWRkZDg0YzZjYTIxNTdiNzQ2OGI5ZTUyZmViMGY5ZWVjODhjMTp7Il9hdXRoX3VzZXJfaWQiOiI5NyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjNmODdmMzFhNDE4YWUwZTBlZmY3M2MxMTk2YmE1ZWI5NzU0M2QzNzEifQ==	2020-03-23 16:01:38.784556+00
h7xupj82sig63rhp3z0u8qpgaeb3slrb	MDFhMTY3Y2JmODdkYWFhN2FlZDdiNzk0ZGZmOGUyNzE3NGFjZjNhZjp7Il9hdXRoX3VzZXJfaWQiOiIxMjciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5Nzk3Yjc3MTRmOWMxOTJkYjkzOTJkMWE1ZTMzY2E1ZWZlNDc0MzdkIn0=	2020-04-02 20:20:24.557799+00
wq0cmt8tvndl40cguq9gchzwzkpancmt	OGI4MDBkMzBiMGM4M2Q2NGM5NjBjZGE2OWJjYTM0OWI0ZjlkNzFmODp7Il9hdXRoX3VzZXJfaWQiOiI1MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImNmNzQ4MDliMTM4NjNjODIyNmE1MWViN2IwZGJkODYzM2Q5MTdmMDEifQ==	2020-04-14 04:01:53.512784+00
4qkkdm9oyn4m8t0k01ec4krsjaqpf7om	NDY3OWNiMThhYWM1MGE4ZWUzYTQ4YjllNjNjZmI2NzUxMTczOTIzZjp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZGM1OGY5MjlkNzBkOTNkMmRiYmY5ODhkN2YwNjg2YjI4ZjNhM2ZiMCJ9	2020-02-27 01:27:25.948142+00
pxbugdvdpewz4l8usk12fvr117ng5rqw	N2MzNDdhNTNmZjNiYjY4MDQ4YjZlOTM0YzUwNmQ0NmRmZjcyNjcyYTp7Il9hdXRoX3VzZXJfaWQiOiIzOCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjM3ZGRkYjgzYWM4NzA3YzRhZjMzNzAzNTc4NzVhZTM4NTc5NGVhNjcifQ==	2020-03-17 13:29:17.615438+00
40ogymmjjcawocsisrvoqal7hzfsjfl0	NWQ0MDllNGY3YWE4ZDQyNzkxMWRjYzYyZjg4ZWE0OTk0NjJhZDllYTp7Il9hdXRoX3VzZXJfaWQiOiIxMTEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0YjEyNGYxZDdlZjdjZTYyOTJjMTliZGI1MTM2ODY5YzY4N2Q5MGY5In0=	2020-03-23 21:23:54.469452+00
rwoguu8yfldo39nkih9e6sy4snlfispp	MDdjZTU2ZGI4Mzk0OTQzM2ExYmMwMGEzMjM0Y2RjMjYzYTQxYzBhZDp7Il9hdXRoX3VzZXJfaWQiOiI1NCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjgzOTRlOTg1NWIxMDA5NjFjODYzM2M1MjYzNjM4MjI5ZGZiOTdjYjAifQ==	2020-03-18 04:29:19.316332+00
ykh6pzdvrqtx1tntvtyibt7247lzq1u3	YjYwODUwOGFhNzY4MmJlMDM1N2ZiMDZhZDA1MWQ2MWExYTAwZTRiYTp7Il9hdXRoX3VzZXJfaWQiOiI2OSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjU4N2UwMjkzMzEyN2FjMTU0ZmZlMjBiODc1NTJkZTdlOGRlZjkxODUifQ==	2020-03-19 20:57:57.052953+00
38vq5iyg7nas2tk00mxzyjp5ito8irp6	OWRhNDA0MzQ4NmJmZmNkMzM3MTM3YjJkZmYxNjI4NjBjMmU2OWY3MTp7Il9hdXRoX3VzZXJfaWQiOiIxMjAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxNTBjMzY0ODcxNGE5N2EyYjI3Mjk0NTc2ZjQwZDNkNDdlZmVjNWUzIn0=	2020-03-26 06:35:37.935473+00
389gghwzgymwa7wjbnytf1m8hl9tzasj	MzNlM2NhMmZlM2IwZWFiNDhlN2IxNWQzOTQ3NzliMTcxNTk4YmY3Yzp7Il9hdXRoX3VzZXJfaWQiOiI4NCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjQzOGM2ZjgyMzliZGU1ZWVmZmYyMjUzMjA5MDdjYzQyZTIzYWMwM2EifQ==	2020-03-21 16:26:28.611161+00
kth1filc2d5nop8rezjr1u339tfxdz3f	NzJlNGMyZTE0ODczNjE5MzcxMjdkNzdjYzc1YmJmMzkwZGNhOWMwOTp7Il9hdXRoX3VzZXJfaWQiOiI5OCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImI1NzQ1M2MwYjAzMGM2ODhjNjZlYWFkYzNiZTQ1Njc5OGM1NmIyMmMifQ==	2020-03-23 16:02:12.526205+00
k3jso1t77gkh41vqxbke8m8xlqpjx7pw	OWRhNDA0MzQ4NmJmZmNkMzM3MTM3YjJkZmYxNjI4NjBjMmU2OWY3MTp7Il9hdXRoX3VzZXJfaWQiOiIxMjAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxNTBjMzY0ODcxNGE5N2EyYjI3Mjk0NTc2ZjQwZDNkNDdlZmVjNWUzIn0=	2020-04-03 05:21:52.679478+00
urk12av4b3pvpqo7rixm1mwkvztxqoja	YTQ5NTBkYTdlZTdiZDkzOTE2MDkzYWQzOWNlNzRkYjE0MjFiN2ZiNTp7Il9hdXRoX3VzZXJfaWQiOiIxMzkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxNTgwNDg1MDY4YjM5YjdlODU4OGE2Y2ZmZjcwNzU5NzU5ZTU4MWJhIn0=	2020-04-14 15:59:49.144612+00
z36eeim2fb8qotyb3jt17w222jjzto8d	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-02-28 09:45:46.173843+00
mobfx3xb624ybrd3qhmpj22a7l10ei13	YzFhZGQ1MzhhYzYwYTY4NzEzNTZiOWRjMmMwNzIwMDA0OTFlZGM2Yjp7Il9hdXRoX3VzZXJfaWQiOiIzOSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjM4NDU5NjI1NTk3YzFhNWRkOTg0MmI1MDgzNGQ4ZjYxM2I0ZGQyNTQifQ==	2020-03-17 14:01:47.133391+00
hvb9mgmma7pkzhd24yj612ngkl6p5fo8	ZjU5YzliYTkwZTU4MThiYzI4ODQwZTdjM2E2YThmZmI5ZmE3YzZmMzp7Il9hdXRoX3VzZXJfaWQiOiIxMTIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIzZWY5NTQxYjNmNWI2NWNkZDg2NjYxOGZhZjNkMjEyMGRhNTI0NzgzIn0=	2020-03-23 23:22:28.100032+00
nubkt0vrv3wkvkzzb3ylmtyibvrzimmk	ODAwMjI3MTM0NDU1NDNmZWZjMjY1OTZmN2JjOTQwZTIzODZlMWQ0Njp7Il9hdXRoX3VzZXJfaWQiOiI3MCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjYyNzFjM2Y4YzAzZGQ5ZDQxMWMwY2ZlNmFjNDVlYjAyNmI4NTI3NGQifQ==	2020-03-19 22:49:28.025096+00
vfvuyjnn0iuof1qf4u2dm48t3pkv2hy1	MzNjYzc2NjBhNmFmOGNiNDg5YmJiMDM2MDE2ZGJlMWUwODdjNGJiMzp7Il9hdXRoX3VzZXJfaWQiOiI4NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6Ijk2MzFmMzllOTNmZDMzZjgxMzcwMGFhNzkyZGZmMmU3MmEwNDBmNTQifQ==	2020-03-21 16:33:15.288551+00
4mj8g9gsy97mqab49l8o12jpvy8txgwr	OWRhNDA0MzQ4NmJmZmNkMzM3MTM3YjJkZmYxNjI4NjBjMmU2OWY3MTp7Il9hdXRoX3VzZXJfaWQiOiIxMjAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxNTBjMzY0ODcxNGE5N2EyYjI3Mjk0NTc2ZjQwZDNkNDdlZmVjNWUzIn0=	2020-04-03 09:55:44.857457+00
unvlhup2qz20miez4onsiuamgcx6efq8	YmNlMTQ3N2E4YzVlNmU2NmM3YmRkZjI5MGEzMTM5ZGUzY2VjNzc1ZTp7Il9hdXRoX3VzZXJfaWQiOiI5OSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6Ijg2MWEwYjgwNTQxMGNlNzQ4ZGM4MTg3YTIwYzlmNDY2NjI2NDY3MDgifQ==	2020-03-23 16:02:50.269529+00
swpohxihwyg7lw437rad2layezzyasef	NDY3OWNiMThhYWM1MGE4ZWUzYTQ4YjllNjNjZmI2NzUxMTczOTIzZjp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZGM1OGY5MjlkNzBkOTNkMmRiYmY5ODhkN2YwNjg2YjI4ZjNhM2ZiMCJ9	2020-03-01 17:51:52.515316+00
h2xkvtezci7ekmjs1k3r5dvmptwfaurj	MzBjYWE4ZjcyODI5NGY4YTg0NzU0Njk5ODEyZjJjNDgyMGNlZDczNTp7Il9hdXRoX3VzZXJfaWQiOiI0MCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjM4ZjY5N2QzYTVmZDllNTg0ZGVlYjI3NWVmNTUyY2RiY2VmMDZkMWMifQ==	2020-03-17 14:02:44.665876+00
2d8gzv1y1o9ac1xzv5rnic3mln04429x	M2U2YjdhYzZlNGY2ZjQ0ZDdlY2E3NThhYTYzOGY3YjUwYTAwMjkxZTp7Il9hdXRoX3VzZXJfaWQiOiI1NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjA2OTlkZDM2ZDdlZDkyM2Q3MDY0YjcyNDVkNjJjZDZhZjBjNTFjZGIifQ==	2020-03-18 15:04:22.982784+00
7e0umrtf4i46bsdqmf5sayiq1vc0rvje	OWYyMDY5YmQwN2VhMWU2MDNjZDc0ZGM3N2ViZTRhNDg2MTM1ZTE5NTp7Il9hdXRoX3VzZXJfaWQiOiI3MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImU3N2M2M2U3MTlhNTVlOWRhNzcxN2E3MzVmM2NiMWMwYjcwOWRhZmQifQ==	2020-03-20 01:40:24.525809+00
31aq2zylvzuneers3ddv2tza2n2jze69	M2RlMmEzMDJlYjNlNzNiNTk2YTZkM2VkOGFlNTZmMDk3ZDc5MjI0YTp7Il9hdXRoX3VzZXJfaWQiOiIxMjEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiYTgwYjhkNDk4ZTcxOWJmMDhjZDdkODQzN2IyNjU1MTcyYWY3ODA2In0=	2020-03-27 05:58:48.186831+00
4j76izle7kcsjxiwf4pjbi7p6fyjsdxm	ZGQyMTVkOTM2OTdlNTk3OTQxYmE4YjEyNDk3MGU2ODdhNzYyNzIxNDp7Il9hdXRoX3VzZXJfaWQiOiI4NiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImU1OGZlNDdmZWQxNTRiNWMxNjA5MDdkMjk1NWFiMTQ5YmU2ZmUxMWUifQ==	2020-03-22 00:25:01.051105+00
dtezvfy3jfvy02463zywqtybedlwwrp3	NWI0OTc1YzE3NGNjZmVmNzMyYmNlZDFmMjU5MjUwZDViNmY0YjJkNDp7Il9hdXRoX3VzZXJfaWQiOiIxMDAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1MWRhZmExZjI3YmNmYTdjNjE0ZDBkZTk4ZTA4ZWI2NzZjZGQ3NTc3In0=	2020-03-23 16:38:53.505461+00
grkfp6my82v3j4ljc7ixrncoamluy1ns	YTE4ZjZiOWNlNzE1M2Q4MGEwMTUzOWE2N2MzYzM1NTFkMzYyNGNhZjp7Il9hdXRoX3VzZXJfaWQiOiIxMjYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiNGQ0YWI5NjUzMjVlYTRlYzY1NDdkNGFmYmQ2MzQ3MTZkYTZjMGEwIn0=	2020-04-05 03:20:02.032955+00
gkn1n6vsj2789fzbn3pamp3knr1ayzb4	YTZjOWI5YzRiOGExNmYzYzMxY2UwYTRmY2Y0MzAzZDIxNmUwODc5MDp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImM4YmIwN2EzMDQ0YjY5MDIxMjJlYTU0YjVlMjkxNjNhZjY4MDY1NzUifQ==	2020-03-02 19:01:27.701582+00
kdifkszf0x8jgmxvdg9iuu7j4jnmnker	MmIxMDk2ODA1MzE1NTcwMDVhNjdiYzRjMTI5NmExZThkNTgyYTIxNzp7Il9hdXRoX3VzZXJfaWQiOiI0MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6Ijg5YjY2YzcxZjE3NzhkOGUwMjIxNWRlOTAzN2I1NWJkY2NmNDQxYmQifQ==	2020-03-17 15:36:47.389338+00
0lmvsn3b5iqg73lxc4xvy6a4ugfcdxw3	Zjc4MzhkMzcyYmQ0ZTA2MDhhMTM3ZWYzZDdlZTQxYjU1MTQ5NjlkNjp7Il9hdXRoX3VzZXJfaWQiOiIxMTMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5NjRiNzk2OTAyYWZiMWQ4NDUxNjgzYmIyMDg0NjczYjc2NzMwMGFhIn0=	2020-03-24 02:39:09.739611+00
x90xqapyk9frufdigs95tdu84zkv5iau	YzBlOTI0N2RkZWI2NTc5MWQzNDliNjA5N2FkNWIyODBmMWZjMWFlYjp7Il9hdXRoX3VzZXJfaWQiOiI1NiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjcyOWM0MGYzZjYxZjA2NWQ3NGUwZDI2MGNlOTNlYTE2ZjEyNDlmNmQifQ==	2020-03-18 15:06:39.44885+00
i0g724gsnp5tumc8lkdfi2jinsoggbcy	ODU3YzQxZjVlOGFhNGQzNjE3YWQ3M2EzZDMyNjdjNDI5MWI0Nzk5Njp7Il9hdXRoX3VzZXJfaWQiOiI3MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjMyMjk2YWZiNWFmZjIwMWFkNDk0NWQwYmUzYzg3ODQzMWE5ZGMwMzEifQ==	2020-03-20 02:12:02.349592+00
49ucjdvrrnu3u45jnoh38hrtlieczjzk	OWRhNDA0MzQ4NmJmZmNkMzM3MTM3YjJkZmYxNjI4NjBjMmU2OWY3MTp7Il9hdXRoX3VzZXJfaWQiOiIxMjAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxNTBjMzY0ODcxNGE5N2EyYjI3Mjk0NTc2ZjQwZDNkNDdlZmVjNWUzIn0=	2020-03-27 10:29:27.297204+00
1hlmjvmgidxikpd0np73p4d8ocp1odmx	Y2Y5NzFmMTRiZWI3M2YwNjU3NDM3MDQ2OWU4OWJkZTc1MDUyY2YyYTp7Il9hdXRoX3VzZXJfaWQiOiI4NyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImQzMmY4MTYzOGViMWUwODgzZGMwM2Q5Y2UxOGFjMDNkZjhjNzY5MjAifQ==	2020-03-22 03:08:42.656357+00
uhue4bmy13s08utr8xd04gdvpdi84jix	YTQxMDdkZDA1M2M5MTJjZmNlZWUyODc2ZTgyODgwYzk5NWE1OTUyZTp7Il9hdXRoX3VzZXJfaWQiOiIxMDEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmYWJlMDI1NjA3YzBjZjI5ZTJlNWRkNTA5ZDQ1YTRhMjBmNTM2ZTY1In0=	2020-03-23 16:39:34.463328+00
g7ey45moaf0j73z63ina6b8ieunp5uwp	M2MyZmEyN2U2NTA0YzAyY2RkY2FiMjljY2VjNmMwMzAwMTgzNDk5ZTp7Il9hdXRoX3VzZXJfaWQiOiIxMjgiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhMDY2OTc3Mjc3MzAzNGMwZjA4Nzg3MTM5MWY3MGExYzJjMmVhODE1In0=	2020-04-05 04:03:28.27225+00
04utrdu82k6mkkbst5x0rshxbvrv928e	YTZjOWI5YzRiOGExNmYzYzMxY2UwYTRmY2Y0MzAzZDIxNmUwODc5MDp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImM4YmIwN2EzMDQ0YjY5MDIxMjJlYTU0YjVlMjkxNjNhZjY4MDY1NzUifQ==	2020-03-02 22:55:06.280399+00
w5x1zsf3yp20fj5x5v4soywro74rc1ve	ZmM5MTAwOTVkNzM2NmE2ZmVkNjhjNGUwNDE3MmJkNzAwYzNhY2M0ZTp7Il9hdXRoX3VzZXJfaWQiOiI0MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjkxMDMxOTIwNzVmMTc5ZmUyYzBiNDE5NzYyMWVlNzFhNDgxMzFlOGYifQ==	2020-03-17 16:56:25.060591+00
qh9idprocwj2ggtyt7irn8tx0uhv4cqj	NTkxMDYwODk2NzVlMDE1NThiYTczN2ZkYjZjNDIwZTU4N2ZkNzFkMTp7Il9hdXRoX3VzZXJfaWQiOiIxMTQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZmMwODcyN2EzMWRiZWQxZTI5MDBiMWQzNDEzNTNkMmFhYTNkOTQ4In0=	2020-03-24 04:19:28.328062+00
5rhkgc2wja6vdaqqd4odlv77m6ahvljn	NDNiNzA2YzE2ZWNkMmE3MGY5Y2YxNDhiMTAzNTc4N2RjOGEzNjZlYjp7Il9hdXRoX3VzZXJfaWQiOiI1NyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjNhMzE3MmY4MDJjMjU2ZjRjZTg5ZDdiYjMxNGY5YWExN2RhNWNlMDAifQ==	2020-03-18 17:42:29.039499+00
0cq18ibpygipn2kt4s473e3thnhh1f6m	MzkxNWIyYWRjMjUyMzA0MjdlY2RiMDA3YTI5MDEzZTc1NWNhZmJiMDp7Il9hdXRoX3VzZXJfaWQiOiI3MyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImYwMjBkYWFhOWIyYmE2YzQ1NTA3MDM2YTVmMDA2NDc0YjljMWEyYWUifQ==	2020-03-20 03:56:03.890162+00
ajwhwlh37648kqpdpsdfj0ixuv9zgt7o	ZjFhNTBmNmMyZTZlZTlmYzNiNzk5NDNhOGM1ZTBiNjI0ODQwYTRjNDp7Il9hdXRoX3VzZXJfaWQiOiIxMjkiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJkNGY3MmFmM2YyMWNhMzJlMGVlMjNkNTVkZmFlYTYyODZiYWNiODg1In0=	2020-04-06 03:37:34.746298+00
rd7inaqptz3223crcx96prnzzu0jkmrb	ZjA5MGU2MDlhYTJhYjliZjgxYTJhNGNiMTYwMDRkODdkYTdjYmFlMzp7Il9hdXRoX3VzZXJfaWQiOiIxMDIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MTAyN2QwNjk3MDNmZmZmNTYyMjQzODQwMzM1OGI0MjdhMWU1M2ZhIn0=	2020-03-23 17:49:21.895109+00
aay2de2k61wispsxj47cpsdsnb7kckfd	YTZjOWI5YzRiOGExNmYzYzMxY2UwYTRmY2Y0MzAzZDIxNmUwODc5MDp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImM4YmIwN2EzMDQ0YjY5MDIxMjJlYTU0YjVlMjkxNjNhZjY4MDY1NzUifQ==	2020-03-03 17:53:58.739404+00
fy2hllnfex53bpxg4slrr881za1kzzs5	OTNmNjQ4OWI1ZjU0N2Y0MzVlYzQ5ZmM4OWE0OTRlMjQ5NGU4ZTk2Yzp7Il9hdXRoX3VzZXJfaWQiOiI0MyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImJmYTM1ZTI2NzUyMzk0ZjFkOTI5YzEwMzA2NWIyNDBjMDE3YmFlOGMifQ==	2020-03-17 17:31:00.733468+00
67pkt3k91vvn2ksi41i3vsz44qo4khno	YWYxMWNmNDIyNzhkNDM2NWZlNDU2M2RmYzQ4NGE1OWIwMDI2MGFhNjp7Il9hdXRoX3VzZXJfaWQiOiIxMTUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhNWRjZWU4YWQyZmVlNWY5ODdhZDk4YjM3MTNhZWJmNzg2YTFiMzYzIn0=	2020-03-24 07:24:03.550444+00
lyi8yslafjx8rll7snmey0at2web9i1u	OTdmMGQ5N2I4NWYzM2JkMjlkNWEyYjQ1NzdiOWFlYTUxZGIzYWFiYzp7Il9hdXRoX3VzZXJfaWQiOiI1OCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjNlNzVmMTU4MmE5YTM0ZWM0MmM1Y2M1ZjU3MmNhZGI0NTU4MjZlYmEifQ==	2020-03-18 19:43:03.436154+00
1exwsdyb119mfca3yl6bqta4rrwtnlws	OWRhNDA0MzQ4NmJmZmNkMzM3MTM3YjJkZmYxNjI4NjBjMmU2OWY3MTp7Il9hdXRoX3VzZXJfaWQiOiIxMjAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxNTBjMzY0ODcxNGE5N2EyYjI3Mjk0NTc2ZjQwZDNkNDdlZmVjNWUzIn0=	2020-03-30 06:22:29.591282+00
xhe4u6ogwdp8byqkzwiqgrg8f1ngzxpx	MmY0N2NmZjA1ZjZkMTk3YjQ2NjFhNzczODFkYTE1OGU0M2ExOGVlMzp7Il9hdXRoX3VzZXJfaWQiOiI4OCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImVmODllOTk1ZTdhNGIxOWYwZjNmNTZmMDZmMjIwNGZmYTUxODk5YTIifQ==	2020-03-22 07:39:31.470676+00
ccn43sll0vv9r7s8a73dib605zg2jrb3	ZmJlMGIxOGYzYWE5NGQxOTdhZTljMjBhMWJhMjA2NDg2YjcyN2RmZDp7Il9hdXRoX3VzZXJfaWQiOiIxMzAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhNzBkY2NmMzkyNWE1ZDQ2YWM0YjNkN2Y5NjZjM2E5OTc5NjRkYmRhIn0=	2020-04-06 09:20:13.741998+00
2nd1vmxrgs3ith1i9lkthvems82y8brs	ZWNkYzEyODg1ZDA1ZGY5ZDA4NWY2YzI1ODlhMmRhZGE1YjM4MWZiZDp7Il9hdXRoX3VzZXJfaWQiOiIxMDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyNzhmNDBiN2JiZTcyYWMwNTYzOWQxMzAwYmQ3MTNlOTI1MTE1ODRjIn0=	2020-03-23 17:57:04.382554+00
z5hg2vqksgrlnvyy35bn0n1ljq0hn4ed	NDY3OWNiMThhYWM1MGE4ZWUzYTQ4YjllNjNjZmI2NzUxMTczOTIzZjp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZGM1OGY5MjlkNzBkOTNkMmRiYmY5ODhkN2YwNjg2YjI4ZjNhM2ZiMCJ9	2020-03-04 03:28:20.832433+00
zshufjdij1usrdxdgz2ici83rd8jicy9	NWFjMjI1YmYwOGI2NDFlYjM0ODk0ZGQ5MGY0NWY2ZThlZmJlMTQ3Njp7Il9hdXRoX3VzZXJfaWQiOiI0NCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjA2NjIzZDc0ODRlYjRhN2UxZDkzYmQ1ODM3ODRlZGVhNGRjZjBmMGIifQ==	2020-03-17 18:12:19.240693+00
zdm6nwvro1davll8lxhv6fqld5lvfowe	NGRiMGExYTY3YmZkZTkyMmJlNmY4NjRiMjhiYTY5NTAzZTY1NGJmNDp7Il9hdXRoX3VzZXJfaWQiOiIxMTYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3OWJiZDgxNjc3YWVkZjE3OGIwNjA2NGRiMTQyNjFjYTFjMjgyMmYzIn0=	2020-03-24 12:43:24.945091+00
y33d27917952g9rjbqxx2zk81onkh1x8	YmVjY2UyZGNmYjM5ZmY1MDMxODEzMGZhMzkxMGYyMTkxZTQ4M2YyZjp7Il9hdXRoX3VzZXJfaWQiOiI1OSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImM0MmYwOGQ0NmVkNTExZTI5M2EzNmQzOGUwMTNjMmFkZjZiZGE5NDYifQ==	2020-03-18 20:28:50.827309+00
ps8v51lx3eflfwi5k0fjd5nl9a14chvz	ZTFiNTRlMDM0N2ZjMjhmMTFjODdlNWRlOTAxZGQzNmU5ZmY3ZDFlNDp7Il9hdXRoX3VzZXJfaWQiOiI3NCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjRmZjhjZDljNTVhYjQwMzA3NDI1ODU1NDE3YzA2MjRiMzNlOGZlMjIifQ==	2020-03-20 15:57:10.624358+00
ggsr9i7q5ed8hohv0mdi9br8jpjk23ib	OWRhNDA0MzQ4NmJmZmNkMzM3MTM3YjJkZmYxNjI4NjBjMmU2OWY3MTp7Il9hdXRoX3VzZXJfaWQiOiIxMjAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxNTBjMzY0ODcxNGE5N2EyYjI3Mjk0NTc2ZjQwZDNkNDdlZmVjNWUzIn0=	2020-03-30 13:20:41.461249+00
xew7u02rifx8448cymzb73qa4o5dx99t	YjdlMjQ4MDdhOGE0Y2U1NGQ5OWUxZjdmODQ2ZWFlMmNmODlhOWI4OTp7Il9hdXRoX3VzZXJfaWQiOiI4MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6Ijk0MThjZDU2NDYyZmJiZjU5ZDQ4OTI1MDU1ODZlNmE3NzBkMTNlMTMifQ==	2020-03-23 01:12:17.114056+00
wbdsiubhd3nerzmauj5190cp3nrqviag	MDc5ZmIzNjVmYTlhMTdmN2FiODQ1NDNlNTllYTIzOTQ5OTJiZWI0Nzp7Il9hdXRoX3VzZXJfaWQiOiIxMzEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJmNmYxMDU5MzExODU4ODJkNDQxMWZlOGE2ZWI5MmUxNjU0NjQ5YjdkIn0=	2020-04-07 05:57:30.699584+00
bjt516hlkvay3qm5fca7nknt7bonao1y	ZjRkMTc0ZTYyMThmNjQ0ZjU3MjZlMzk2YTM1MDZiYmYzYWUwN2JjOTp7Il9hdXRoX3VzZXJfaWQiOiIxMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjNiNzU0ZTNiODQ0MTY0ZTRkYjgyYTJkNTQ0MjE0N2ViZmJmYzk5MjUifQ==	2020-03-04 18:26:38.803038+00
u9jnnmn5omcwglzx1v1409knp0suxpqr	YWE4NzlmODJhZDFkMDVjZTczY2UxODk4NmE3OGQ2YjkzYzk0ZjY2ZTp7Il9hdXRoX3VzZXJfaWQiOiI0NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImU1NTQ3YTMzZGNjMGQ2ZGQwNmM0NGU1NWE3MTJiM2QxN2Q3OGViY2MifQ==	2020-03-17 18:23:16.288654+00
7hmackqrraoz0pf5n252gyf8bg62xwq1	NTZlMGNjN2NmYzUyNWQyYjM2NDdlZWU4ZDE4OGNiN2Q2ODVkNGQxNDp7Il9hdXRoX3VzZXJfaWQiOiIxMTciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI0OTUzOTdjMmNjMzhiN2YxZTkyMmQ4ZDNmOTg0MTNiMDhmZDAyMTZjIn0=	2020-03-24 13:55:01.469084+00
js886ojaspfukg9tiqjp22wnihc2m19q	ZjQ2OTk0YzNlM2IwMGVjNzFhMmVmZjBkYWUzNmYzMzVmMDg4MzkwNjp7Il9hdXRoX3VzZXJfaWQiOiI2MCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImZmZDRjOTQ0NDJlYWM2Zjk0Yzg4NTY5ZWQ5NjE4ODU4Nzk0NjJkMWUifQ==	2020-03-19 00:49:21.256537+00
0z8qcw79n5reuu7nh74jpwgf404btl19	NzZhZjc3OTlkMDdhZjE3YTA5ZjNjMjQ4ZWIyZjA5YWZjYTdiOTQ1YTp7Il9hdXRoX3VzZXJfaWQiOiI3NSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjdjZjEzMzVmNzM5ZDRiOGE3NmYxNjdlN2ZlOGRjNzBiN2M2ZjNhOGMifQ==	2020-03-20 16:09:11.201403+00
d9ce1fbdmjbps48n3ucepiitnt00i96v	YTc4MzJjODY0NjdmZGI1MGI3MjM2OTdhMDkyZjk4YjExNjRlNzBhZDp7Il9hdXRoX3VzZXJfaWQiOiIxMjIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIwYjM1ZDRlMTVmYTExMzVjMGE2MzFlNGRkMWFhNTNkNDQ1MDkxY2NiIn0=	2020-03-30 17:11:06.145869+00
094lezn06endi0mfzlv587ewk0jsoxod	NDY3OWNiMThhYWM1MGE4ZWUzYTQ4YjllNjNjZmI2NzUxMTczOTIzZjp7Il9hdXRoX3VzZXJfaWQiOiI3IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiZGM1OGY5MjlkNzBkOTNkMmRiYmY5ODhkN2YwNjg2YjI4ZjNhM2ZiMCJ9	2020-03-23 01:41:55.538499+00
zajtl9vykvbt7119no8w0iwkolz5ud7f	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-04-07 07:03:55.700754+00
knom1zyklezstsj8xb7jgs2tbp0xz0gu	MmQ2MmFkNTM2ZDkyZDJkYmZhZDIyZTc4NjFlODBjZDJkODgxZjk0NDp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImYyMDk5YjA4MGY4OWExZWM4ZmU5OTY4MjVhZmE0MTQ5ZGQyMjUyMmQifQ==	2020-03-06 14:08:01.93854+00
iy9nopzjwf9vo7ny9o5hrrftn0zc7c29	N2MzNDdhNTNmZjNiYjY4MDQ4YjZlOTM0YzUwNmQ0NmRmZjcyNjcyYTp7Il9hdXRoX3VzZXJfaWQiOiIzOCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjM3ZGRkYjgzYWM4NzA3YzRhZjMzNzAzNTc4NzVhZTM4NTc5NGVhNjcifQ==	2020-03-17 19:03:34.331233+00
en911akh4awyf0u1swqmhk090119mbji	YWYzNzcwNWYwMzRiNTcyMTA1ZTU4M2NkNGY5NDQ4MDA0YmVmY2E2ZTp7Il9hdXRoX3VzZXJfaWQiOiI2MSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImUwNDQ1YTk3ZDU5N2I2YjlkZTRlMmU5MzIzNDdmNTk4OTE4ZTY1OTEifQ==	2020-03-19 01:11:30.454919+00
cenw5jifh1jiyrrawk5ji7sm92w926bi	OTI3MTIyNDU3YTczMWEyYTdlMzRmZTRmYjIyYzNhMjliMWJmZWJkODp7Il9hdXRoX3VzZXJfaWQiOiI3NiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjU5M2NiNDdlYmI1NzlhNTJiOTJkNzE2OTBmMmQwNzg3OTA3YmVmYTQifQ==	2020-03-20 18:24:50.063206+00
69h32vc8kt3m42x7dmvjgoptz7iidtlh	OWRhNDA0MzQ4NmJmZmNkMzM3MTM3YjJkZmYxNjI4NjBjMmU2OWY3MTp7Il9hdXRoX3VzZXJfaWQiOiIxMjAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxNTBjMzY0ODcxNGE5N2EyYjI3Mjk0NTc2ZjQwZDNkNDdlZmVjNWUzIn0=	2020-03-31 11:15:02.874364+00
i7q29yt7qnqyci5dtjzvklk1shtdbayh	OTQwYTI1YWUxZmE5NjJmOWM5NzQyOTFiYWUyNmNjNThmZmZlNWI1Zjp7Il9hdXRoX3VzZXJfaWQiOiI4OSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjBiYjMzZTdkMDM4MTg5MGQwNzE1N2E2YTJhMjQyYmVmMjk3YmUwY2UifQ==	2020-03-23 03:15:38.611128+00
7o4yp48anwscx2qrlusu4safi7g3ulh8	YWM2MTQwM2MyNTg4OWE3MGI3MmQ5ZDQ5NDdlZDk1ZjM5ZmFkMzQ3OTp7Il9hdXRoX3VzZXJfaWQiOiIxMzMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NmRkMmE0MDQ1ZTQxMWYxODNmNTIxYWQyN2U4Nzc4Y2NhNGExYzY5In0=	2020-04-07 13:51:29.426881+00
gfd2ow9j7xup2dvb0mbt1ial6g38rbr4	MmQ2MmFkNTM2ZDkyZDJkYmZhZDIyZTc4NjFlODBjZDJkODgxZjk0NDp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImYyMDk5YjA4MGY4OWExZWM4ZmU5OTY4MjVhZmE0MTQ5ZGQyMjUyMmQifQ==	2020-03-06 15:49:28.645684+00
67qb205lfdui3s6zai7ncrgdvxlpp41c	MmQ2MmFkNTM2ZDkyZDJkYmZhZDIyZTc4NjFlODBjZDJkODgxZjk0NDp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImYyMDk5YjA4MGY4OWExZWM4ZmU5OTY4MjVhZmE0MTQ5ZGQyMjUyMmQifQ==	2020-03-09 14:03:36.098539+00
y8kjrg76tgw2e4ptoe8zb111i13ezpy1	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-03-09 16:28:58.218459+00
rql9sqs5rxpc2gpc2or32ucfef6ysaxn	MmQ2MmFkNTM2ZDkyZDJkYmZhZDIyZTc4NjFlODBjZDJkODgxZjk0NDp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImYyMDk5YjA4MGY4OWExZWM4ZmU5OTY4MjVhZmE0MTQ5ZGQyMjUyMmQifQ==	2020-03-09 18:47:33.064929+00
amgldmlmhqmhpl0jhlg25znjxabgpw5q	MmQ2MmFkNTM2ZDkyZDJkYmZhZDIyZTc4NjFlODBjZDJkODgxZjk0NDp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImYyMDk5YjA4MGY4OWExZWM4ZmU5OTY4MjVhZmE0MTQ5ZGQyMjUyMmQifQ==	2020-03-10 03:02:46.359182+00
pco6eil849rnrgu8xn5690g7t7y2jypd	NzRmNTI3MjJmMjc4NDgyNzlkZWZjYTE1NmRlNzMyMzE2Y2I3ODAzNjp7Il9hdXRoX3VzZXJfaWQiOiIxMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjkzMjQ2NjJiZmEwZDc5NDEyODk5ZWJjYzFiZjJjMjkzMDA1NjUxOWIifQ==	2020-03-11 05:53:18.349605+00
5l2oreqfibdhxkwfl8s27zg488kgaox4	YzJkNTY0ZWM1MzZiZmE2YmI2NTU4NDcyOTEyNzE3Njk4ZTc2MjdhNDp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhZDQyZDA1ZjhiMzIwNWM5ZDc4MzI2NWQyOTA3NDU1Y2M1OTA4MjdiIn0=	2020-03-11 10:24:10.06751+00
4qtnq1sbbfvzl1i8r3p82k71olkfmuly	MTM2NjY5NDI2Zjc3NzBiMDdjZmE0YjI2ZGFiZTMzMTIwNDBkYTBlZDp7Il9hdXRoX3VzZXJfaWQiOiIxNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjQ2MDFlZDM0NDAwMGE4YjgyZWI4Y2ExNGZmMzI1ZDU4MmUxYWVjYmYifQ==	2020-03-11 12:16:26.501574+00
flas71tsq0jh65ps81yvwej2ym80fvlt	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-03-12 04:42:40.224834+00
di4xdslji67soggew7eqbomsm988ukll	MDRhMmJlYzJlYzFkYjFmNzNlYWEwZmY5ZGEyZDk5N2MyZTE4ODdjNTp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiYXBpLmJhY2tlbmRzLnBob25lX2JhY2tlbmQuUGhvbmVCYWNrZW5kIiwiX2F1dGhfdXNlcl9oYXNoIjoiYWQ0MmQwNWY4YjMyMDVjOWQ3ODMyNjVkMjkwNzQ1NWNjNTkwODI3YiJ9	2020-03-12 21:02:34.680101+00
cnaso50vrwpfvehugg0g3zbi0ymmih6v	YTZjOWI5YzRiOGExNmYzYzMxY2UwYTRmY2Y0MzAzZDIxNmUwODc5MDp7Il9hdXRoX3VzZXJfaWQiOiIxMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImM4YmIwN2EzMDQ0YjY5MDIxMjJlYTU0YjVlMjkxNjNhZjY4MDY1NzUifQ==	2020-03-12 21:37:02.032063+00
869bg19hsdlyihncxweb2i5l2zg6kfjy	MmQ2MmFkNTM2ZDkyZDJkYmZhZDIyZTc4NjFlODBjZDJkODgxZjk0NDp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImYyMDk5YjA4MGY4OWExZWM4ZmU5OTY4MjVhZmE0MTQ5ZGQyMjUyMmQifQ==	2020-03-13 15:33:11.413598+00
ilio14pv9p42mozxi8cng50wxzwne76z	MmQ2MmFkNTM2ZDkyZDJkYmZhZDIyZTc4NjFlODBjZDJkODgxZjk0NDp7Il9hdXRoX3VzZXJfaWQiOiIxMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImYyMDk5YjA4MGY4OWExZWM4ZmU5OTY4MjVhZmE0MTQ5ZGQyMjUyMmQifQ==	2020-03-15 04:54:53.056743+00
qxsr73g4wl71pqstj7e9j4f8p61tzqyx	NDU0YjVlYWYxYmQ2NzIxZTIyYThhODAzODhhMTAzNDQwZmM5MGIxZjp7Il9hdXRoX3VzZXJfaWQiOiIxNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6Ijg2MjI2MzEzZTEwZWIwZTY3NjYyNzdiOTAyYWQ4ZTUzYjdmMGFiODAifQ==	2020-03-16 23:26:10.14691+00
0855qop7bi1mhqqsg65s3ftdveyfppoi	YzUwMTNhMzk4ZGM5NjQwNTNiZDIyOTc5MTkyYmY1ZWE0MTM5NzlmNTp7Il9hdXRoX3VzZXJfaWQiOiIxNiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjZhNjY3YzdiNjQ4OWJjOTZhZWYwYzIxMzhkYjU2YmRiOWU0NmU1MTAifQ==	2020-03-16 23:33:17.832996+00
fxct5k05i23x4xrxjkivwupcftr3gkzk	YjgxYmZiOWM5YWUwNzliZjcyZmIxZjcyNDMwMzRlYzRkYmIzZjNlMjp7Il9hdXRoX3VzZXJfaWQiOiIxNyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImRjZjI1ZmI1NWY4ZGQ2NGU5NDliZDIzYWFmOWY3ZWZmYzUxNjNjMjUifQ==	2020-03-16 23:39:18.593106+00
r7pgv4yipap1nhn6her1zvr5gumhvpfq	Nzc4YjAxMGJlOGI3MDk4OTNkYzA0YjE4MTZjY2JhOGJlMDc0YTRhYTp7Il9hdXRoX3VzZXJfaWQiOiIxOCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjI3MzRiNjk1YTI4YWFjOTk3NjA4NDkwN2Q1MDM3M2EyOTNlOTAzNzkifQ==	2020-03-16 23:40:58.811443+00
g9sn2lv0z90w1alux2kvk1t48i89qosm	NWYzOTZhNDg1MDhlYjc1NmNhZjM4MTExZjI3ZTViOGFhNjBjMjhlMDp7Il9hdXRoX3VzZXJfaWQiOiIxOSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6Ijk2OGRhYTdmOTFjNzAxMTM5NGI3ZjA1ZGM4ZjY4NzczNmQ5ODFiMTcifQ==	2020-03-16 23:45:40.308527+00
poeuydxwzre67xvdbcxy7qy45z6jk494	YjA2N2UxMmIyYjY0MTdkOTA5ODkyMTYzYmUwZDYzMmJlZTViNDI0ZTp7Il9hdXRoX3VzZXJfaWQiOiIyMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImIxNGQ4NmMzNTE1MzU3N2I0ZWMzZTU1N2EyYzExOGNjMWU3Nzg0YzMifQ==	2020-03-16 23:47:06.233878+00
kzhpbs00ffnuw4aq9zzlzajv0j4oqvcr	MWY0M2NiN2I5MzE3NTQ2ZGZkNzJmOGIzY2I2YTJhNTY3NTU1MjYwODp7Il9hdXRoX3VzZXJfaWQiOiIyMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjdiOTQ3NzIxYTUxMDBlZDE5MTUxNDFiMWFlY2FhZTlhZDJkMWQ5MWUifQ==	2020-03-16 23:49:00.197706+00
n0jyvsc3oj0alqfyleym9ledzbjfbqti	ZmZkZjFjYTg2NWM3Y2FmN2EyMjZhNTdiYTA2ZTc0M2EwMzJlOTNlZjp7Il9hdXRoX3VzZXJfaWQiOiIyMiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjQwYmQ1ZmUwMzE2YjQ3NmIwYWQ0YTgzNWIxZDMzNTdiNDBjZTRmNGEifQ==	2020-03-16 23:49:31.427025+00
4g6noja6kxerifu142d3h25ldubmg4c9	MDE0NzlmZDU5ZTI1MWRlNzhkYTBhYzE2OWFiN2U4YWU3ZDUwY2Q4ODp7Il9hdXRoX3VzZXJfaWQiOiIyMyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjAzZjc5NjNlNGUwYjBiZDc1NDczNDZkNTBhNmQwYzA4Mjg5ZGIxYmQifQ==	2020-03-17 00:35:36.392405+00
uk9k81yvlxr6zwnx6tx86o5o3cs5btvd	YmE1NzkyMWRiMTdkNmMxODQ4NzhhZWU1ZDA0ZjFjZjI0NTQxNThhYzp7Il9hdXRoX3VzZXJfaWQiOiIyNCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6Ijc1ODAzZTI2OWYwOGFkMWFhOWIyZjQ1YzgyOGY0YjY1NDFlNWM3Y2IifQ==	2020-03-17 00:46:02.887884+00
se2nb8xx6q0vpsc2n3ukwm58x0dcnapp	OTEyY2E2Yzg5YzY2YTdhZmVlYjBkZDkwNWNkZTdlNjVmZWI5MDFiMzp7Il9hdXRoX3VzZXJfaWQiOiIyNSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjIxMThmYjY2M2E1Yzg2MjlhNDE0NGFlZGNlZTBlYTM0MThhZWJlNWMifQ==	2020-03-17 01:09:46.110361+00
1b621caqjybuq39u8cb8jv7wzr5fyf04	YTNlNmQxMjJmNDRiYjIxOThjYTQ1ZDBiYmNlZDIxYjhjZWJjYjgyODp7Il9hdXRoX3VzZXJfaWQiOiI0NiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjY3NjhkNDhhYzdlMzhmYTA2MDI0NWU5YzljYmQyMzM0MGQzYzk1MjkifQ==	2020-03-17 21:19:22.476834+00
thyi0zqabe63agz20gdd14dni8n8bfm2	YjZkY2Q2N2I1NDBlNDhmYzBhZDI4YjFhNjhkYjM2OWIwZGNkNGJhYTp7Il9hdXRoX3VzZXJfaWQiOiIyNiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6Ijk4YjFkZGY5NWFjMzA1N2RmZmY1MzBhNTNhNTc5MjZjNDRlMzQ5ZmMifQ==	2020-03-17 01:27:52.205075+00
xums3ngrr2p0vtta0piiwnu07we8iu09	YWRkYjdjNmNkNTVhYzU5OGNiZWMwNWNiZTJhYjYwYzBhNWVmNjQwMDp7Il9hdXRoX3VzZXJfaWQiOiI2MiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjkyMTQyODhjYjQ0MThhNzg4MjUxMDU1MTIxOTRhNGIxZDVhZTZjY2EifQ==	2020-03-19 01:19:16.554056+00
ucjp3absojggvmjkhhbee4ha7rit9o8u	ZDE1ZmU4NTczYzE1MmE1OTNmNWJlMDdiYzQyZTY0ZjVlNDlmNzk3ZDp7Il9hdXRoX3VzZXJfaWQiOiIyNyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjcyOWQxOGIxMTBlNTVkYzUwZTY4MTU5OGE0YTkzYWEzMTA2M2E2YzMifQ==	2020-03-17 01:44:16.78781+00
ac6ht9b0h4gmm4i7n1y53n99sypugqcs	ZDgzZGFkNGNiNGM4ZDMzZTNlMTgyOTlmOGNkMmU3MTliNzk5ZTQwMzp7Il9hdXRoX3VzZXJfaWQiOiI3NyIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImI4ZTc5YWZiNDc0NWEwMzJjNWNmMTQyYzZlOGMyZTk0N2Y3NGE2ZTcifQ==	2020-03-20 19:15:50.692315+00
bqzerry0vz05muowt2nzdggg6u945jaj	ZjY3ODA2Yjc2YTI4M2FkNTA5Mzk3NTJlNjYyZDQ2NGM4YWJkYTFlYjp7Il9hdXRoX3VzZXJfaWQiOiIyOCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImVkMTk5OTQ4NTI1M2ZiZDI3MTI0MWUwZjZhYzA0NmZmYzQyY2FiMmMifQ==	2020-03-17 01:58:49.488293+00
z2eftjqw5q95ah213dyeq43z4ujkvl44	YWE2MjFiZjJiZmVjNzBkYTBmOGJlNWFlYmFlZWM1MGQxODA5ODdkNzp7Il9hdXRoX3VzZXJfaWQiOiIyOSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjI5MjM2MTZmOTEyY2M1M2I4MWNjZTEyNGMyZjYxNjBmNmNjNzFiNjkifQ==	2020-03-17 01:59:14.849149+00
kjmix0thjnmi5atquqdslclyhqh7sazl	YzUwMTNhMzk4ZGM5NjQwNTNiZDIyOTc5MTkyYmY1ZWE0MTM5NzlmNTp7Il9hdXRoX3VzZXJfaWQiOiIxNiIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjZhNjY3YzdiNjQ4OWJjOTZhZWYwYzIxMzhkYjU2YmRiOWU0NmU1MTAifQ==	2020-03-17 02:22:12.89864+00
psqx535m7r4i1873tsa1ajidvx2y4ush	YTE4ZjZiOWNlNzE1M2Q4MGEwMTUzOWE2N2MzYzM1NTFkMzYyNGNhZjp7Il9hdXRoX3VzZXJfaWQiOiIxMjYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiNGQ0YWI5NjUzMjVlYTRlYzY1NDdkNGFmYmQ2MzQ3MTZkYTZjMGEwIn0=	2020-04-07 15:20:49.076944+00
5s5n4e6cjfc63rrn9ev1udyh3ee9mhz1	MzJiOWQ2ZDExNzA1ZTlmYjg4NWVlZDRhN2MzZGU0N2U3ZGJhNmRmODp7Il9hdXRoX3VzZXJfaWQiOiIzMCIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjcyNjk4MTE3OWJjOTg2NTA2MDUwOTI4NWY1NThmMzQ1M2E0MDczY2IifQ==	2020-03-17 02:35:09.354916+00
krv54t7lguvh80194fqnhpc8n6lvnidu	YzI1YjU3MWExZTJlYTE0YTg3ZGVlM2M2MDViOWE3ZmQxYTU5NDI5Yjp7Il9hdXRoX3VzZXJfaWQiOiIzMSIsIl9hdXRoX3VzZXJfYmFja2VuZCI6ImFwaS5iYWNrZW5kcy5waG9uZV9iYWNrZW5kLlBob25lQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6IjBkOGU2ZWQwOTE0MGI3Y2E5Zjg4NDQ1NWMxZThiNGFkNjNmYWRlMmMifQ==	2020-03-17 02:54:59.381871+00
t7qubvb5be7di73iqqntfmq6b4s4q2xp	YTE4ZjZiOWNlNzE1M2Q4MGEwMTUzOWE2N2MzYzM1NTFkMzYyNGNhZjp7Il9hdXRoX3VzZXJfaWQiOiIxMjYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiNGQ0YWI5NjUzMjVlYTRlYzY1NDdkNGFmYmQ2MzQ3MTZkYTZjMGEwIn0=	2020-04-22 20:57:48.213229+00
8cpzdhz7qwtrvirr1iyhvi871s03ycnr	YTE4ZjZiOWNlNzE1M2Q4MGEwMTUzOWE2N2MzYzM1NTFkMzYyNGNhZjp7Il9hdXRoX3VzZXJfaWQiOiIxMjYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiNGQ0YWI5NjUzMjVlYTRlYzY1NDdkNGFmYmQ2MzQ3MTZkYTZjMGEwIn0=	2020-04-23 14:37:37.413202+00
noutb6cajpdnqtlrro1mwz3lep4wkoxl	NzYxMDEzOTUzMzMwMWUyMjZiMWU3ZDQwZDA2ZjRmMTY1M2M5YzBjZjp7Il9hdXRoX3VzZXJfaWQiOiIxNDAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyZjM3ZDEwNWQxYTEwYzEzM2U1MjgwZGNmZTViYWQ2NzdhOWFjYjFmIn0=	2020-04-24 15:14:17.557709+00
mnsb58z8myca30br1aj54al8e7bknzfc	NzYxMDEzOTUzMzMwMWUyMjZiMWU3ZDQwZDA2ZjRmMTY1M2M5YzBjZjp7Il9hdXRoX3VzZXJfaWQiOiIxNDAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyZjM3ZDEwNWQxYTEwYzEzM2U1MjgwZGNmZTViYWQ2NzdhOWFjYjFmIn0=	2020-04-25 09:34:16.684682+00
jwyw9h1nfjcj40ejjgekt1d0isih1f9s	NzYxMDEzOTUzMzMwMWUyMjZiMWU3ZDQwZDA2ZjRmMTY1M2M5YzBjZjp7Il9hdXRoX3VzZXJfaWQiOiIxNDAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyZjM3ZDEwNWQxYTEwYzEzM2U1MjgwZGNmZTViYWQ2NzdhOWFjYjFmIn0=	2020-04-27 11:18:24.52185+00
18daj9zsq0r3089fvmt30cbuq9n45cxn	NzYxMDEzOTUzMzMwMWUyMjZiMWU3ZDQwZDA2ZjRmMTY1M2M5YzBjZjp7Il9hdXRoX3VzZXJfaWQiOiIxNDAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyZjM3ZDEwNWQxYTEwYzEzM2U1MjgwZGNmZTViYWQ2NzdhOWFjYjFmIn0=	2020-04-27 12:07:44.143777+00
onnc9dn26dtbdc8w30uipcyb8zewix0m	NzYxMDEzOTUzMzMwMWUyMjZiMWU3ZDQwZDA2ZjRmMTY1M2M5YzBjZjp7Il9hdXRoX3VzZXJfaWQiOiIxNDAiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyZjM3ZDEwNWQxYTEwYzEzM2U1MjgwZGNmZTViYWQ2NzdhOWFjYjFmIn0=	2020-04-27 12:28:06.027249+00
t80iia4w75tw4rqd0ubajb4uqqdkb6k3	YTE4ZjZiOWNlNzE1M2Q4MGEwMTUzOWE2N2MzYzM1NTFkMzYyNGNhZjp7Il9hdXRoX3VzZXJfaWQiOiIxMjYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiNGQ0YWI5NjUzMjVlYTRlYzY1NDdkNGFmYmQ2MzQ3MTZkYTZjMGEwIn0=	2020-04-28 19:12:44.130801+00
6yuw1nqsr5oa2vc7480udvpf2e71d81n	YTE4ZjZiOWNlNzE1M2Q4MGEwMTUzOWE2N2MzYzM1NTFkMzYyNGNhZjp7Il9hdXRoX3VzZXJfaWQiOiIxMjYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiNGQ0YWI5NjUzMjVlYTRlYzY1NDdkNGFmYmQ2MzQ3MTZkYTZjMGEwIn0=	2020-04-28 20:53:33.828415+00
r3fadr9wcwr90pqnpspu68f1lzgaoxo6	YTE4ZjZiOWNlNzE1M2Q4MGEwMTUzOWE2N2MzYzM1NTFkMzYyNGNhZjp7Il9hdXRoX3VzZXJfaWQiOiIxMjYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiNGQ0YWI5NjUzMjVlYTRlYzY1NDdkNGFmYmQ2MzQ3MTZkYTZjMGEwIn0=	2020-04-29 16:51:05.012679+00
ebcpowewelmr1w6pyrujnhxmzzl9qbw8	ZDVmMjFjZmI3ZjgwY2I1YThiYTNlNjU4NDAyNWVjYWQ3YzZmMjFhMzp7Il9hdXRoX3VzZXJfaWQiOiIxNDEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NWYzOTZkMzcxMGJjOGFiZGQzZTg4MTVmOGJjMzI3NzRjNTA3NDUxIn0=	2020-05-02 19:49:39.088566+00
oqqsx8c06rwjno96gp5lx74lqcbxslxg	OGY2NmQ0YWFmN2ViZjQ4MWU1Njg0ZjQ2YTJhODFhNGM3OGI0YzE2MTp7Il9hdXRoX3VzZXJfaWQiOiIxNDIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3YmFmMmQxN2E4ZjhkMjdjMDQ2MjIxOTZiMzFkOTc1ZmMwODE5N2E3In0=	2020-05-02 19:56:25.20461+00
2mcoj9thbo8mp6c20v0bcudagoy6bigc	ZDVmMjFjZmI3ZjgwY2I1YThiYTNlNjU4NDAyNWVjYWQ3YzZmMjFhMzp7Il9hdXRoX3VzZXJfaWQiOiIxNDEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NWYzOTZkMzcxMGJjOGFiZGQzZTg4MTVmOGJjMzI3NzRjNTA3NDUxIn0=	2020-05-02 19:59:25.548782+00
xgxm0tjrlsi98ana2seilv5hpd6b1zs5	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-05-05 07:32:54.015002+00
fp4nc8xmrnr2ngg5g5jwafezh7tlwwdx	ZDVmMjFjZmI3ZjgwY2I1YThiYTNlNjU4NDAyNWVjYWQ3YzZmMjFhMzp7Il9hdXRoX3VzZXJfaWQiOiIxNDEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NWYzOTZkMzcxMGJjOGFiZGQzZTg4MTVmOGJjMzI3NzRjNTA3NDUxIn0=	2020-05-05 12:08:31.530065+00
tn1jx0bzsdu77xcyrx6cv8p91hz311di	MGY4NDhiYTJkMzY3ZTZmNWZhZDAwMGU3NDNjYTFlYjZkMTY0OTNlMTp7Il9hdXRoX3VzZXJfaWQiOiIxNDQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3ODNiYTJkMmFjY2VhMjkzZTJiNDRmNzc4YzI1OThmNTU0MjM2MWIyIn0=	2020-05-08 09:31:54.511235+00
5ok2vprwjxl8b71482fwa55h3jg3vutd	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-05-08 10:43:11.84047+00
2n7ja3drze6x07ph84x44ke8tpnbmlh7	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-05-08 11:29:20.120548+00
ggviq4f1n514bak3fw0ywuzm20tp22g7	ZDVmMjFjZmI3ZjgwY2I1YThiYTNlNjU4NDAyNWVjYWQ3YzZmMjFhMzp7Il9hdXRoX3VzZXJfaWQiOiIxNDEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NWYzOTZkMzcxMGJjOGFiZGQzZTg4MTVmOGJjMzI3NzRjNTA3NDUxIn0=	2020-05-08 19:14:37.617721+00
lge6iv0gw9fdxu20ftldg835ga216dqf	ZDVmMjFjZmI3ZjgwY2I1YThiYTNlNjU4NDAyNWVjYWQ3YzZmMjFhMzp7Il9hdXRoX3VzZXJfaWQiOiIxNDEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NWYzOTZkMzcxMGJjOGFiZGQzZTg4MTVmOGJjMzI3NzRjNTA3NDUxIn0=	2020-05-09 07:43:57.767122+00
2e4quo94htvtx6gplua4prrrn4ulebyw	ZDVmMjFjZmI3ZjgwY2I1YThiYTNlNjU4NDAyNWVjYWQ3YzZmMjFhMzp7Il9hdXRoX3VzZXJfaWQiOiIxNDEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NWYzOTZkMzcxMGJjOGFiZGQzZTg4MTVmOGJjMzI3NzRjNTA3NDUxIn0=	2020-05-11 08:46:55.265864+00
iii7q7nt555ic5blcts4f15lpx2z27g8	ZDVmMjFjZmI3ZjgwY2I1YThiYTNlNjU4NDAyNWVjYWQ3YzZmMjFhMzp7Il9hdXRoX3VzZXJfaWQiOiIxNDEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NWYzOTZkMzcxMGJjOGFiZGQzZTg4MTVmOGJjMzI3NzRjNTA3NDUxIn0=	2020-05-11 13:19:49.094991+00
dwmd91fhleuy0mq3cxs4gk6vosvuu43c	ZDVmMjFjZmI3ZjgwY2I1YThiYTNlNjU4NDAyNWVjYWQ3YzZmMjFhMzp7Il9hdXRoX3VzZXJfaWQiOiIxNDEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NWYzOTZkMzcxMGJjOGFiZGQzZTg4MTVmOGJjMzI3NzRjNTA3NDUxIn0=	2020-05-11 18:09:52.185855+00
jrj002j40qkns1wmrhkzkx0kwoubv710	ZDVmMjFjZmI3ZjgwY2I1YThiYTNlNjU4NDAyNWVjYWQ3YzZmMjFhMzp7Il9hdXRoX3VzZXJfaWQiOiIxNDEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NWYzOTZkMzcxMGJjOGFiZGQzZTg4MTVmOGJjMzI3NzRjNTA3NDUxIn0=	2020-05-11 18:25:35.670247+00
f6syckzmun78hq4wwp58g58frppvspqb	MDE2MmUyMjY1MmM4ZTJhZWI0YTVlMmNlMDU5NDA0M2ZlYzY4ZTAyODp7Il9hdXRoX3VzZXJfaWQiOiIxNDUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBlZDEzYjhhMDNiMTI5M2JmODliNjI1ODVjZmQ1NzFkYjNiNjcwIn0=	2020-05-11 18:37:06.996283+00
kxy538th5ynnw24va5i17ga72hvur25b	MDE2MmUyMjY1MmM4ZTJhZWI0YTVlMmNlMDU5NDA0M2ZlYzY4ZTAyODp7Il9hdXRoX3VzZXJfaWQiOiIxNDUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBlZDEzYjhhMDNiMTI5M2JmODliNjI1ODVjZmQ1NzFkYjNiNjcwIn0=	2020-05-11 20:13:37.578086+00
j6uvo0k7tguz0pe800srdmn0tok1covg	MDE2MmUyMjY1MmM4ZTJhZWI0YTVlMmNlMDU5NDA0M2ZlYzY4ZTAyODp7Il9hdXRoX3VzZXJfaWQiOiIxNDUiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI5MDBlZDEzYjhhMDNiMTI5M2JmODliNjI1ODVjZmQ1NzFkYjNiNjcwIn0=	2020-05-11 20:54:15.398151+00
is2qmjq42dybbw61xbcpnkhjyj2bk92x	ZDVmMjFjZmI3ZjgwY2I1YThiYTNlNjU4NDAyNWVjYWQ3YzZmMjFhMzp7Il9hdXRoX3VzZXJfaWQiOiIxNDEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NWYzOTZkMzcxMGJjOGFiZGQzZTg4MTVmOGJjMzI3NzRjNTA3NDUxIn0=	2020-05-12 07:41:32.250579+00
mj43kzssoa06ec57zwkw11r8d7n3y4ao	ZDVmMjFjZmI3ZjgwY2I1YThiYTNlNjU4NDAyNWVjYWQ3YzZmMjFhMzp7Il9hdXRoX3VzZXJfaWQiOiIxNDEiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2NWYzOTZkMzcxMGJjOGFiZGQzZTg4MTVmOGJjMzI3NzRjNTA3NDUxIn0=	2020-05-12 10:38:27.080708+00
6kkkr78z7xxnnspfjcgrqzclhqo5ho80	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-05-15 05:40:51.556908+00
xz49z2le35em19bfzncza60ghyldysw5	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-05-15 09:02:08.822198+00
ivr0wxliya27sbk1pl7pev5vuf1zybho	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-05-15 17:47:46.739428+00
bx6yqcmrb9po56gpy11dwe4b6l8cyiw2	YTE4ZjZiOWNlNzE1M2Q4MGEwMTUzOWE2N2MzYzM1NTFkMzYyNGNhZjp7Il9hdXRoX3VzZXJfaWQiOiIxMjYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJiNGQ0YWI5NjUzMjVlYTRlYzY1NDdkNGFmYmQ2MzQ3MTZkYTZjMGEwIn0=	2020-05-19 15:48:59.830889+00
amyrllp9evpsnq58ll3n6dto3i0sy1o5	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-05-22 17:52:36.566552+00
tjpy03nrikp3yjysopgqaglhrwinx1ap	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-06-02 18:30:43.99063+00
ln1ctgwfgbspxnlzhukbb9xpf70b57lh	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-06-03 06:28:43.170009+00
bjx4dxdqpv0jiymh4wzqnujsvaglgwob	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-06-10 10:39:15.96709+00
3u76hm65xhfzlxeel72wdlhw2eo4p1qm	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-06-21 12:02:05.193433+00
gdzfpd4zgabg1j4c0453zj5jjfxaszaz	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-06-22 06:13:53.276156+00
gs48u0sfkojy8ueazhfwf92vd77x68mv	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-06-22 16:12:06.838362+00
hfrl7m3lzb441j65lkst8tgl7is7ju3f	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-06-22 17:10:45.926527+00
e1tv2xxuzf54e1k3w63expxugcwpll4o	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-06-23 13:55:48.933214+00
pdyklrcivy7vgh79g5va7tld7d1xxlc0	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-06-23 17:51:39.185391+00
bi61jz1miedrrx83bpocvx0ze2ig968s	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-06-24 13:57:46.983129+00
ovh2i1j6t6xon47kyxcbis9v2oqmzgkb	MGY4NDhiYTJkMzY3ZTZmNWZhZDAwMGU3NDNjYTFlYjZkMTY0OTNlMTp7Il9hdXRoX3VzZXJfaWQiOiIxNDQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3ODNiYTJkMmFjY2VhMjkzZTJiNDRmNzc4YzI1OThmNTU0MjM2MWIyIn0=	2020-06-26 01:51:01.708787+00
y3zgrsa7e87mwz6dz8h6pyqgqprtyytm	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-06-26 04:24:24.15736+00
hb1vwmec1bi3hcsmsa4k132j14f5s4y1	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-06-29 15:44:23.527632+00
zeblquwe5bh0cgvr8qw2ek3lkkgtrcii	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-07-07 16:59:44.144311+00
ll1o6s1qe75uvr40uxwqbehpejh58fq5	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-07-07 17:01:37.25861+00
rcrzlkr8ip8i9am2qz25orl3watpll5j	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-07-08 21:24:46.220386+00
1tkbmw3v3ullg8gp7zou3mh5vzqh7c5c	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-07-08 21:28:26.064065+00
zj2mfv1ispr905tybm0trln63jbxofet	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-07-09 07:20:13.8146+00
wr5w3z1p98yq2ihssgw4by05n295vid4	MGY4NDhiYTJkMzY3ZTZmNWZhZDAwMGU3NDNjYTFlYjZkMTY0OTNlMTp7Il9hdXRoX3VzZXJfaWQiOiIxNDQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3ODNiYTJkMmFjY2VhMjkzZTJiNDRmNzc4YzI1OThmNTU0MjM2MWIyIn0=	2020-07-10 04:36:18.605177+00
1qfcki170ao26t6bcljcy4iymhp245mf	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-07-13 17:31:53.600945+00
1sj6sbhwsovgq5e7d8g57qtelx0dysr6	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-07-14 18:17:38.744237+00
r3dkdy9okytic8wwqilmkawvmmwlmf7z	MGY4NDhiYTJkMzY3ZTZmNWZhZDAwMGU3NDNjYTFlYjZkMTY0OTNlMTp7Il9hdXRoX3VzZXJfaWQiOiIxNDQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3ODNiYTJkMmFjY2VhMjkzZTJiNDRmNzc4YzI1OThmNTU0MjM2MWIyIn0=	2020-07-14 18:19:38.657525+00
84b0emsa6gtgqwrufngv57kyuam9130x	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-07-14 18:35:27.441671+00
siyil69kimxamyazdvt8hu2p1r5d0j7l	NTkxNTRkM2U5YTY1YWNmZTcyOTQ2YTljOTg3NDFkMDQxMWI3YjdmZDp7Il9hdXRoX3VzZXJfaWQiOiIxNDYiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJhYTFmMjRhOTNlMzc3NTI3YmEyMzk2MDQ5MDcwMTExZTRiYmRkMzM0In0=	2020-07-14 18:40:46.516007+00
hzt5ub4t1ntcwf82wr9i9hlv0h40kxke	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-07-15 00:41:40.330204+00
41wcv0xe3h8lh5dg3ir9p6ssj2a4krjo	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-07-15 00:43:43.698365+00
9j6xpqp4q44hp26dmab6kvtpcbaqly2w	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-07-15 12:30:49.48195+00
ozbxv8jvs2c2pgsrbs1qzp9l10bby0vy	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-07-15 14:40:54.743476+00
yffaj4d51kq46cz6s0kndlmxtincjtje	NDNjZmRjZmVhMjAzZmZkZWNiNTdhNWJlMmZjYWJhMTQ1NWM4MGFjODp7Il9hdXRoX3VzZXJfaWQiOiIxNDciLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJjNDU1ZTNmOWM1M2YyMDM3MjVkZjFhODY2NDhlZGE5OGQyNjgzOTcyIn0=	2020-07-16 16:04:22.846058+00
2j9okkowc481cndi913ra0fqbjn8b7an	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-07-16 20:29:49.437111+00
gjs6viwszth2ne2h1wosw5fzspmf4teh	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-07-16 20:32:11.15545+00
p8zg46cyjmgsai2i1bzyk3ns14t2mrkp	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-07-17 05:33:27.679356+00
f8fmxn6iaoxfx3vgcp8dlcp46njm9cjv	MGY4NDhiYTJkMzY3ZTZmNWZhZDAwMGU3NDNjYTFlYjZkMTY0OTNlMTp7Il9hdXRoX3VzZXJfaWQiOiIxNDQiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI3ODNiYTJkMmFjY2VhMjkzZTJiNDRmNzc4YzI1OThmNTU0MjM2MWIyIn0=	2020-07-17 11:40:12.272548+00
iw8jxc64k45wi40fh42r1dj182zori41	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-07-21 14:13:24.756665+00
3hl8cmrosb52nnwi51a54v2nl0ew69vb	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-07-21 15:43:03.416351+00
v6nv29izxo4xyumj6z2pdyupsyanx8gs	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-07-22 03:27:47.85143+00
k9kv0uduaulbhihcgqj3t0qui4ut95d4	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-07-22 04:08:44.329764+00
6dx6hrwqc5ddbe3y5akuotv8xya8l1ml	YzM2ZGJlYjQwNjdhZDg4MGNlMWE2Mzg5ZDNmODZiOGE5ZTQ2YTQ2Yjp7Il9hdXRoX3VzZXJfaWQiOiIxMzIiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI4MzBhZWQ2ZGIyMTc2YTJlYTNmN2NkNTQ5MzUzYmViNTIyZGU1OWUyIn0=	2020-07-22 05:46:02.465189+00
pp34xdm7p4gakt43im2zqzmswra1qf2t	N2RhYWY1ODljMGJlZTc1YjFlMmUwMzQxOWE0YzdiOWE4YjkzYzg4YTp7Il9hdXRoX3VzZXJfaWQiOiIxNDMiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJhcGkuYmFja2VuZHMucGhvbmVfYmFja2VuZC5QaG9uZUJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YjhjOWY1NzY2NDBjM2Q4NzczODkzYzhiZTQ2MTdjZDFiOGZlZGE5In0=	2020-07-28 14:36:51.062499+00
\.


--
-- Data for Name: friendship_friend; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.friendship_friend (id, created, from_user_id, to_user_id) FROM stdin;
75	2020-02-13 01:24:30.828534+00	7	1
76	2020-02-13 01:24:30.832062+00	1	7
77	2020-02-13 01:24:30.952574+00	7	8
78	2020-02-13 01:24:30.955198+00	8	7
79	2020-02-13 01:24:30.97342+00	7	2
80	2020-02-13 01:24:30.975556+00	2	7
81	2020-02-13 02:19:11.94484+00	8	2
82	2020-02-13 02:19:11.949362+00	2	8
83	2020-02-13 02:19:12.006446+00	8	1
84	2020-02-13 02:19:12.010034+00	1	8
85	2020-02-19 04:25:07.452225+00	7	6
86	2020-02-19 04:25:07.45586+00	6	7
87	2020-02-24 14:39:31.533936+00	12	11
88	2020-02-24 14:39:31.537042+00	11	12
89	2020-02-26 05:54:32.713654+00	13	6
90	2020-02-26 05:54:32.716441+00	6	13
91	2020-02-27 04:45:11.457309+00	12	1
92	2020-02-27 04:45:11.460755+00	1	12
93	2020-02-28 01:48:01.021834+00	14	8
94	2020-02-28 01:48:01.025738+00	8	14
95	2020-02-28 01:48:03.547591+00	10	8
96	2020-02-28 01:48:03.551058+00	8	10
97	2020-03-02 23:40:46.301805+00	17	7
98	2020-03-02 23:40:46.30801+00	7	17
99	2020-03-02 23:40:46.528804+00	17	16
100	2020-03-02 23:40:46.532956+00	16	17
101	2020-03-02 23:50:10.124482+00	19	7
102	2020-03-02 23:50:10.132637+00	7	19
103	2020-03-02 23:50:10.505684+00	19	22
104	2020-03-02 23:50:10.509485+00	22	19
105	2020-03-02 23:50:58.178114+00	18	7
106	2020-03-02 23:50:58.183584+00	7	18
107	2020-03-02 23:50:58.249449+00	18	8
108	2020-03-02 23:50:58.254056+00	8	18
109	2020-03-02 23:50:58.417995+00	18	20
110	2020-03-02 23:50:58.420991+00	20	18
111	2020-03-02 23:56:10.899514+00	7	20
112	2020-03-02 23:56:10.905512+00	20	7
113	2020-03-02 23:56:11.326513+00	7	15
114	2020-03-02 23:56:11.331803+00	15	7
115	2020-03-02 23:56:11.432635+00	7	16
116	2020-03-02 23:56:11.439544+00	16	7
117	2020-03-02 23:56:11.989776+00	7	21
118	2020-03-02 23:56:11.993983+00	21	7
119	2020-03-03 00:03:14.569848+00	19	8
120	2020-03-03 00:03:14.573844+00	8	19
121	2020-03-03 00:03:15.90225+00	17	8
122	2020-03-03 00:03:15.908266+00	8	17
123	2020-03-03 00:49:08.71966+00	7	24
124	2020-03-03 00:49:08.724823+00	24	7
125	2020-03-03 00:49:09.826416+00	7	23
126	2020-03-03 00:49:09.829605+00	23	7
127	2020-03-03 01:21:34.098572+00	17	25
128	2020-03-03 01:21:34.10232+00	25	17
129	2020-03-03 01:29:52.703325+00	26	7
130	2020-03-03 01:29:52.707459+00	7	26
131	2020-03-03 02:15:54.002556+00	29	7
132	2020-03-03 02:15:54.005957+00	7	29
133	2020-03-03 02:39:47.684995+00	7	30
134	2020-03-03 02:39:47.687904+00	30	7
135	2020-03-03 03:11:00.948146+00	7	32
136	2020-03-03 03:11:00.951705+00	32	7
137	2020-03-03 03:11:33.210512+00	31	7
138	2020-03-03 03:11:33.213912+00	7	31
139	2020-03-03 03:29:42.904387+00	17	28
140	2020-03-03 03:29:42.907567+00	28	17
141	2020-03-03 04:46:12.817167+00	27	7
142	2020-03-03 04:46:12.820904+00	7	27
143	2020-03-03 07:48:12.490363+00	32	33
144	2020-03-03 07:48:12.493666+00	33	32
145	2020-03-03 12:02:47.748627+00	35	7
146	2020-03-03 12:02:47.752556+00	7	35
147	2020-03-03 12:02:47.826706+00	35	8
148	2020-03-03 12:02:47.829311+00	8	35
149	2020-03-03 13:06:21.177677+00	37	17
150	2020-03-03 13:06:21.181241+00	17	37
151	2020-03-03 14:04:56.266836+00	40	38
152	2020-03-03 14:04:56.270463+00	38	40
153	2020-03-03 19:21:51.626272+00	7	39
154	2020-03-03 19:21:51.639557+00	39	7
155	2020-03-03 19:21:52.007461+00	7	43
156	2020-03-03 19:21:52.011712+00	43	7
157	2020-03-03 19:21:52.556104+00	7	34
158	2020-03-03 19:21:52.562078+00	34	7
159	2020-03-03 19:21:53.620955+00	7	45
160	2020-03-03 19:21:53.62514+00	45	7
161	2020-03-03 21:27:13.436093+00	7	46
162	2020-03-03 21:27:13.440473+00	46	7
163	2020-03-03 21:58:59.805607+00	47	17
164	2020-03-03 21:58:59.809317+00	17	47
165	2020-03-03 23:31:08.836642+00	7	48
166	2020-03-03 23:31:08.840272+00	48	7
167	2020-03-04 00:11:40.257954+00	50	46
168	2020-03-04 00:11:40.261233+00	46	50
169	2020-03-04 00:11:41.113988+00	50	20
170	2020-03-04 00:11:41.116765+00	20	50
171	2020-03-04 00:11:42.51487+00	50	32
172	2020-03-04 00:11:42.517677+00	32	50
173	2020-03-04 00:11:42.555812+00	50	26
174	2020-03-04 00:11:42.558591+00	26	50
175	2020-03-04 00:43:28.815815+00	53	49
176	2020-03-04 00:43:28.818939+00	49	53
177	2020-03-04 00:43:28.959445+00	53	27
178	2020-03-04 00:43:28.961891+00	27	53
179	2020-03-04 00:43:30.177153+00	53	7
180	2020-03-04 00:43:30.179663+00	7	53
181	2020-03-04 00:44:35.150213+00	52	26
182	2020-03-04 00:44:35.153481+00	26	52
183	2020-03-04 00:44:35.240829+00	52	20
184	2020-03-04 00:44:35.243295+00	20	52
185	2020-03-04 00:44:35.291131+00	52	46
186	2020-03-04 00:44:35.293785+00	46	52
187	2020-03-04 00:44:35.397375+00	52	32
188	2020-03-04 00:44:35.400038+00	32	52
189	2020-03-04 00:44:35.441593+00	52	50
190	2020-03-04 00:44:35.44447+00	50	52
191	2020-03-04 01:28:16.902995+00	23	30
192	2020-03-04 01:28:16.906037+00	30	23
193	2020-03-04 01:33:15.732599+00	26	43
194	2020-03-04 01:33:15.735874+00	43	26
195	2020-03-04 03:20:25.133019+00	26	8
196	2020-03-04 03:20:25.13716+00	8	26
197	2020-03-04 15:00:31.762773+00	7	52
198	2020-03-04 15:00:31.76679+00	52	7
199	2020-03-04 15:00:32.228439+00	7	50
200	2020-03-04 15:00:32.232444+00	50	7
201	2020-03-04 15:08:27.425029+00	7	56
202	2020-03-04 15:08:27.430931+00	56	7
203	2020-03-04 18:06:49.458791+00	51	17
204	2020-03-04 18:06:49.472783+00	17	51
205	2020-03-04 23:58:03.52315+00	26	18
206	2020-03-04 23:58:03.528342+00	18	26
207	2020-03-05 00:53:27.048741+00	60	17
208	2020-03-05 00:53:27.052313+00	17	60
209	2020-03-05 00:53:27.308304+00	60	25
210	2020-03-05 00:53:27.31188+00	25	60
211	2020-03-05 01:48:36.302211+00	7	57
212	2020-03-05 01:48:36.305825+00	57	7
213	2020-03-05 15:24:21.141445+00	68	17
214	2020-03-05 15:24:21.150327+00	17	68
215	2020-03-05 17:51:46.719698+00	64	66
216	2020-03-05 17:51:46.723538+00	66	64
217	2020-03-05 18:38:47.509419+00	62	40
218	2020-03-05 18:38:47.522823+00	40	62
219	2020-03-05 20:59:16.755752+00	69	62
220	2020-03-05 20:59:16.764296+00	62	69
221	2020-03-05 21:44:55.743614+00	18	52
222	2020-03-05 21:44:55.747039+00	52	18
223	2020-03-05 21:44:55.792086+00	18	46
224	2020-03-05 21:44:55.794835+00	46	18
225	2020-03-06 01:40:04.590631+00	40	8
226	2020-03-06 01:40:04.59613+00	8	40
227	2020-03-06 01:43:36.254801+00	8	20
228	2020-03-06 01:43:36.258307+00	20	8
229	2020-03-06 01:43:36.276853+00	8	32
230	2020-03-06 01:43:36.279572+00	32	8
231	2020-03-06 01:43:36.31224+00	8	46
232	2020-03-06 01:43:36.315685+00	46	8
233	2020-03-06 12:10:18.458642+00	73	41
234	2020-03-06 12:10:18.462142+00	41	73
235	2020-03-06 12:10:18.708728+00	73	7
236	2020-03-06 12:10:18.713737+00	7	73
237	2020-03-06 12:10:19.603753+00	73	66
238	2020-03-06 12:10:19.608539+00	66	73
239	2020-03-06 16:12:37.481124+00	74	7
240	2020-03-06 16:12:37.485138+00	7	74
241	2020-03-06 19:30:06.42069+00	78	35
242	2020-03-06 19:30:06.426315+00	35	78
243	2020-03-06 21:03:45.540631+00	7	67
244	2020-03-06 21:03:45.553063+00	67	7
245	2020-03-06 21:03:46.812968+00	7	76
246	2020-03-06 21:03:46.816802+00	76	7
247	2020-03-07 00:33:21.906448+00	80	7
248	2020-03-07 00:33:21.912462+00	7	80
249	2020-03-07 01:24:48.129322+00	81	31
250	2020-03-07 01:24:48.132858+00	31	81
251	2020-03-07 05:18:40.611757+00	7	79
252	2020-03-07 05:18:40.619052+00	79	7
253	2020-03-07 07:59:25.980971+00	17	83
254	2020-03-07 07:59:25.984535+00	83	17
255	2020-03-07 08:00:39.19217+00	83	25
256	2020-03-07 08:00:39.196842+00	25	83
257	2020-03-07 17:27:23.07301+00	85	6
258	2020-03-07 17:27:23.077375+00	6	85
259	2020-03-07 19:15:18.912167+00	84	45
260	2020-03-07 19:15:18.917063+00	45	84
261	2020-03-07 22:27:34.040052+00	80	24
262	2020-03-07 22:27:34.053252+00	24	80
263	2020-03-07 22:47:40.897814+00	80	26
264	2020-03-07 22:47:40.904648+00	26	80
265	2020-03-07 22:47:41.999896+00	24	26
266	2020-03-07 22:47:42.004697+00	26	24
267	2020-03-08 03:19:15.562195+00	87	17
268	2020-03-08 03:19:15.565397+00	17	87
269	2020-03-09 01:52:36.929847+00	81	7
270	2020-03-09 01:52:36.933797+00	7	81
271	2020-03-09 15:52:14.688887+00	96	7
272	2020-03-09 15:52:14.69394+00	7	96
273	2020-03-09 16:02:45.066828+00	97	98
274	2020-03-09 16:02:45.071159+00	98	97
275	2020-03-09 16:02:45.742181+00	97	93
276	2020-03-09 16:02:45.745799+00	93	97
277	2020-03-09 16:04:01.199989+00	99	97
278	2020-03-09 16:04:01.20471+00	97	99
279	2020-03-09 16:04:01.243228+00	99	93
280	2020-03-09 16:04:01.248945+00	93	99
281	2020-03-09 16:04:01.354412+00	99	98
282	2020-03-09 16:04:01.358713+00	98	99
283	2020-03-09 16:40:08.216727+00	100	101
284	2020-03-09 16:40:08.22084+00	101	100
285	2020-03-09 18:17:40.032468+00	7	91
286	2020-03-09 18:17:40.039259+00	91	7
287	2020-03-09 18:58:20.423543+00	93	98
288	2020-03-09 18:58:20.443099+00	98	93
289	2020-03-09 22:13:00.27012+00	107	101
290	2020-03-09 22:13:00.274875+00	101	107
291	2020-03-09 23:55:22.636559+00	24	43
292	2020-03-09 23:55:22.640291+00	43	24
293	2020-03-10 00:26:43.776717+00	17	88
294	2020-03-10 00:26:43.780155+00	88	17
295	2020-03-10 00:57:15.841884+00	61	20
296	2020-03-10 00:57:15.845171+00	20	61
297	2020-03-10 00:57:15.967298+00	61	52
298	2020-03-10 00:57:15.969931+00	52	61
299	2020-03-10 00:57:17.425519+00	61	46
300	2020-03-10 00:57:17.429126+00	46	61
301	2020-03-10 00:57:17.732579+00	61	50
302	2020-03-10 00:57:17.735267+00	50	61
303	2020-03-10 02:45:05.436112+00	113	27
304	2020-03-10 02:45:05.439817+00	27	113
305	2020-03-10 02:45:05.893407+00	113	73
306	2020-03-10 02:45:05.895692+00	73	113
307	2020-03-10 02:45:06.405681+00	113	7
308	2020-03-10 02:45:06.408407+00	7	113
309	2020-03-10 02:45:06.480632+00	113	23
310	2020-03-10 02:45:06.483484+00	23	113
311	2020-03-10 02:45:06.992142+00	113	30
312	2020-03-10 02:45:06.995269+00	30	113
313	2020-03-10 04:02:51.450079+00	111	101
314	2020-03-10 04:02:51.453919+00	101	111
315	2020-03-10 05:05:43.798099+00	111	112
316	2020-03-10 05:05:43.801422+00	112	111
317	2020-03-10 05:13:13.836395+00	114	49
318	2020-03-10 05:13:13.839105+00	49	114
319	2020-03-10 12:45:14.849292+00	116	40
320	2020-03-10 12:45:14.85281+00	40	116
321	2020-03-10 13:59:58.136318+00	117	76
322	2020-03-10 13:59:58.141348+00	76	117
323	2020-03-10 13:59:58.248156+00	117	44
324	2020-03-10 13:59:58.253354+00	44	117
325	2020-03-10 20:03:07.119504+00	17	100
326	2020-03-10 20:03:07.124209+00	100	17
327	2020-03-11 00:01:49.566165+00	111	26
328	2020-03-11 00:01:49.570974+00	26	111
329	2020-03-11 01:01:02.078063+00	80	8
330	2020-03-11 01:01:02.082091+00	8	80
331	2020-03-11 01:01:03.257546+00	24	8
332	2020-03-11 01:01:03.26208+00	8	24
333	2020-03-11 09:23:25.878228+00	119	73
334	2020-03-11 09:23:25.882152+00	73	119
335	2020-03-11 09:23:25.927497+00	119	66
336	2020-03-11 09:23:25.930641+00	66	119
337	2020-03-11 22:50:40.892169+00	111	45
338	2020-03-11 22:50:40.896755+00	45	111
339	2020-03-11 22:50:41.950578+00	42	45
340	2020-03-11 22:50:41.955678+00	45	42
341	2020-03-13 21:04:43.135774+00	111	105
342	2020-03-13 21:04:43.153628+00	105	111
343	2020-03-16 17:12:58.127917+00	122	32
344	2020-03-16 17:12:58.13481+00	32	122
345	2020-03-16 17:12:58.292039+00	122	46
346	2020-03-16 17:12:58.295063+00	46	122
347	2020-03-16 17:12:58.325593+00	122	8
348	2020-03-16 17:12:58.328959+00	8	122
349	2020-03-16 17:12:58.371205+00	122	20
350	2020-03-16 17:12:58.375459+00	20	122
351	2020-03-18 02:11:19.787353+00	123	7
352	2020-03-18 02:11:19.790391+00	7	123
353	2020-03-20 09:30:08.096485+00	124	24
354	2020-03-20 09:30:08.102407+00	24	124
355	2020-03-20 16:53:29.396644+00	124	17
356	2020-03-20 16:53:29.40598+00	17	124
357	2020-03-21 18:34:08.112518+00	124	8
358	2020-03-21 18:34:08.117166+00	8	124
359	2020-03-21 20:22:36.122206+00	124	18
360	2020-03-21 20:22:36.126337+00	18	124
361	2020-03-22 06:45:06.401282+00	126	124
362	2020-03-22 06:45:06.405617+00	124	126
363	2020-03-24 06:07:40.819504+00	131	6
364	2020-03-24 06:07:40.823092+00	6	131
365	2020-03-24 13:04:29.662568+00	124	56
366	2020-03-24 13:04:29.665994+00	56	124
367	2020-03-24 19:40:44.681556+00	124	69
368	2020-03-24 19:40:44.684456+00	69	124
369	2020-03-25 05:03:22.990221+00	135	6
370	2020-03-25 05:03:22.992608+00	6	135
371	2020-03-25 18:50:00.719175+00	136	20
372	2020-03-25 18:50:00.723338+00	20	136
373	2020-03-25 18:50:00.81476+00	136	46
374	2020-03-25 18:50:00.817506+00	46	136
375	2020-03-25 18:50:00.845405+00	136	50
376	2020-03-25 18:50:00.848247+00	50	136
377	2020-03-25 18:50:01.05862+00	136	61
378	2020-03-25 18:50:01.060707+00	61	136
379	2020-03-25 18:50:01.960093+00	136	8
380	2020-03-25 18:50:01.962823+00	8	136
381	2020-03-25 18:50:02.230022+00	136	32
382	2020-03-25 18:50:02.233043+00	32	136
383	2020-03-25 18:50:02.627411+00	136	52
384	2020-03-25 18:50:02.633065+00	52	136
385	2020-03-25 18:50:03.126689+00	136	18
386	2020-03-25 18:50:03.129695+00	18	136
387	2020-03-25 18:50:03.659238+00	136	26
388	2020-03-25 18:50:03.664462+00	26	136
389	2020-03-26 06:01:04.383022+00	133	127
390	2020-03-26 06:01:04.386074+00	127	133
391	2020-03-26 06:01:05.619279+00	132	127
392	2020-03-26 06:01:05.622085+00	127	132
393	2020-03-26 06:01:06.990854+00	137	127
394	2020-03-26 06:01:06.9941+00	127	137
395	2020-03-26 06:01:08.18874+00	131	127
396	2020-03-26 06:01:08.192091+00	127	131
397	2020-03-26 06:01:09.557286+00	126	127
398	2020-03-26 06:01:09.560006+00	127	126
399	2020-03-27 14:50:11.547468+00	124	19
400	2020-03-27 14:50:11.551293+00	19	124
401	2020-03-27 18:21:13.272865+00	124	38
402	2020-03-27 18:21:13.275833+00	38	124
403	2020-03-31 16:01:58.23393+00	139	73
404	2020-03-31 16:01:58.23611+00	73	139
405	2020-03-31 16:01:58.762755+00	139	57
406	2020-03-31 16:01:58.764507+00	57	139
407	2020-03-31 16:01:59.460865+00	139	79
408	2020-03-31 16:01:59.462807+00	79	139
409	2020-03-31 16:01:59.819265+00	139	7
410	2020-03-31 16:01:59.821048+00	7	139
411	2020-03-31 16:01:59.878701+00	139	35
412	2020-03-31 16:01:59.881318+00	35	139
413	2020-03-31 16:01:59.909433+00	139	30
414	2020-03-31 16:01:59.911118+00	30	139
415	2020-04-18 01:09:25.068884+00	126	6
416	2020-04-18 01:09:25.070729+00	6	126
417	2020-04-18 19:59:33.465321+00	142	141
418	2020-04-18 19:59:33.467618+00	141	142
419	2020-04-21 07:46:52.256065+00	143	6
420	2020-04-21 07:46:52.258117+00	6	143
421	2020-04-21 12:08:39.137606+00	143	141
422	2020-04-21 12:08:39.139938+00	141	143
423	2020-04-24 09:35:03.534617+00	144	6
424	2020-04-24 09:35:03.536464+00	6	144
425	2020-04-24 10:17:32.174253+00	144	143
426	2020-04-24 10:17:32.176539+00	143	144
427	2020-04-27 08:47:42.191687+00	141	6
428	2020-04-27 08:47:42.193589+00	6	141
429	2020-04-27 18:35:27.641427+00	145	141
430	2020-04-27 18:35:27.644022+00	141	145
431	2020-04-27 21:18:38.668598+00	145	6
432	2020-04-27 21:18:38.670454+00	6	145
433	2020-05-01 05:45:33.058012+00	132	6
434	2020-05-01 05:45:33.059858+00	6	132
435	2020-06-12 06:55:29.79874+00	132	143
436	2020-06-12 06:55:29.80222+00	143	132
437	2020-07-01 17:13:23.108594+00	132	141
438	2020-07-01 17:13:23.11051+00	141	132
439	2020-07-01 17:13:23.763894+00	132	145
440	2020-07-01 17:13:23.765242+00	145	132
441	2020-07-01 17:13:23.988101+00	132	131
442	2020-07-01 17:13:23.989528+00	131	132
443	2020-07-01 17:13:24.684019+00	132	144
444	2020-07-01 17:13:24.685303+00	144	132
445	2020-07-01 17:13:24.924297+00	132	142
446	2020-07-01 17:13:24.925632+00	142	132
447	2020-07-04 02:03:16.411155+00	147	132
448	2020-07-04 02:03:16.413503+00	132	147
\.


--
-- Data for Name: friendship_friendshiprequest; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.friendship_friendshiprequest (id, message, created, rejected, viewed, from_user_id, to_user_id) FROM stdin;
165	Please add me as a friend	2020-03-09 20:43:34.696414+00	\N	\N	107	106
211	Please add me as a friend	2020-03-18 10:42:18.545097+00	\N	\N	124	112
80	Please add me as a friend	2020-03-03 01:36:01.162369+00	\N	\N	17	14
167	Please add me as a friend	2020-03-09 21:26:57.295879+00	\N	\N	111	59
212	Please add me as a friend	2020-03-18 10:42:36.14578+00	\N	\N	124	105
129	Please add me as a friend	2020-03-06 00:42:05.350953+00	\N	\N	56	59
213	Please add me as a friend	2020-03-19 07:33:15.77708+00	\N	\N	124	2
172	Please add me as a friend	2020-03-10 00:38:58.84791+00	\N	\N	17	106
252	Please add me as a friend	2020-03-24 14:11:21.414142+00	\N	\N	126	112
174	Please add me as a friend	2020-03-10 00:39:30.614215+00	\N	\N	17	59
215	Please add me as a friend	2020-03-19 07:33:51.214002+00	\N	\N	124	53
54	Please add me as a friend	2020-02-26 12:18:05.476679+00	\N	\N	14	1
55	Please add me as a friend	2020-02-26 12:19:48.556993+00	\N	\N	14	2
218	Please add me as a friend	2020-03-19 07:35:16.7942+00	\N	\N	124	107
57	Please add me as a friend	2020-02-26 16:37:01.193566+00	\N	\N	13	1
58	Please add me as a friend	2020-02-27 04:43:57.107045+00	\N	\N	1	3
180	Please add me as a friend	2020-03-10 01:19:34.268371+00	\N	\N	111	106
219	Please add me as a friend	2020-03-19 07:35:25.830436+00	\N	\N	124	95
62	Please add me as a friend	2020-03-02 23:46:16.47913+00	\N	\N	17	2
64	Please add me as a friend	2020-03-02 23:46:34.104477+00	\N	\N	17	12
65	Please add me as a friend	2020-03-02 23:46:44.898025+00	\N	\N	17	1
148	Please add me as a friend	2020-03-07 13:49:52.495613+00	\N	\N	7	59
182	Please add me as a friend	2020-03-10 01:20:20.114478+00	\N	\N	111	97
220	Please add me as a friend	2020-03-19 07:35:36.536924+00	\N	\N	124	73
150	Please add me as a friend	2020-03-07 16:32:06.971045+00	\N	\N	84	59
221	Please add me as a friend	2020-03-19 07:35:45.421827+00	\N	\N	124	59
222	Please add me as a friend	2020-03-19 07:35:52.2292+00	\N	\N	124	7
223	Please add me as a friend	2020-03-19 07:35:59.259616+00	\N	\N	124	40
224	Please add me as a friend	2020-03-19 07:36:10.642481+00	\N	\N	124	98
171	Please add me as a friend	2020-03-10 00:38:20.882678+00	2020-03-10 04:04:06.962135+00	\N	17	101
189	Please add me as a friend	2020-03-10 04:31:37.13571+00	\N	\N	107	59
226	Please add me as a friend	2020-03-19 07:36:41.323346+00	\N	\N	124	31
194	Please add me as a friend	2020-03-10 20:03:45.094432+00	\N	\N	40	59
227	Please add me as a friend	2020-03-19 20:21:52.281787+00	\N	\N	127	120
196	Please add me as a friend	2020-03-11 03:28:47.533855+00	\N	\N	42	112
198	Please add me as a friend	2020-03-11 03:32:15.465905+00	\N	\N	42	59
199	Please add me as a friend	2020-03-11 03:33:32.924409+00	\N	\N	42	98
254	Please add me as a friend	2020-03-25 18:48:56.766394+00	\N	\N	126	133
202	Please add me as a friend	2020-03-13 18:47:44.440185+00	\N	\N	69	73
230	Please add me as a friend	2020-03-20 06:11:30.46969+00	\N	\N	124	93
231	Please add me as a friend	2020-03-20 06:12:20.316335+00	\N	\N	124	104
208	Please add me as a friend	2020-03-18 10:40:18.693308+00	\N	\N	124	12
209	Please add me as a friend	2020-03-18 10:41:29.772476+00	\N	\N	124	1
210	Please add me as a friend	2020-03-18 10:41:53.266804+00	\N	\N	124	26
234	Please add me as a friend	2020-03-20 06:14:50.16415+00	\N	\N	124	92
235	Please add me as a friend	2020-03-20 06:15:09.825894+00	\N	\N	124	45
237	Please add me as a friend	2020-03-21 08:12:41.794394+00	\N	\N	124	74
238	Please add me as a friend	2020-03-21 08:13:18.364826+00	\N	\N	124	97
239	Please add me as a friend	2020-03-21 08:13:29.129616+00	\N	\N	124	16
240	Please add me as a friend	2020-03-21 08:13:38.109177+00	\N	\N	124	103
241	Please add me as a friend	2020-03-21 08:16:51.082305+00	\N	\N	124	109
242	Please add me as a friend	2020-03-21 08:16:59.832988+00	\N	\N	124	110
243	Please add me as a friend	2020-03-21 08:22:45.56691+00	\N	\N	124	66
244	Please add me as a friend	2020-03-21 08:28:41.773095+00	\N	\N	124	3
249	Please add me as a friend	2020-03-24 07:08:22.138837+00	\N	\N	132	120
251	Please add me as a friend	2020-03-24 13:54:40.984746+00	\N	\N	133	120
264	Please add me as a friend	2020-03-25 19:51:14.535427+00	\N	\N	126	24
266	Please add me as a friend	2020-03-26 05:58:29.756422+00	\N	\N	137	133
274	Please add me as a friend	2020-04-18 01:15:51.545366+00	\N	\N	126	2
275	Please add me as a friend	2020-04-18 19:51:52.762855+00	\N	\N	141	2
285	Please add me as a friend	2020-06-03 14:30:27.95773+00	\N	\N	143	145
288	Please add me as a friend	2020-06-29 04:08:52.753438+00	\N	\N	143	53
289	Please add me as a friend	2020-06-30 18:43:24.26326+00	\N	\N	146	143
290	Please add me as a friend	2020-06-30 18:45:00.08438+00	\N	\N	146	144
\.


--
-- Data for Name: push_notifications_apnsdevice; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.push_notifications_apnsdevice (id, name, active, date_created, device_id, registration_id, user_id, application_id) FROM stdin;
51	Simul	t	2020-02-24 14:03:44.14724+00	f073c682-fdc3-4a0f-a48f-968a3f2c8b01	fa598b59f05b97f40cb5e97566607547c73532c19d1b29de4b2b6febf6081351	12	com.weave.upp
40	Test Contact	t	2020-02-10 20:22:02.352549+00	81ef45c2-6370-4b64-8c99-e107e13896b8	6489756e2751411f566127b663e2da1054fcc320496b3ce03af3ecb8b80a6ea9	6	com.weave.up
41	Test	t	2020-02-10 20:57:46.718011+00	1c93579b-0715-4ae3-92b2-02718dc40fa9	a8f55a4fdd3ea74d66c226fef5b9f6d10aa7842373600f9d7772e5175679abc7	2	com.weave.up
42	Test Contact	t	2020-02-10 21:03:22.949463+00	5e6eb932-dbfb-4c32-bd43-5dc2663c2090	e660e392171ae46534e306d03e83f16bd9686f8fb73abe2fa99d300cf4ef9016	6	com.weave.up
38	David	t	2020-02-09 02:42:49.328922+00	7886279d-5f74-4a44-83ef-253e698b4b96	179c330ad4d3c990147ae550cf959d3e7a89b61a1cb4550b1872a854c1f35449	7	com.weave.up
37	Henry	t	2020-02-08 19:28:39.239802+00	028ef14b-59c3-45c3-b83c-9861448a2712	8b4c065d50e2f93af1af19a6a8ca8f4b5ad3ada450831f0e5e00ed9f57ab0f18	3	com.weave.up
47	Test	t	2020-02-12 17:46:27.444284+00	33fb74db-430c-428b-bcc4-7654fc97fc8b	0a6dae15bdd690bfcba98943eed585b7f4142e3ea77bffc3b64ff7070c9c4445	2	com.weave.up
35	Henry	t	2020-02-08 10:34:25.659144+00	028ef14b-59c3-45c3-b83c-9861448a2712	fc26d195a011cea0941d68cc9530063345ed1915a6067e272a7b18e54b4ff007	3	com.weave.up
53	Simul	t	2020-02-25 03:04:15.950981+00	f073c682-fdc3-4a0f-a48f-968a3f2c8b01	590a0e84edb8ca0d8b5a9ccc0511c6470be296c064bc981adf1e36331cec82d2	12	com.weave.up
39	leo	t	2020-02-10 00:03:29.410691+00	77e37547-abdd-4423-97db-1bfe9866468e	64ae431b196845e599f674c3eb5b4d3c4eb290291a2d0035dc863626496d802f	8	com.weave.up
29	Test User	t	2020-02-04 02:40:38.680038+00	c0417f5a-7796-403c-9845-04004abdf898	1a5c525ab77bf0f6cbd5ae3d84ba267c3de880dee3e2860ebae7faf5dd9796ec	2	com.weave.up
68	Patrick Saul	t	2020-03-03 02:55:06.846245+00	dc510658-9e66-448c-856b-567a232ba3d6	5958f8750241d5ad08ed7bf7fb396c5549f0675c8b56c41b346a35926bad5315	31	com.weave.up
31	David	t	2020-02-07 15:52:53.025751+00	aa867403-a023-400b-b469-facae0e67bc3	eabc753936b40c9313fae10f33dedbe180fcba485767e6c1c3208598757176b2	7	com.weave.up
44	Test Contact	t	2020-02-11 02:56:53.445522+00	5e6eb932-dbfb-4c32-bd43-5dc2663c2090	d4ae45ef4338a5f462430b4f6b827bfe600eebaeb85705b83b8d7caf9742c0f4	6	com.weave.up
30	Henry	t	2020-02-07 09:13:09.216852+00	9bae4eeb-da0d-4fa4-8edd-b1c0336ce4c4	1daccea28a4c63611b868c8916618230313c528b3c453e32d19b932867c7dfd7	3	com.weave.up
33	Test	t	2020-02-08 10:26:29.772052+00	3b6f3fbd-4b86-4ca5-8c96-b0cff6e3e70e	428da1d8189e633013bd1b9d1a9b5325043346cc9211bed166096d665235f8e5	2	com.weave.up
34	Henry	t	2020-02-08 10:30:43.24608+00	8843c8a9-d55a-42d5-8dbb-3af4a880969d	a43c06eb4ade7b0597abb5d309c087f985feac074b000637c61a500a06b9bd5a	3	com.weave.up
36	Test	t	2020-02-08 10:37:13.291339+00	06b8fa56-b602-46de-901a-ad19e43dcf6b	504ec635aa7e4939ac803806dc6a26e1857939c01a8fcff71cd8254ae6574848	2	com.weave.up
32		t	2020-02-07 19:45:28.748224+00	ce3006b6-09eb-4e19-97fd-c3edef475904	49d527945d073fb78da31e99844ce31c69d07a29a6809a387c2462b5c34c79e9	8	com.weave.up
43	David	t	2020-02-11 01:19:51.116414+00	a65b1cd0-ab4b-4ae3-bcbc-37c1c99dd38b	0cec3336de0e7621af8d9e0c5b5e9543f25452ccfbe07bdfd0ba0e93203daf8c	7	com.weave.up
69	Darcy Muhoza	t	2020-03-03 02:59:26.653344+00	c87d6f83-88d8-4fa3-bb92-604ea202415c	8c6f1431d0e1d1cb811dca73dc3757e38ee21d6b6940199e78e3b7cd94306227	32	com.weave.up
46	Henry	t	2020-02-11 12:32:58.336024+00	a0126045-fc0a-49b8-a1cc-065b23beb2e3	b4177a81241972132cb74f3b16f2e83efef6f04e2eac6dc9b6222fe6a46dd97f	3	com.weave.up
50	fly	t	2020-02-18 17:58:02.031639+00	6986d44d-0d32-4b08-9fbc-69e7fbf9c77b	ba8672cd9aa6b6151c7602057fd716d58744fa49543fdd442588ce306c8213ba	10	com.weave.up
70	Rachael	t	2020-03-03 06:50:36.504476+00	11a439ac-69e9-40a8-87c4-c401da570c46	894a5bec270212f13ec77f45db6afda6805191ea064fbe50855ec737f3f90daa	33	com.weave.up
60	sonia	t	2020-03-03 00:35:40.155333+00	efd0e564-9fe4-44aa-b44d-c89c72806130	14289c9f874d67a339efd43807b56c5654f8944c2e06f35ac89c63ca134d35b2	23	com.weave.up
65	Bingwa	t	2020-03-03 01:59:19.320902+00	81fe8b0c-dbdb-42f4-a346-0ce2775d16cd	7f23b6e0f0751cf1f0b7b6543daeecea68cd79064189c76055200bf184d7292e	29	com.weave.up
27	User	t	2020-02-04 01:46:52.412085+00	f9079e68-2142-4da4-9f83-3fed4342c615	309012c43f499b7509c7b68082648cd92cbcc46fec18fae823b2663a9cfcc764	3	com.weave.up
24	Admin User	f	2020-02-03 02:53:07.287155+00	5e708d35-431b-4cc3-8cf2-786bff07c567	0a564f47d0febdc7b0e58006dd555d7a32930b799caaddd91a533fc3bdb43c12	1	com.weave.up
48	David	t	2020-02-13 01:27:28.329063+00	347ef2be-2c67-43ad-96fa-533d16bb1370	a739fbf8002cb87623dfcda416b35e3df757bae165b6ba57deafb2de91fababd	7	com.weave.up
52	Bogdan	t	2020-02-24 16:29:00.53374+00	86889afd-7c69-4ec5-a7fd-9f32d2fb2b44	1c91eaf48cc5d576015a7a9fc17b3618d7c3514a50e28e61383f8ca29ff1dd6d	1	com.weave.up
76	Nathalie	t	2020-03-03 18:12:22.388951+00	a295620f-bdcb-4dab-b27b-7ea1aeb55997	b050544dba053396c9ebac6e0dd8c443bbd45e35df2aab627b8d40b585ff5a03	44	com.weave.up
64	Navi	t	2020-03-03 01:58:57.866946+00	610df59a-a09f-493f-8c32-3027f0c57d80	0bc12a344a0476ff789a8856d166f237066334550182afe2b8469599fd1073ca	28	com.weave.up
58	ibbaaa	t	2020-03-02 23:45:44.093365+00	d44d724b-8c62-4e5e-962a-56c954e5884b	bc36a813ad29827c445dfbb068aef325f1db5150cc1f13e9e93683e060b6849a	19	com.weave.up
55	Herve	t	2020-03-02 23:33:23.085258+00	91a64af6-198c-4134-8045-7dddcb4e1c6f	3a139cf65963490d93ce51269d2526a7a96b5f830992134fc67e72b917096524	16	com.weave.up
66	Herve	t	2020-03-03 02:22:27.040737+00	d1aff545-7b17-4331-8c8e-a1c0d72af9e4	294a5e4cfd7a4bec9d16884c8e2850b850c5db8f531f4510e0267e3b3629d3c2	16	com.weave.up
62	rohit	t	2020-03-03 01:09:48.938794+00	3e01d776-847c-4a3b-bde2-ca2d6f18eec8	9e46cc97ce20ff4c16a3b65471872ba64626b913e92181b0aa5040de70efe72b	25	com.weave.up
75	Deborrah	t	2020-03-03 17:31:04.893196+00	60029308-a05d-460c-afb3-7a13cff7041c	60e375f463e32120613e41a539f18a7cf5d95f85c74c93a64223db1191c2b164	43	com.weave.up
71		t	2020-03-03 09:26:46.819138+00	ac5359ac-9272-499a-ab13-9f6784f79184	bab0093ab6ba4e6d09909a8413693458c60e85f1b2d3384bf6a0bd52ae0d9bdb	34	com.weave.up
67	Kalisa	t	2020-03-03 02:35:12.662978+00	770e0557-89fc-407f-8160-a7b097bddba7	f0d160d96fb8ae8092dfeeeff754aadcb1f8f79ca00b7fcc5ab95320231d8ec7	30	com.weave.up
49	David	t	2020-02-16 17:51:58.321225+00	16c63293-86ef-4841-a5b4-c5cf63602624	8c23362ee5b5cc90fdcdb497c3f02f35c908cdb6d24e748fa22e3b230667aaa0	7	com.weave.up
63	Rachel	t	2020-03-03 01:27:54.261771+00	808151b3-5bdc-44f6-b21e-e0ae30ed988b	ea2ed9d22455e20fe6a97dc1354a32cbfaf5c8883fa2800977980d5d014f7a83	26	com.weave.up
45	leo	t	2020-02-11 04:08:59.370992+00	6417579d-f8b3-46c3-935a-08aa9f15762a	bb8c4ce875ee769ec7a6ac960fc6f4301525d824effe255fa5d57a870428caad	8	com.weave.up
73	vp	t	2020-03-03 12:51:41.818113+00	64557f2c-4a6d-48d6-af47-1f57bdc0b70e	532940e5871b561ed86c0d2203e049a2d938a8f5af6d81753e3581d35f5ca700	36	com.weave.up
56	Gurjeet Singh	t	2020-03-02 23:39:20.475656+00	9cb63fea-f6b8-4af0-98ed-c541fb35371d	60cba5c8337ffd21acf73a93215cf3ad9daab478cfe6afeeae9d87fd0043183b	17	com.weave.up
72	Pati	t	2020-03-03 12:00:27.146083+00	4df38227-6bb4-4609-835d-36e9e122b238	fd2625a50fbfd7d46cb36b95ec3e6c47df7def1e2977571676daa7750d901a9b	35	com.weave.up
74	Abdallah	t	2020-03-03 16:56:27.81904+00	af868040-c392-45cb-9ac4-555bef6475fd	6c68e855308b3a402411e10a38b6693d850d8283161905c16aa97e1072392767	42	com.weave.up
59	Jeanne	t	2020-03-02 23:47:20.197186+00	fa77b83f-d2c6-4a19-bb29-51ad00ae4bb5	49c93519e7e62c1ad971dfd513f350084fb00e89b923ede2ee8c76010b8e3fd1	20	com.weave.up
57	Nobel Ruremesha	t	2020-03-02 23:41:06.270394+00	7416d0bd-b11a-4688-8d19-2eb7ee5b6713	e4f9898c9c42cdc4a5a357ae2bb89f09d2a057e1de20a74f0488643d4c95f5f7	18	com.weave.up
78	Manuel	t	2020-03-03 19:03:38.917106+00	3c5f2c4c-c8e2-49b7-a5e3-68295bd04548	6c2b5f1bb2dab57847d19396245522b141a3f5ee302bddea4522166491a8d329	38	com.weave.up
97	Dhillon	f	2020-03-05 15:22:40.175113+00	51e18343-2fdb-4ddd-8087-ddebc76ec98c	a27d7dad4a2ca6ae2186a4b6ba10fd76d51cb6ea643bbe79ea17e6c1f39e3841	68	com.weave.up
81		t	2020-03-03 23:17:42.243372+00	6f3a1b43-a725-4586-82cb-3028437a259c	a870998cc496c397a328027ed3a14ed5a673303e23493ef4b523fad9582c0139	48	com.weave.up
82	Ignace Nikwivuze	t	2020-03-04 00:07:27.028028+00	c53f7e25-3758-463d-a06f-12eb7c7e55a6	1725d82ae15c4625d6c6a51bd7669849e8107eb2642c72c1db21e6e013d88810	49	com.weave.up
111	Sarah	t	2020-03-09 14:37:03.307847+00	1dcbea91-0268-43a0-88df-05fb6b5b0412	25270730a4eedffa18809dbc4a37d7100c8af0c863c4d407c62e49779c2f75af	92	com.weave.up
124	Maryam	t	2020-03-09 18:38:25.438073+00	1c0e9318-fb58-4bba-afc6-e6d4e877c281	68e90151e0176bb2f7b9773d25e3b52b557f36f82f68e8a0ee89ccc024f1e205	105	com.weave.up
107	Pankit	t	2020-03-08 03:08:47.292337+00	4fe254ee-71ef-4530-bc5d-087e04a94d66	86e84fc1adbff0e5b414eb0bd77e50a1ef4fc0dc90dd059381d0d26df3a8b52c	87	com.weave.up
77	Elsa	t	2020-03-03 18:23:18.666205+00	63d01e43-12a3-4a82-818c-e79a8d63ceac	e24160977c4204bf4fc15207d69c3e748651fc4c3743e3ddc112410ed3ac3f22	45	com.weave.up
90	Lameis	t	2020-03-04 20:28:53.146584+00	6735703f-00a1-4407-a2df-0e22e524e5a6	d3dbedc721fecbc8c5ae2d9ea6d78d0f4d90542aa9b672fb5a5345fdbe471bbd	59	com.weave.up
54	Khushpreet singh	t	2020-03-02 23:26:13.592427+00	cf516e63-c2ac-4e64-833a-2b06daf9b842	6e55ead9c112bd5e1b15ef16954708ce4c62cb7bd5f2bdef852056e95fffef1b	15	com.weave.up
122	Marwan	t	2020-03-09 17:57:07.705934+00	241001d8-d588-4c4f-ac05-d83a1b93e83c	2d985e5f60254287945b645119a91344e50d83d8eb17628db03920c5b1672218	103	com.weave.up
84	Cando	t	2020-03-04 00:25:10.510967+00	37bd8169-b817-4ccc-87c4-de8e045b38a6	4b60627a0a23053b51c3239fb161af91f162a57e347dd540c5d13a872dfcc54e	51	com.weave.up
113		t	2020-03-09 15:12:53.56257+00	f4a9aa00-8ba3-420e-a4ed-74c3d17f0f2d	a29cecd2d01de87909e9ca312b27ee3e24a7c987f1f6fcd9f12e32f1a3970161	94	com.weave.up
86	Joannie	t	2020-03-04 15:04:26.028098+00	39451ddd-69d5-4b1f-b835-9c59e6e7f0d4	db19fc47b940fa780bb233c37af9d566d9e15d1a050a1a21890eedb4a9a61784	55	com.weave.up
123	Jared	t	2020-03-09 18:24:05.683632+00	e84b4caa-417a-4d18-bd86-b40e5b13a5e0	8e35e4514776b013102a6d4803082289cb582f976d289584d7e8196d183dbd54	104	com.weave.up
89	gabb23	t	2020-03-04 19:43:09.374603+00	71e2b213-710b-42e5-89bc-de4ae7214792	d25af00e91cdda76ec3ecc01fad7bc2423fd7048ebe81509ffa6e6c9094fde51	58	com.weave.up
96		t	2020-03-05 14:15:54.989048+00	1602c34b-f3a7-4036-ac92-639d9c74cb16	872163a19546f27bebece9f2e5ecfbfc72efbd639435723c48febf361c15248e	67	com.weave.up
100		t	2020-03-06 02:12:05.642675+00	94392be0-e246-4ccb-8bd5-439cb7485eac	d31923212053a12bbfc618ae6c5f0039671862afdd5758294cf614dde23541a7	72	com.weave.up
92	test	t	2020-03-05 01:19:18.750968+00	59e79c6c-ff19-4aaa-b2ee-2db3827e2cc3	d4859208e7bda0ab0ee8bad291a00f14e0886de06fb2da102b8dcc9759691c4c	62	com.weave.up
93		t	2020-03-05 01:59:38.911515+00	88ec5d8f-ebc6-4725-b174-8f26d55f358e	72c25c38175cc71601bc71f6996e245013337d56bb492369f636950bc2715eb0	63	com.weave.up
95		t	2020-03-05 03:32:12.678622+00	e7bd254b-3893-405e-8b66-ed26c635aa48	8a033015d3cb77594c6b472c6d0438450187d8fe8587fd0b9971053ef65ad950	66	com.weave.up
105		t	2020-03-06 21:54:59.761017+00	a715f7ad-8e9c-4457-acdc-00eeb924df13	009e87432d57572f0f23efd6b8413152115670d55ee38150e51827542f1bf0b2	79	com.weave.up
120	Reed	t	2020-03-09 16:39:37.672073+00	5b54a8d1-cbe5-4683-9f24-9c6285910e1c	a7faac6377d691271a090d964f4ab44ee18cae6456b1fd73e968103b951a9888	101	com.weave.up
108	Cory	t	2020-03-09 01:12:21.498133+00	6d8d4788-79d1-49d4-b323-ee045f57a14d	4e4f2e5315938895368609b5389f1e1c0c1fb7cf0a94b66bc2b9cfe8e2dd53c7	81	com.weave.up
91	vanessa	t	2020-03-05 01:11:32.84605+00	03574ff2-1da7-4297-8ec2-084853d9527f	d42b25242540c37fca5e7c19b5317ff51b5ecab53de08e91a7bc5f8fb0c59ca1	61	com.weave.up
83	wase	t	2020-03-04 00:10:52.559731+00	5e15d795-b4c6-45df-aa3f-6ab2cafda1bd	3b94e3eb6aacc07a86bb166ec376409ec761cedb699157ae36b55c15bdb6759b	50	com.weave.up
99	Balzak	t	2020-03-06 01:40:27.304875+00	ce586b05-0a2d-4058-b3f6-f6e58ac650ac	56e0f7f4e53a79550323496a48e87db80aab415da66ab3a74173e1066ccc36f6	71	com.weave.up
94	Virgo woman 🤩	t	2020-03-05 02:19:31.273738+00	b3f8915d-dc91-4f83-8a3e-6d7527ecd704	183c4f41f97dd9599ca1ba449a6b0ae693fb8b6a07506dbbadd3bb3964740789	64	com.weave.up
87	Carlos	t	2020-03-04 15:06:42.374259+00	0f69335d-54b4-450c-a4b2-e1361d62f099	831d29fd4a02182031ed840277d63f5b1c3f10fc1c8d89601f7225acdeefcdfa	56	com.weave.up
104	Pla6de	t	2020-03-06 19:27:20.084688+00	b6c0bc11-bd0f-48c7-88ec-12af7b39a5d3	d76aff6b05b910b7ce3e06a115580abeacf7e2bca9f0510b474024433394956d	78	com.weave.up
116	Heba	t	2020-03-09 16:01:42.483652+00	5d72fc6b-5037-44c2-b06e-c6aaf2ad84f0	402271d4db083a2eac755298376a3e4ecbd09c24d6b327f711a719ce9c13f056	97	com.weave.up
110		t	2020-03-09 03:15:44.646265+00	11380417-3e97-4e90-a167-63c113b2c030	d057b44935c8019262e0524433c762d4189515de47a075742c5e3e8cbfd5917b	89	com.weave.up
88	Alexis	t	2020-03-04 17:42:31.79092+00	b80999ef-366a-4cbc-9c6e-7f7f2a732a06	0322e743e1a904df1476a00d23046d9e125cb139b701d3dc2040fa99332c3aa0	57	com.weave.up
115		t	2020-03-09 15:47:26.605019+00	adbd7fc5-b024-4ac5-91bd-1997debe18f4	7d90f2ec5131787bc3ad4bb71f2815dd58b1f330db6f043d82856a182ebb21cd	96	com.weave.up
112	Moe	t	2020-03-09 14:52:48.200949+00	08995d1c-9ea9-4fd6-97c6-3f1659418ee7	a2327245703cac460c69e62a84cacbff1af122f6eb6fba0a6b27c471af344860	93	com.weave.up
85	Blameless	t	2020-03-04 00:40:51.159645+00	9b3c3da2-36c7-4004-a6cb-1c59147779c8	ccdfe106ee345526190cd06421c31f50e3a5bb507744a80d5369c428d7f8689c	53	com.weave.up
103		t	2020-03-06 18:24:52.437139+00	be1b7c73-6f72-465a-94de-0442896373cd	4e7e7edcbcfde7744dc4d71c7d4278da1693b39f6bc33f5b9b541d4f1af23c4c	76	com.weave.up
106	ninenty-nine	t	2020-03-08 00:25:08.435814+00	a7434804-53d5-4199-a24b-83c99a028a9e	741a696b61ba2856788250a1f39d375b49503bfb1c9c639d6b33dcd5b76012ae	86	com.weave.up
119	Aislinn	t	2020-03-09 16:38:57.208062+00	0e78e2f3-2e9b-43ba-a8eb-da785fd2915f	8bebeabcdf9def9d0bb37d4b5a96d11f29c8f27160d895c653fa3745f7b2f5f1	100	com.weave.up
61	joel mutezintare	t	2020-03-03 00:46:04.670437+00	163aabd1-5d13-4e6b-8f84-0b44ce85e4af	c370070e76d3fcbcdd6e7f865f9f2b49b95ae8ce3480d283a81e3a41b1c1d701	24	com.weave.up
114	Ali	t	2020-03-09 15:20:33.105769+00	4cb2a1c8-d7ca-448f-93eb-8a1c356982d6	5b73864d14d504550b1a5630563cbfd86783552abe60f06df3bc11a5a7588b0b	95	com.weave.up
118	em	t	2020-03-09 16:02:52.623321+00	7d2603ba-fb54-4b7e-bb5c-3a836b9892fd	b77f06df0bdce493028ed03e90b44eb301081835a79426ccd3e6b47c731094bf	99	com.weave.up
79	Shaka Sanani	t	2020-03-03 21:19:24.549014+00	0777cacd-3b12-4922-8744-cfff8dcc25d3	1d736ef07a2f0651e6008349d01ac7db7f638750ab8c4a647c5ffc55cad738f1	46	com.weave.up
121		t	2020-03-09 17:49:24.599207+00	7a00e120-c50c-4052-8adf-5594b4e2db00	3eb770d8c39a53c07a05c2f21336e845f8b94c4c03163743555a3c2d2ffe70a5	102	com.weave.up
80	hawandeep	t	2020-03-03 21:57:38.874186+00	3408830e-71ce-487a-af22-9a7b5bcb2fb3	c04f7341f7c26cf8dc848283e9ae79ed4a0b8e9d21636131d6a80c8365e381b2	47	com.weave.up
117	Sarah	t	2020-03-09 16:02:15.945715+00	a5e16f4f-f1d9-4b37-8aa8-13e0a88db73f	41ca301eb5a563e9e96315a17b964e964ebf76fc691cf09905c0dbf540931879	98	com.weave.up
101	Peace	t	2020-03-06 03:56:07.419058+00	7e94ac1d-4ed6-4e06-bac3-d69880c7a3a0	1af06a8b7db686b81affb5cb291d106e072dfbce2c713dad9cd55190b0d0902f	73	com.weave.up
102	Emmanuel	t	2020-03-06 15:57:14.577461+00	85082c43-2b44-4026-8a10-91930df7cc29	3be4f3bb119d4b512ebd6ae6ff6769be8831db8ce0c43fe52fe0563d0d8569ee	74	com.weave.up
125		t	2020-03-09 18:49:27.479027+00	d0bdd762-3d99-4d88-8b8a-686ea6342a7b	937ba84db06f3bd4268d48c21d99180506cd39669e82021466a9e423505296d2	106	com.weave.up
138	Lucas Bianchi	t	2020-03-18 02:08:08.525672+00	6a40d07c-08fe-4df4-b457-86e5cec129ac	4917b6ea069dbf0e71a1defce2a77383dad1528c263b79a304f4f0c95dd755b2	123	com.weave.up
127		t	2020-03-09 19:49:44.138034+00	bb786476-a26e-4185-a41e-4d419a4d8f80	13491fa7dd1205cabf85106f9f8a726150bb319c76997a7bcb736e469fd71f7e	110	com.weave.up
135	Tracy	t	2020-03-11 09:19:47.237692+00	c1cb571f-428e-4083-b1c9-0e6ba0e3803a	8ccbc55db47741ec28ba2625e71ff612e7ac74dbe44ca90e8ea7cce2763cc44a	119	com.weave.up
141	Kim Jo Un	t	2020-03-19 20:20:26.820724+00	520cb32e-03aa-436c-8092-97b67b166fbf	598f7bf4713e076ac9c948451528f97b8091848a0b081f5f8709b12ca03a3447	127	com.weave.up
139	Alinane	t	2020-03-18 10:32:29.48162+00	eea9bfe9-5e50-478b-857d-009101230ae1	69592d03b5b1a15accac49e91cba646d48a97a797038a183d022d3f6d50528bb	124	com.weave.up
126	Omar	t	2020-03-09 19:06:20.293281+00	02ed4fc3-8753-4265-90b0-3db53aff97e7	a014627b2d772324db6bb995ffa1c7d25c0e48bab425d3bbe0f92091d8b59bf4	107	com.weave.up
143	ajay	t	2020-03-24 13:51:35.510643+00	7548b01b-b610-49f5-9402-8c9d70dce0e2	3e72938d8843aa16a0e28da1e028a1ee42ee6cab5997f08bd5e12f522d490725	133	com.weave.up
128	P	t	2020-03-09 21:23:57.125025+00	c6601101-d0ce-45f2-a005-7cbfc9bfe1d9	2e7fa25278da4fe62980f0c6fcc6ac41706b05d0fa69caada9b253c779105104	111	com.weave.up
129	carole	t	2020-03-09 23:22:32.530279+00	299e013a-1c79-441f-8f9d-4e8cc8f64070	fc7167ec27db2cc97e84850628322aadabfdaf2df48563b822b9bdd6b2fceaeb	112	com.weave.up
147	Mat	t	2020-04-02 15:25:47.728349+00	bca0bac0-a9ff-489c-a9f3-930695118d47	79c19bf0f30f373a99c9f77f81f89c7fdd2411d8d6ced0fa8aa67757dfa84c4e	126	com.weave.up
134		t	2020-03-11 04:49:26.082172+00	9713048b-2c8a-446f-b5d2-381c007e024a	939d3c7a495c6e578ed3b9ce6a30b0d28f480cba456a2054510776d13a67a814	118	com.weave.up
137		t	2020-03-16 17:11:11.553354+00	356a0506-e486-440b-9100-557d4ed71a2e	d84d8d65614a366ed588ad45f7c3581b1668c86fb03d275b141b487645e95bb1	122	com.weave.up
136	Devonshire	f	2020-03-16 13:20:44.169859+00	6485467e-7904-4832-abf8-91c62d3ee665	3aace8d0630477cf64f2d65139ccea0ac3d775b8af23372daa87836202e9b125	120	com.weave.up
145	Alpesh Chauhan	t	2020-03-26 04:50:19.878934+00	1b21805b-56b5-4d5f-981a-f27d4b6d4c7a	f13527e7575cb6f400afc026a15fa78abc443f822e0b77445cf0e4c67f67c8e3	137	com.weave.up
132		t	2020-03-10 13:55:08.953646+00	70dd0c7f-4a82-49af-b2a9-fd557ac41d09	658c9f7cc602390289c5ac3860effd2ed4796ee4e3bd9ed8809c4aa49b5d2b2f	117	com.weave.up
130	Sarah	t	2020-03-10 02:39:13.503354+00	c57b624d-4837-4b81-b05e-19d76ee60762	c74c3391369c3d840c78fab76d52958045c3e4e28f0e39e129f74cd0a2ce69d4	113	com.weave.up
146	Allan	t	2020-03-31 15:59:53.110812+00	c725376f-e775-4343-bc0e-0b97daf2c176	d852656984df0952a35dd071e4d22b4c18fc379a16fde816d045c840630ba89a	139	com.weave.up
144		t	2020-03-25 18:38:27.273262+00	c1fe96dc-c41a-4740-9bd2-ee4e2d087096	dfe84b223b6fd927058b83af0a5f124f63e0a48a778149c3bf868868f7517aef	136	com.weave.up
142		t	2020-03-22 04:03:30.435602+00	7287a23a-0093-4048-b102-5f94ae3899c4	52043c1d455eb7382c2ae3fb555ba43de62bd9f575e3450aa5d4b0e32e3a7c48	128	com.weave.up
109	David	t	2020-03-09 01:42:00.267216+00	65deb49c-9f6e-4b8f-a758-0c7dbd4b28be	e2e095a8534a6e7323853ede20bd773fb95d7c894eadb8c06efc2293f5fabafe	7	com.weave.up
140	Mat	t	2020-03-19 20:09:11.933584+00	6a354744-fbb0-49f6-abd1-94bfd25f7e32	e7f860e4ed634c3508a76b0462a1f08aa7cb153bb28ecf54b1a0ccc1ac929088	126	com.weave.up
98	mishari	t	2020-03-05 20:57:59.530321+00	7cd3ad57-b545-4410-8b52-ecc338faa4b2	9726593c8375126563cd1cae33ba76d3ea48ec4ea5c57d75186186dbf8674b8b	69	com.weave.up
133	clef	t	2020-03-11 03:56:32.22517+00	94fb8b5b-02ae-4f4f-acdb-173468789c13	f38ea1f688691e89c02bdde7a127315d3032a4bceb510961cdcc084d449ba255	91	com.weave.up
148		t	2020-04-13 11:18:28.099844+00	d4a360b3-4e22-4ed3-aa85-79ad5961418f	9d1ec13061c82f658d51e9efb6bc6f05d49bfab7ff6ecebb924f550667e600dd	\N	com.weave.up3
149		t	2020-04-13 12:07:48.57122+00	129cecb4-0bc1-4f13-88f0-b8828d400420	2eb1fc5a960546727d43b7502281a44bcf50b2f08d28c527015ff44958a5ff91	\N	com.weave.up3
150		t	2020-04-13 12:28:08.7554+00	12d6ad0b-2fdc-40a6-8f9a-9365f142e3fb	a550216cba0e278458bfc490ce3449b7d53c2f157b9751213c04e2a7dea9639d	\N	com.weave.up3
131	Christmas	f	2020-03-10 04:19:31.359691+00	2a4ede09-32f3-4388-ac04-5f7a5231462c	1f950b74fc49c502713f2da14d9e3cb7ccf11ace79492a1db2c533691b757015	114	com.weave.up
165	Sunny Singh	t	2020-07-08 05:46:13.251741+00	d7a1cbfb-5b9a-4354-8ad0-cae7383a0ecb	e5199db804dbb086af9302e8beb2d4bfcb1bf8c7574005a764934f3088fd6bd6	132	com.tycho.FloodRadar
151	Anshumaan	t	2020-04-27 18:25:39.870148+00	40dfd3aa-1f8c-4437-ac89-5e229972b04e	c6832b3c49959946f64865a21711efaa2fc8762eb9340609519a10a23b76fb26	141	com.aha.ahaflix
158	Neeraj	t	2020-06-24 21:28:27.399526+00	d0b889af-9e01-415e-8837-7d949adb39c5	99505be809a5b437d98912c88e3bd61cff3e8b1c837cc3e9417bf60b68ea2993	143	com.svf.mawja
162	Sunny Singh	t	2020-07-07 15:43:06.867459+00	d7a1cbfb-5b9a-4354-8ad0-cae7383a0ecb	668747ffb4b594acbd4fe88fb16da31599bbea033c296b3248d416a1e04738b1	132	com.tycho.FloodRadar
163	Sunny Singh	t	2020-07-08 03:28:00.699213+00	d7a1cbfb-5b9a-4354-8ad0-cae7383a0ecb	5205eecd1dd216cc034eaa7712b587f02b6c79f19d4249060fbbb28851be9a70	132	com.tycho.FloodRadar
155	Sunny Singh	t	2020-05-01 10:51:53.360965+00	a7c86207-d998-4702-bf09-9d80456854e2	5ee53592a29bdd9345d2b0edb529228f12f8f88f6984fbe5e5572372ea36c66a	132	com.viewlift.hoichoi
161	Sunny Singh	t	2020-07-03 05:33:34.034112+00	867839c4-9151-4f00-a2a1-e4a5e6322247	aea24ed9306c4482790a8144e89473d9eb4c3872f2612bd532198751f0083031	132	com.svf.mawja
152	praveen	t	2020-04-27 18:30:11.539411+00	c9077433-8260-4576-a9f2-dcb6f346e5d5	a0eab01df3f8f7e132d2a922f4b3ea4b93469f1e740f18c5c4888a9efb4ce609	145	com.aha.ahaflix
168	Neeraj	t	2020-07-22 11:37:56.080842+00	d55572ea-538f-4cb1-ac48-f69c19b188c1	c25c828eff76228eb48a86409e62ea163b69576741647df78ffb31de1224ece1	143	com.svf.mawja
154	Anshumaan	t	2020-04-28 07:19:03.601181+00	474ac2c5-ef4b-4a0f-8878-d6d62394ca3e	7f9df013182898b61b7cd0c58396643e9ce2aec68589f5db92f75e2777ab274a	141	com.svf.mawja
164	Neeraj	t	2020-07-08 05:38:07.536598+00	2aa812f4-1c00-4863-a33c-fe493ea10e45	f2be864982203fd1b4b91622e52ed51f9812563f8b26a5853856d2dcebd9be16	143	com.tycho.FloodRadar
156	Man	t	2020-05-05 15:49:07.245431+00	02496a2b-a284-4014-82e8-104ea208884b	736b35953c65fe4c23e5cc1f4e2e4f20c02c470111691bad6430af6a599102bd	126	com.weave.adhoc
153	praveen	t	2020-04-27 20:13:40.331014+00	8a7b64f2-ebce-4f3f-a1b4-a4bb81808601	a6cb015e97ab4c91275ead2d8bfd1a1315d3c42823b22e275e5ce81c8062cef0	145	com.svf.mawja
157	Sunny Singh	t	2020-06-08 06:14:07.407936+00	64432f9b-87fd-47dc-bd61-eb7723786781	15bb7d8410f89a533edcd6461e2025fefb4cdbe95bcc884af15e5828ed52ec42	132	com.svf.mawja
160	raha baby	t	2020-07-02 16:04:35.540884+00	b513eafd-325c-45e2-b433-c4938b4bdeb1	8e3ed8c97853211e164c8c41f54d73502dfa115372a642eecd4ae30d56e72b3e	147	com.svf.mawja
166	Sunny Singh	t	2020-07-12 05:40:54.938378+00	b19875d1-ffc8-4dba-8b75-20c91bbf8e56	768602d3180039de66078d61b1e9b0ef1601e78d76739e6f58d4f5b8ea077fee	132	com.weave.adhoc
159	Sunny Singh	t	2020-06-25 04:36:00.952549+00	440e80d0-b788-49a8-930a-4865c81be547	efd74e3a67b2862b3a4216d21259fd533d71ae0f652dd809ca8c1997a123885e	132	com.svf.mawja
167	Neeraj	t	2020-07-14 14:37:04.851859+00	75ca03ad-d86c-4079-8bce-bd18dcf67753	fcf51cd2abf863a6e200be5f9b724fbdfcdfd795b5d1ea68bd62ceb3918f44ea	143	com.weave.adhoc
\.


--
-- Data for Name: push_notifications_gcmdevice; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.push_notifications_gcmdevice (id, name, active, date_created, device_id, registration_id, user_id, cloud_message_type, application_id) FROM stdin;
\.


--
-- Data for Name: push_notifications_webpushdevice; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.push_notifications_webpushdevice (id, name, active, date_created, application_id, registration_id, p256dh, auth, browser, user_id) FROM stdin;
\.


--
-- Data for Name: push_notifications_wnsdevice; Type: TABLE DATA; Schema: public; Owner: weaveuser
--

COPY public.push_notifications_wnsdevice (id, name, active, date_created, device_id, registration_id, user_id, application_id) FROM stdin;
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Name: api_callinfo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.api_callinfo_id_seq', 1, false);


--
-- Name: api_customuser_black_list_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.api_customuser_black_list_id_seq', 1, false);


--
-- Name: api_customuser_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.api_customuser_groups_id_seq', 1, false);


--
-- Name: api_customuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.api_customuser_id_seq', 147, true);


--
-- Name: api_customuser_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.api_customuser_user_permissions_id_seq', 1, false);


--
-- Name: api_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.api_group_id_seq', 38, true);


--
-- Name: api_group_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.api_group_members_id_seq', 63, true);


--
-- Name: api_likemessage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.api_likemessage_id_seq', 108, true);


--
-- Name: api_phonetoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.api_phonetoken_id_seq', 376, true);


--
-- Name: api_voicemessage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.api_voicemessage_id_seq', 815, true);


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 72, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 236, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 18, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 46, true);


--
-- Name: friendship_friend_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.friendship_friend_id_seq', 448, true);


--
-- Name: friendship_friendshiprequest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.friendship_friendshiprequest_id_seq', 296, true);


--
-- Name: push_notifications_apnsdevice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.push_notifications_apnsdevice_id_seq', 168, true);


--
-- Name: push_notifications_gcmdevice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.push_notifications_gcmdevice_id_seq', 1, false);


--
-- Name: push_notifications_webpushdevice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.push_notifications_webpushdevice_id_seq', 1, false);


--
-- Name: push_notifications_wnsdevice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: weaveuser
--

SELECT pg_catalog.setval('public.push_notifications_wnsdevice_id_seq', 1, false);


--
-- Name: api_callinfo api_callinfo_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_callinfo
    ADD CONSTRAINT api_callinfo_pkey PRIMARY KEY (id);


--
-- Name: api_customuser_black_list api_customuser_black_lis_from_customuser_id_to_cu_c56e877e_uniq; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser_black_list
    ADD CONSTRAINT api_customuser_black_lis_from_customuser_id_to_cu_c56e877e_uniq UNIQUE (from_customuser_id, to_customuser_id);


--
-- Name: api_customuser_black_list api_customuser_black_list_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser_black_list
    ADD CONSTRAINT api_customuser_black_list_pkey PRIMARY KEY (id);


--
-- Name: api_customuser_groups api_customuser_groups_customuser_id_group_id_d5b0c2ab_uniq; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser_groups
    ADD CONSTRAINT api_customuser_groups_customuser_id_group_id_d5b0c2ab_uniq UNIQUE (customuser_id, group_id);


--
-- Name: api_customuser_groups api_customuser_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser_groups
    ADD CONSTRAINT api_customuser_groups_pkey PRIMARY KEY (id);


--
-- Name: api_customuser api_customuser_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser
    ADD CONSTRAINT api_customuser_phone_number_key UNIQUE (phone_number);


--
-- Name: api_customuser api_customuser_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser
    ADD CONSTRAINT api_customuser_pkey PRIMARY KEY (id);


--
-- Name: api_customuser_user_permissions api_customuser_user_perm_customuser_id_permission_9deacd8d_uniq; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser_user_permissions
    ADD CONSTRAINT api_customuser_user_perm_customuser_id_permission_9deacd8d_uniq UNIQUE (customuser_id, permission_id);


--
-- Name: api_customuser_user_permissions api_customuser_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser_user_permissions
    ADD CONSTRAINT api_customuser_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: api_customuser api_customuser_username_key; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser
    ADD CONSTRAINT api_customuser_username_key UNIQUE (username);


--
-- Name: api_group_members api_group_members_group_id_customuser_id_677f8473_uniq; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_group_members
    ADD CONSTRAINT api_group_members_group_id_customuser_id_677f8473_uniq UNIQUE (group_id, customuser_id);


--
-- Name: api_group_members api_group_members_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_group_members
    ADD CONSTRAINT api_group_members_pkey PRIMARY KEY (id);


--
-- Name: api_group api_group_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_group
    ADD CONSTRAINT api_group_pkey PRIMARY KEY (id);


--
-- Name: api_likemessage api_likemessage_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_likemessage
    ADD CONSTRAINT api_likemessage_pkey PRIMARY KEY (id);


--
-- Name: api_phonetoken api_phonetoken_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_phonetoken
    ADD CONSTRAINT api_phonetoken_pkey PRIMARY KEY (id);


--
-- Name: api_voicemessage api_voicemessage_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_voicemessage
    ADD CONSTRAINT api_voicemessage_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: friendship_friend friendship_friend_from_user_id_to_user_id_5aa078c0_uniq; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.friendship_friend
    ADD CONSTRAINT friendship_friend_from_user_id_to_user_id_5aa078c0_uniq UNIQUE (from_user_id, to_user_id);


--
-- Name: friendship_friend friendship_friend_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.friendship_friend
    ADD CONSTRAINT friendship_friend_pkey PRIMARY KEY (id);


--
-- Name: friendship_friendshiprequest friendship_friendshipreq_from_user_id_to_user_id_003053a1_uniq; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.friendship_friendshiprequest
    ADD CONSTRAINT friendship_friendshipreq_from_user_id_to_user_id_003053a1_uniq UNIQUE (from_user_id, to_user_id);


--
-- Name: friendship_friendshiprequest friendship_friendshiprequest_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.friendship_friendshiprequest
    ADD CONSTRAINT friendship_friendshiprequest_pkey PRIMARY KEY (id);


--
-- Name: push_notifications_apnsdevice push_notifications_apnsdevice_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.push_notifications_apnsdevice
    ADD CONSTRAINT push_notifications_apnsdevice_pkey PRIMARY KEY (id);


--
-- Name: push_notifications_apnsdevice push_notifications_apnsdevice_registration_id_key; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.push_notifications_apnsdevice
    ADD CONSTRAINT push_notifications_apnsdevice_registration_id_key UNIQUE (registration_id);


--
-- Name: push_notifications_gcmdevice push_notifications_gcmdevice_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.push_notifications_gcmdevice
    ADD CONSTRAINT push_notifications_gcmdevice_pkey PRIMARY KEY (id);


--
-- Name: push_notifications_webpushdevice push_notifications_webpushdevice_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.push_notifications_webpushdevice
    ADD CONSTRAINT push_notifications_webpushdevice_pkey PRIMARY KEY (id);


--
-- Name: push_notifications_wnsdevice push_notifications_wnsdevice_pkey; Type: CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.push_notifications_wnsdevice
    ADD CONSTRAINT push_notifications_wnsdevice_pkey PRIMARY KEY (id);


--
-- Name: api_callinfo_from_user_id_55baf918; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_callinfo_from_user_id_55baf918 ON public.api_callinfo USING btree (from_user_id);


--
-- Name: api_callinfo_to_user_id_51684b4b; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_callinfo_to_user_id_51684b4b ON public.api_callinfo USING btree (to_user_id);


--
-- Name: api_customuser_black_list_from_customuser_id_6a34c6b1; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_customuser_black_list_from_customuser_id_6a34c6b1 ON public.api_customuser_black_list USING btree (from_customuser_id);


--
-- Name: api_customuser_black_list_to_customuser_id_65df9312; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_customuser_black_list_to_customuser_id_65df9312 ON public.api_customuser_black_list USING btree (to_customuser_id);


--
-- Name: api_customuser_groups_customuser_id_9eb4b783; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_customuser_groups_customuser_id_9eb4b783 ON public.api_customuser_groups USING btree (customuser_id);


--
-- Name: api_customuser_groups_group_id_f049027c; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_customuser_groups_group_id_f049027c ON public.api_customuser_groups USING btree (group_id);


--
-- Name: api_customuser_location_id; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_customuser_location_id ON public.api_customuser USING gist (location);


--
-- Name: api_customuser_phone_number_ba82b40d_like; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_customuser_phone_number_ba82b40d_like ON public.api_customuser USING btree (phone_number varchar_pattern_ops);


--
-- Name: api_customuser_user_permissions_customuser_id_5365c9ba; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_customuser_user_permissions_customuser_id_5365c9ba ON public.api_customuser_user_permissions USING btree (customuser_id);


--
-- Name: api_customuser_user_permissions_permission_id_8735d73e; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_customuser_user_permissions_permission_id_8735d73e ON public.api_customuser_user_permissions USING btree (permission_id);


--
-- Name: api_customuser_username_f5ae5d7f_like; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_customuser_username_f5ae5d7f_like ON public.api_customuser USING btree (username varchar_pattern_ops);


--
-- Name: api_group_creater_id_75de38ff; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_group_creater_id_75de38ff ON public.api_group USING btree (creater_id);


--
-- Name: api_group_members_customuser_id_010a6887; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_group_members_customuser_id_010a6887 ON public.api_group_members USING btree (customuser_id);


--
-- Name: api_group_members_group_id_dca038f0; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_group_members_group_id_dca038f0 ON public.api_group_members USING btree (group_id);


--
-- Name: api_likemessage_message_id_f20950bc; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_likemessage_message_id_f20950bc ON public.api_likemessage USING btree (message_id);


--
-- Name: api_likemessage_user_id_509c1b9f; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_likemessage_user_id_509c1b9f ON public.api_likemessage USING btree (user_id);


--
-- Name: api_voicemessage_from_user_id_daa52ae3; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_voicemessage_from_user_id_daa52ae3 ON public.api_voicemessage USING btree (from_user_id);


--
-- Name: api_voicemessage_group_id_b029cbf2; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_voicemessage_group_id_b029cbf2 ON public.api_voicemessage USING btree (group_id);


--
-- Name: api_voicemessage_to_user_id_49e10304; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX api_voicemessage_to_user_id_49e10304 ON public.api_voicemessage USING btree (to_user_id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: friendship_friend_from_user_id_f229f783; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX friendship_friend_from_user_id_f229f783 ON public.friendship_friend USING btree (from_user_id);


--
-- Name: friendship_friend_to_user_id_0de15f5e; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX friendship_friend_to_user_id_0de15f5e ON public.friendship_friend USING btree (to_user_id);


--
-- Name: friendship_friendshiprequest_from_user_id_bbaf16e8; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX friendship_friendshiprequest_from_user_id_bbaf16e8 ON public.friendship_friendshiprequest USING btree (from_user_id);


--
-- Name: friendship_friendshiprequest_to_user_id_51d5a5a2; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX friendship_friendshiprequest_to_user_id_51d5a5a2 ON public.friendship_friendshiprequest USING btree (to_user_id);


--
-- Name: push_notifications_apnsdevice_device_id_0ac3cde3; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX push_notifications_apnsdevice_device_id_0ac3cde3 ON public.push_notifications_apnsdevice USING btree (device_id);


--
-- Name: push_notifications_apnsdevice_registration_id_5502bc8c_like; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX push_notifications_apnsdevice_registration_id_5502bc8c_like ON public.push_notifications_apnsdevice USING btree (registration_id varchar_pattern_ops);


--
-- Name: push_notifications_apnsdevice_user_id_44cc44d2; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX push_notifications_apnsdevice_user_id_44cc44d2 ON public.push_notifications_apnsdevice USING btree (user_id);


--
-- Name: push_notifications_gcmdevice_device_id_0b22a9c4; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX push_notifications_gcmdevice_device_id_0b22a9c4 ON public.push_notifications_gcmdevice USING btree (device_id);


--
-- Name: push_notifications_gcmdevice_user_id_f3752f1b; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX push_notifications_gcmdevice_user_id_f3752f1b ON public.push_notifications_gcmdevice USING btree (user_id);


--
-- Name: push_notifications_webpushdevice_user_id_e867e0a1; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX push_notifications_webpushdevice_user_id_e867e0a1 ON public.push_notifications_webpushdevice USING btree (user_id);


--
-- Name: push_notifications_wnsdevice_device_id_7e1c24c4; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX push_notifications_wnsdevice_device_id_7e1c24c4 ON public.push_notifications_wnsdevice USING btree (device_id);


--
-- Name: push_notifications_wnsdevice_user_id_670eff0d; Type: INDEX; Schema: public; Owner: weaveuser
--

CREATE INDEX push_notifications_wnsdevice_user_id_670eff0d ON public.push_notifications_wnsdevice USING btree (user_id);


--
-- Name: api_callinfo api_callinfo_from_user_id_55baf918_fk_api_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_callinfo
    ADD CONSTRAINT api_callinfo_from_user_id_55baf918_fk_api_customuser_id FOREIGN KEY (from_user_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_callinfo api_callinfo_to_user_id_51684b4b_fk_api_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_callinfo
    ADD CONSTRAINT api_callinfo_to_user_id_51684b4b_fk_api_customuser_id FOREIGN KEY (to_user_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_customuser_black_list api_customuser_black_from_customuser_id_6a34c6b1_fk_api_custo; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser_black_list
    ADD CONSTRAINT api_customuser_black_from_customuser_id_6a34c6b1_fk_api_custo FOREIGN KEY (from_customuser_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_customuser_black_list api_customuser_black_to_customuser_id_65df9312_fk_api_custo; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser_black_list
    ADD CONSTRAINT api_customuser_black_to_customuser_id_65df9312_fk_api_custo FOREIGN KEY (to_customuser_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_customuser_groups api_customuser_group_customuser_id_9eb4b783_fk_api_custo; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser_groups
    ADD CONSTRAINT api_customuser_group_customuser_id_9eb4b783_fk_api_custo FOREIGN KEY (customuser_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_customuser_groups api_customuser_groups_group_id_f049027c_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser_groups
    ADD CONSTRAINT api_customuser_groups_group_id_f049027c_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_customuser_user_permissions api_customuser_user__customuser_id_5365c9ba_fk_api_custo; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser_user_permissions
    ADD CONSTRAINT api_customuser_user__customuser_id_5365c9ba_fk_api_custo FOREIGN KEY (customuser_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_customuser_user_permissions api_customuser_user__permission_id_8735d73e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_customuser_user_permissions
    ADD CONSTRAINT api_customuser_user__permission_id_8735d73e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_group api_group_creater_id_75de38ff_fk_api_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_group
    ADD CONSTRAINT api_group_creater_id_75de38ff_fk_api_customuser_id FOREIGN KEY (creater_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_group_members api_group_members_customuser_id_010a6887_fk_api_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_group_members
    ADD CONSTRAINT api_group_members_customuser_id_010a6887_fk_api_customuser_id FOREIGN KEY (customuser_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_group_members api_group_members_group_id_dca038f0_fk_api_group_id; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_group_members
    ADD CONSTRAINT api_group_members_group_id_dca038f0_fk_api_group_id FOREIGN KEY (group_id) REFERENCES public.api_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_likemessage api_likemessage_message_id_f20950bc_fk_api_voicemessage_id; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_likemessage
    ADD CONSTRAINT api_likemessage_message_id_f20950bc_fk_api_voicemessage_id FOREIGN KEY (message_id) REFERENCES public.api_voicemessage(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_likemessage api_likemessage_user_id_509c1b9f_fk_api_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_likemessage
    ADD CONSTRAINT api_likemessage_user_id_509c1b9f_fk_api_customuser_id FOREIGN KEY (user_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_voicemessage api_voicemessage_from_user_id_daa52ae3_fk_api_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_voicemessage
    ADD CONSTRAINT api_voicemessage_from_user_id_daa52ae3_fk_api_customuser_id FOREIGN KEY (from_user_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_voicemessage api_voicemessage_group_id_b029cbf2_fk_api_group_id; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_voicemessage
    ADD CONSTRAINT api_voicemessage_group_id_b029cbf2_fk_api_group_id FOREIGN KEY (group_id) REFERENCES public.api_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: api_voicemessage api_voicemessage_to_user_id_49e10304_fk_api_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.api_voicemessage
    ADD CONSTRAINT api_voicemessage_to_user_id_49e10304_fk_api_customuser_id FOREIGN KEY (to_user_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_api_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_api_customuser_id FOREIGN KEY (user_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_api_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_api_customuser_id FOREIGN KEY (user_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: friendship_friend friendship_friend_from_user_id_f229f783_fk_api_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.friendship_friend
    ADD CONSTRAINT friendship_friend_from_user_id_f229f783_fk_api_customuser_id FOREIGN KEY (from_user_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: friendship_friend friendship_friend_to_user_id_0de15f5e_fk_api_customuser_id; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.friendship_friend
    ADD CONSTRAINT friendship_friend_to_user_id_0de15f5e_fk_api_customuser_id FOREIGN KEY (to_user_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: friendship_friendshiprequest friendship_friendshi_from_user_id_bbaf16e8_fk_api_custo; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.friendship_friendshiprequest
    ADD CONSTRAINT friendship_friendshi_from_user_id_bbaf16e8_fk_api_custo FOREIGN KEY (from_user_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: friendship_friendshiprequest friendship_friendshi_to_user_id_51d5a5a2_fk_api_custo; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.friendship_friendshiprequest
    ADD CONSTRAINT friendship_friendshi_to_user_id_51d5a5a2_fk_api_custo FOREIGN KEY (to_user_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: push_notifications_apnsdevice push_notifications_a_user_id_44cc44d2_fk_api_custo; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.push_notifications_apnsdevice
    ADD CONSTRAINT push_notifications_a_user_id_44cc44d2_fk_api_custo FOREIGN KEY (user_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: push_notifications_gcmdevice push_notifications_g_user_id_f3752f1b_fk_api_custo; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.push_notifications_gcmdevice
    ADD CONSTRAINT push_notifications_g_user_id_f3752f1b_fk_api_custo FOREIGN KEY (user_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: push_notifications_wnsdevice push_notifications_w_user_id_670eff0d_fk_api_custo; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.push_notifications_wnsdevice
    ADD CONSTRAINT push_notifications_w_user_id_670eff0d_fk_api_custo FOREIGN KEY (user_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: push_notifications_webpushdevice push_notifications_w_user_id_e867e0a1_fk_api_custo; Type: FK CONSTRAINT; Schema: public; Owner: weaveuser
--

ALTER TABLE ONLY public.push_notifications_webpushdevice
    ADD CONSTRAINT push_notifications_w_user_id_e867e0a1_fk_api_custo FOREIGN KEY (user_id) REFERENCES public.api_customuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

