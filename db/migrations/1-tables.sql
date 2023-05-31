-- USER PROFILE
CREATE TABLE IF NOT EXISTS public.profile (
	id  				UUID REFERENCES auth.users PRIMARY KEY NOT NULL,
	username 			TEXT NOT NULL,
	email 				TEXT NOT NULL,
	fullname 			TEXT,
	cover 				TEXT,
	about 				TEXT,
	website 			TEXT,
	facebook 			TEXT,
	linkedin 			TEXT,
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
);

-- STARTUPS 
CREATE TABLE IF NOT EXISTS public.startup (
	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	name 				TEXT NOT NULL,	
	description 		TEXT,
	cover 				TEXT,	
	country 			TEXT,
	likes				INT DEFAULT 0,
	owner 				UUID NOT NULL REFERENCES public.profile(id) ON DELETE RESTRICT,		
	points 				INT DEFAULT 0,	
	website 			TEXT,
	facebook 			TEXT,
	linkedin 			TEXT,
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
);

-- PITCH
CREATE TABLE IF NOT EXISTS public.pitch (

	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	problem 			TEXT,	
	solution 			TEXT,
	audience 			TEXT,		
	proposition 		TEXT,		
	roi 				TEXT,	
	needs 				TEXT,	
	startup 			UUID NOT NULL REFERENCES public.startup(id) ON DELETE RESTRICT,
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())

);

-- POSITION
CREATE TABLE IF NOT EXISTS public.position (
	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	title				TEXT NOT NULL,
	description			TEXT,
	availability		BOOLEAN DEFAULT TRUE,
	location			Text,
	timezone			Text,
	salary				Text,
	language			Text,
	startup 			UUID NOT NULL REFERENCES public.startup(id) ON DELETE RESTRICT,
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
);

-- STARTUP LIKES
CREATE TABLE IF NOT EXISTS public.startup_likes (
	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	startup 			UUID NOT NULL REFERENCES public.startup(id) ON DELETE RESTRICT,
	"user"				UUID NOT NULL REFERENCES public.profile(id) ON DELETE RESTRICT,
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
);

-- STARTUPS MEMBER
CREATE TABLE IF NOT EXISTS public.startup_member (
	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	position			UUID NOT NULL REFERENCES public.position(id) ON DELETE RESTRICT,
	startup 			UUID NOT NULL REFERENCES public.startup(id) ON DELETE RESTRICT,
	"user"				UUID NOT NULL REFERENCES public.profile(id) ON DELETE RESTRICT,
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
);


-- STARTUPS BACKER
CREATE TABLE IF NOT EXISTS public.startup_backer (
	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	investment			FLOAT NOT NULL DEFAULT 0,
	startup 			UUID NOT NULL REFERENCES public.startup(id) ON DELETE RESTRICT,
	"user"				UUID NOT NULL REFERENCES public.profile(id) ON DELETE RESTRICT,
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
);

-- CATEGORY
CREATE TABLE IF NOT EXISTS public.category (
	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	name 				TEXT NOT NULL,	
	description 		TEXT,
	color				TEXT,
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
);

-- STARTUPS CATEGORY
CREATE TABLE IF NOT EXISTS public.startup_category (
	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	startup				UUID NOT NULL REFERENCES public.startup(id) ON DELETE RESTRICT,
	category 			UUID NOT NULL REFERENCES public.category(id) ON DELETE RESTRICT,
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
);

-- MENTOR
CREATE TABLE IF NOT EXISTS public.mentor (
	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	cover 				TEXT,	
	country 			TEXT,
	"user" 				UUID NOT NULL REFERENCES public.profile(id) ON DELETE RESTRICT,		
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
);

-- MENTEE
CREATE TABLE IF NOT EXISTS public.mentee (
	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	mentor				UUID NOT NULL REFERENCES public.mentor(id) ON DELETE RESTRICT,
	startup 			UUID NOT NULL REFERENCES public.startup(id) ON DELETE RESTRICT,	
	status 				public.mentorship_status NOT NULL DEFAULT 'PENDING',
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
);

-- REVIEW
CREATE TABLE IF NOT EXISTS public.mentorship_review (
	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	mentor				UUID NOT NULL REFERENCES public.mentor(id) ON DELETE RESTRICT,
	mentee				UUID NOT NULL REFERENCES public.mentee(id) ON DELETE RESTRICT,	
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
);

-- SESSION
CREATE TABLE IF NOT EXISTS public.mentorship_session (
	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	mentor				UUID NOT NULL REFERENCES public.mentor(id) ON DELETE RESTRICT,
	mentee				UUID NOT NULL REFERENCES public.mentee(id) ON DELETE RESTRICT,
	link 				TEXT,
	status				public.mentorship_session_status NOT NULL DEFAULT 'PENDING',
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
);


-- COURSES
CREATE TABLE IF NOT EXISTS public.course (
	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	name 				TEXT NOT NULL,			
	cover 				TEXT,	
	status				public.course_status NOT NULL DEFAULT 'DRAFTING'	
	points 				INT DEFAULT 0,			
	duration 			INT DEFAULT 0,		
	introduction 		TEXT,
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
);

-- COURSES CATEGORY
CREATE TABLE IF NOT EXISTS public.course_category (
	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	course				UUID NOT NULL REFERENCES public.course(id) ON DELETE RESTRICT,
	category 			UUID NOT NULL REFERENCES public.category(id) ON DELETE RESTRICT,
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
);

-- STARTUPS COURSES
CREATE TABLE IF NOT EXISTS public.startup_course (
	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	startup 			UUID NOT NULL REFERENCES public.startup(id) ON DELETE RESTRICT,
	course				UUID NOT NULL REFERENCES public.course(id) ON DELETE RESTRICT,
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
);

-- SECTION
CREATE TABLE IF NOT EXISTS public.section (
	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	course				UUID NOT NULL REFERENCES public.course(id) ON DELETE RESTRICT,
	title 				TEXT,		
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
)

-- CHALLENGE
CREATE TABLE IF NOT EXISTS public.challenge (
	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	section				UUID NOT NULL REFERENCES public.section(id) ON DELETE RESTRICT,
	title 				TEXT NOT NULL,		
	tip 				TEXT,		
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
);

-- QUESTION
CREATE TABLE IF NOT EXISTS public.question (
	id 					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	challenge 			UUID NOT NULL REFERENCES public.challenge(id) ON DELETE RESTRICT,
	title 				TEXT,	
	subtitle 			TEXT,
	points 				INT DEFAULT 0,
	format				public.answer_format NOT NULL,
	created_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at          TIMESTAMP NOT NULL DEFAULT timezone('utc'::text, now())
);

-- ANSWER 
CREATE TABLE IF NOT EXISTS public.answer (
	id					UUID DEFAULT uuid_generate_v4() NOT NULL PRIMARY KEY,
	question			UUID NOT NULL REFERENCES public.question(id) ON DELETE RESTRICT,
	feedback			TEXT,
	"user"				UUID NOT NULL REFERENCES public.profile(id) ON DELETE RESTRICT,
)

alter table public.startup enable row level security;
alter table public.profile enable row level security;




