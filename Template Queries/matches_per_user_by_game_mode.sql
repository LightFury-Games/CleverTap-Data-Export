-- STAN Playtest 19th Aug
select game_mode
        , count(distinct match_id) as unique_matches
        , count(distinct email) as unique_users 
        ,  count(distinct match_id)*1.0/count(distinct email) as matches_per_user
from match_end_events  
where match_end_type = 'ematchendtype::completed'
    and event_date = cast('2026-08-19' as date)
group by 1 
;