-- TAGS
DO $$ 
  BEGIN
    -- CREATE TYPE public.course_status AS ENUM (
    --   'DRAFTING', 
    --   'ACTIVE', 
    --   'OFFLINE'
    -- );
    CREATE TYPE public.mentorship_session_status AS ENUM (
      'PENDING', 
      'DECLINED', 
      'APPROVED'
      'UPCOMING'
      'COMPLETED'
    );
    CREATE TYPE public.answer_format AS ENUM (
      'MULTIPLE_CHOICE', 
      'ESSAY', 
      'LINK_UPLOAD', 
      'FILE_UPLOAD'
    );
    CREATE TYPE public.mentorship_status AS ENUM (
      'PENDING', 
      'ACCEPTED', 
      'REJECTED'
    );
    CREATE TYPE public.mentorship_status AS ENUM (
      'PENDING', 
      'ACCEPTED', 
      'REJECTED'
    );
     CREATE TYPE public.startup_status AS ENUM (
      'ACTIVE',
      'INACTIVE'
    );
    CREATE TYPE public.member_authority AS ENUM (
      'ADMIN',
      'MEMBER'
    );
    CREATE TYPE public.member_status AS ENUM (
      'PENDING',
      'DENIED', 
      'ACTIVE', 
      'INACTIVE'
    );
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;