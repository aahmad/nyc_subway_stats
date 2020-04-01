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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: divisions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.divisions (
    division_id smallint NOT NULL,
    division text NOT NULL
);


--
-- Name: divisions_division_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.divisions_division_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: divisions_division_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.divisions_division_id_seq OWNED BY public.divisions.division_id;


--
-- Name: file_downloads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.file_downloads (
    file_download_id bigint NOT NULL,
    url text,
    processed_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: file_downloads_file_download_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.file_downloads_file_download_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: file_downloads_file_download_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.file_downloads_file_download_id_seq OWNED BY public.file_downloads.file_download_id;


--
-- Name: lines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lines (
    line_id smallint NOT NULL,
    line text NOT NULL
);


--
-- Name: lines_line_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lines_line_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lines_line_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lines_line_id_seq OWNED BY public.lines.line_id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: station_divisions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.station_divisions (
    station_division_id bigint NOT NULL,
    division_id smallint NOT NULL,
    station_id smallint NOT NULL
);


--
-- Name: station_divisions_station_division_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.station_divisions_station_division_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: station_divisions_station_division_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.station_divisions_station_division_id_seq OWNED BY public.station_divisions.station_division_id;


--
-- Name: station_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.station_events (
    station_event_id bigint NOT NULL,
    file_download_id bigint NOT NULL,
    control_area text NOT NULL,
    unit text NOT NULL,
    scp text NOT NULL,
    station_id smallint NOT NULL,
    event_at timestamp without time zone NOT NULL,
    description text,
    entries bigint NOT NULL,
    exits bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: station_events_station_event_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.station_events_station_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: station_events_station_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.station_events_station_event_id_seq OWNED BY public.station_events.station_event_id;


--
-- Name: station_lines; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.station_lines (
    station_line_id bigint NOT NULL,
    line_id smallint NOT NULL,
    station_id smallint NOT NULL
);


--
-- Name: station_lines_station_line_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.station_lines_station_line_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: station_lines_station_line_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.station_lines_station_line_id_seq OWNED BY public.station_lines.station_line_id;


--
-- Name: station_total_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.station_total_events (
    station_total_event_id bigint NOT NULL,
    station_event_id bigint NOT NULL,
    entries bigint NOT NULL,
    exits bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: station_total_events_station_total_event_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.station_total_events_station_total_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: station_total_events_station_total_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.station_total_events_station_total_event_id_seq OWNED BY public.station_total_events.station_total_event_id;


--
-- Name: stations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stations (
    station_id smallint NOT NULL,
    station text NOT NULL
);


--
-- Name: stations_station_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stations_station_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stations_station_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stations_station_id_seq OWNED BY public.stations.station_id;


--
-- Name: divisions division_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.divisions ALTER COLUMN division_id SET DEFAULT nextval('public.divisions_division_id_seq'::regclass);


--
-- Name: file_downloads file_download_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_downloads ALTER COLUMN file_download_id SET DEFAULT nextval('public.file_downloads_file_download_id_seq'::regclass);


--
-- Name: lines line_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lines ALTER COLUMN line_id SET DEFAULT nextval('public.lines_line_id_seq'::regclass);


--
-- Name: station_divisions station_division_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.station_divisions ALTER COLUMN station_division_id SET DEFAULT nextval('public.station_divisions_station_division_id_seq'::regclass);


--
-- Name: station_events station_event_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.station_events ALTER COLUMN station_event_id SET DEFAULT nextval('public.station_events_station_event_id_seq'::regclass);


--
-- Name: station_lines station_line_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.station_lines ALTER COLUMN station_line_id SET DEFAULT nextval('public.station_lines_station_line_id_seq'::regclass);


--
-- Name: station_total_events station_total_event_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.station_total_events ALTER COLUMN station_total_event_id SET DEFAULT nextval('public.station_total_events_station_total_event_id_seq'::regclass);


--
-- Name: stations station_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stations ALTER COLUMN station_id SET DEFAULT nextval('public.stations_station_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: divisions divisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.divisions
    ADD CONSTRAINT divisions_pkey PRIMARY KEY (division_id);


--
-- Name: file_downloads file_downloads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.file_downloads
    ADD CONSTRAINT file_downloads_pkey PRIMARY KEY (file_download_id);


--
-- Name: lines lines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lines
    ADD CONSTRAINT lines_pkey PRIMARY KEY (line_id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: station_divisions station_divisions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.station_divisions
    ADD CONSTRAINT station_divisions_pkey PRIMARY KEY (station_division_id);


--
-- Name: station_events station_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.station_events
    ADD CONSTRAINT station_events_pkey PRIMARY KEY (station_event_id);


--
-- Name: station_lines station_lines_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.station_lines
    ADD CONSTRAINT station_lines_pkey PRIMARY KEY (station_line_id);


--
-- Name: station_total_events station_total_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.station_total_events
    ADD CONSTRAINT station_total_events_pkey PRIMARY KEY (station_total_event_id);


--
-- Name: stations stations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stations
    ADD CONSTRAINT stations_pkey PRIMARY KEY (station_id);


--
-- Name: index_divisions_on_division; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_divisions_on_division ON public.divisions USING btree (division);


--
-- Name: index_lines_on_line; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_lines_on_line ON public.lines USING btree (line);


--
-- Name: index_station_divisions_on_division_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_station_divisions_on_division_id ON public.station_divisions USING btree (division_id);


--
-- Name: index_station_divisions_on_division_id_and_station_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_station_divisions_on_division_id_and_station_id ON public.station_divisions USING btree (division_id, station_id);


--
-- Name: index_station_divisions_on_station_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_station_divisions_on_station_id ON public.station_divisions USING btree (station_id);


--
-- Name: index_station_events_on_control_area_and_scp_and_event_at; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_station_events_on_control_area_and_scp_and_event_at ON public.station_events USING btree (control_area, scp, event_at);


--
-- Name: index_station_events_on_entries; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_station_events_on_entries ON public.station_events USING btree (entries);


--
-- Name: index_station_events_on_event_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_station_events_on_event_at ON public.station_events USING btree (event_at);


--
-- Name: index_station_events_on_exits; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_station_events_on_exits ON public.station_events USING btree (exits);


--
-- Name: index_station_events_on_file_download_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_station_events_on_file_download_id ON public.station_events USING btree (file_download_id);


--
-- Name: index_station_events_on_station_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_station_events_on_station_id ON public.station_events USING btree (station_id);


--
-- Name: index_station_lines_on_line_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_station_lines_on_line_id ON public.station_lines USING btree (line_id);


--
-- Name: index_station_lines_on_line_id_and_station_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_station_lines_on_line_id_and_station_id ON public.station_lines USING btree (line_id, station_id);


--
-- Name: index_station_lines_on_station_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_station_lines_on_station_id ON public.station_lines USING btree (station_id);


--
-- Name: index_station_total_events_on_entries; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_station_total_events_on_entries ON public.station_total_events USING btree (entries);


--
-- Name: index_station_total_events_on_exits; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_station_total_events_on_exits ON public.station_total_events USING btree (exits);


--
-- Name: index_station_total_events_on_station_event_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_station_total_events_on_station_event_id ON public.station_total_events USING btree (station_event_id);


--
-- Name: stations__u_station; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX stations__u_station ON public.stations USING btree (station);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20200329164134'),
('20200329164240'),
('20200329164352'),
('20200329171232'),
('20200329171411'),
('20200329222718');


