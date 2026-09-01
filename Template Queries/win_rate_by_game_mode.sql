
select game_mode
        , sum(case when match_result = 'Win' then 1 else 0 end)*1.0/count(1) as win_rate 
        , sum(case when match_result = 'Win' then 1 else 0 end) as wins 
        , sum(case when match_result = 'Loss' then 1 else 0 end) as losses 
        , sum(case when match_result = 'Draw' then 1 else 0 end) as draws 
        , count(1) as total_match_sessions
        , count(distinct match_id) as unique_matches
from match_end_events 
where cast(event_time as date) >= cast('2026-08-19' as date)
    and match_end_type = 'ematchendtype::completed'
group by 1 
order by 1 
;
