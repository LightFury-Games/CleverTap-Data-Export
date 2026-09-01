
select game_mode
        , count(distinct email) as match_start_users
        , count(1) as match_start_events 
from match_start_events
where cast(event_time as date) = cast('2026-08-22' as date)
    and ct_app_version = '9.4.0'
group by 1
order by 1 
;
