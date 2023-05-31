CREATE OR REPLACE FUNCTION public.toggle_startup_like(
    userId uuid, startupId uuid
) RETURNS public.startup_likes
AS $$
  DECLARE 
    result record;
   deleted INTEGER;
  
  BEGIN
    WITH row AS (
      DELETE FROM public.startup_likes
      WHERE "user" = toggle_startup_like.userId AND startup = toggle_startup_like.startupId
      RETURNING *
    )

    SELECT count(*) INTO deleted FROM row;
  
    IF deleted = 0 THEN
      
      INSERT INTO public.startup_likes ("user", startup)
      VALUES (toggle_startup_like.userId, toggle_startup_like.startupId);

    END IF;

    SELECT INTO result * FROM public.startup_likes WHERE "user" = toggle_startup_like.userId AND startup = toggle_startup_like.startupId;

    RETURN result;
  END;
$$ LANGUAGE plpgsql VOLATILE STRICT SECURITY DEFINER;
