
with session_stats as (
select event_date 
        , email 
        , session_id 
        , min(event_time) as session_start_ts
        , max(event_time) as session_end_ts
        , count(distinct case when event_name = 'match_start' then 1 else 0 end) as matches_played

from clevertap.user_activity a 
join closed_beta_cycle_1 b using(email) 
WHERE event_date >= CAST('2026-09-09' AS DATE)
    -- and email = '060802indrajit@gmail.com'
group by 1,2,3 
)

select event_date
    , count(distinct email) as dau 
    , count(distinct email || session_id) as user_sessions
    , count(distinct email || session_id)*1.0/count(distinct email) as avg_sessions_per_user
    , sum(date_diff('second', session_start_ts, session_end_ts))/(60.0*count(distinct email || session_id)) AS avg_session_length_mins 
    , sum(date_diff('second', session_start_ts, session_end_ts))/(60.0*count(distinct email)) AS avg_daily_ts_mins 
    , sum(matches_played)*1.0/count(distinct email || session_id) as avg_matches_per_session
    , sum(matches_played)*1.0/count(distinct email) as avg_matches_per_user_per_day
from session_stats
group by 1 
order by 1 
;
