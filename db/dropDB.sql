DROP SCHEMA public CASCADE;
DELETE FROM auth.users
where aud != null;
CREATE SCHEMA public;