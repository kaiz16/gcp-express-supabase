GRANT USAGE ON SCHEMA public TO 
    postgres,
    anon,
    authenticated,
    service_role;

GRANT ALL ON SCHEMA public TO 
    postgres,
    anon,
    authenticated,
    service_role;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO 
    postgres,
    anon,
    authenticated,
    service_role;

GRANT USAGE, 
    SELECT ON ALL SEQUENCES IN SCHEMA public TO postgres,
    anon,
    authenticated,
    service_role;