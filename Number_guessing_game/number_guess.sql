--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)
-- Dumped by pg_dump version 12.22 (Ubuntu 12.22-0ubuntu0.20.04.4)

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

DROP DATABASE number_guessing_game;
--
-- Name: number_guessing_game; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guessing_game WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guessing_game OWNER TO freecodecamp;

\connect number_guessing_game

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
-- Name: guessing_user; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.guessing_user (
    user_id integer NOT NULL,
    username character varying(22) NOT NULL
);


ALTER TABLE public.guessing_user OWNER TO freecodecamp;

--
-- Name: guessing_user_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.guessing_user_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guessing_user_user_id_seq OWNER TO freecodecamp;

--
-- Name: guessing_user_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.guessing_user_user_id_seq OWNED BY public.guessing_user.user_id;


--
-- Name: user_history; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.user_history (
    history_id integer NOT NULL,
    user_id integer NOT NULL,
    number_of_guesses integer NOT NULL
);


ALTER TABLE public.user_history OWNER TO freecodecamp;

--
-- Name: user_history_history_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.user_history_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_history_history_id_seq OWNER TO freecodecamp;

--
-- Name: user_history_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.user_history_history_id_seq OWNED BY public.user_history.history_id;


--
-- Name: guessing_user user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.guessing_user ALTER COLUMN user_id SET DEFAULT nextval('public.guessing_user_user_id_seq'::regclass);


--
-- Name: user_history history_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.user_history ALTER COLUMN history_id SET DEFAULT nextval('public.user_history_history_id_seq'::regclass);


--
-- Data for Name: guessing_user; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.guessing_user VALUES (1, 'Adrian Neil');
INSERT INTO public.guessing_user VALUES (2, 'Neilong');
INSERT INTO public.guessing_user VALUES (3, 'user_1757553660695');
INSERT INTO public.guessing_user VALUES (4, 'user_1757553660694');
INSERT INTO public.guessing_user VALUES (5, 'user_1757554147220');
INSERT INTO public.guessing_user VALUES (6, 'user_1757554147219');
INSERT INTO public.guessing_user VALUES (7, 'Robert');
INSERT INTO public.guessing_user VALUES (8, 'user_1757554883204');
INSERT INTO public.guessing_user VALUES (9, 'user_1757554883203');


--
-- Data for Name: user_history; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.user_history VALUES (1, 1, 4);
INSERT INTO public.user_history VALUES (2, 1, 2);
INSERT INTO public.user_history VALUES (3, 1, 3);
INSERT INTO public.user_history VALUES (4, 2, 11);
INSERT INTO public.user_history VALUES (5, 3, 536);
INSERT INTO public.user_history VALUES (6, 3, 413);
INSERT INTO public.user_history VALUES (7, 4, 979);
INSERT INTO public.user_history VALUES (8, 4, 80);
INSERT INTO public.user_history VALUES (9, 3, 590);
INSERT INTO public.user_history VALUES (10, 3, 404);
INSERT INTO public.user_history VALUES (11, 3, 62);
INSERT INTO public.user_history VALUES (12, 5, 349);
INSERT INTO public.user_history VALUES (13, 5, 458);
INSERT INTO public.user_history VALUES (14, 6, 9);
INSERT INTO public.user_history VALUES (15, 6, 181);
INSERT INTO public.user_history VALUES (16, 5, 682);
INSERT INTO public.user_history VALUES (17, 5, 795);
INSERT INTO public.user_history VALUES (18, 5, 659);
INSERT INTO public.user_history VALUES (19, 7, 13);
INSERT INTO public.user_history VALUES (20, 8, 874);
INSERT INTO public.user_history VALUES (21, 8, 113);
INSERT INTO public.user_history VALUES (22, 9, 736);
INSERT INTO public.user_history VALUES (23, 9, 155);
INSERT INTO public.user_history VALUES (24, 8, 280);
INSERT INTO public.user_history VALUES (25, 8, 942);
INSERT INTO public.user_history VALUES (26, 8, 801);


--
-- Name: guessing_user_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.guessing_user_user_id_seq', 9, true);


--
-- Name: user_history_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.user_history_history_id_seq', 26, true);


--
-- Name: guessing_user guessing_user_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.guessing_user
    ADD CONSTRAINT guessing_user_pkey PRIMARY KEY (user_id);


--
-- Name: user_history user_history_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.user_history
    ADD CONSTRAINT user_history_pkey PRIMARY KEY (history_id);


--
-- Name: user_history user_history_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.user_history
    ADD CONSTRAINT user_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.guessing_user(user_id);


--
-- PostgreSQL database dump complete
--

