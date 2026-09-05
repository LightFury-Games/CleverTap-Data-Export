
-- DAU
with dau as (
select event_date
    , count(distinct email) as dau
from user_activity
where event_date >= cast('2026-08-19' as date)
group by 1 
order by 1
),

-- Match Starts
match_starts as 
(
select event_date

    , count(distinct user_id) as match_start_users
    , count(distinct case when game_mode = 'Multiplayer' then user_id end) as mp_match_starters
    , count(distinct case when game_mode = 'SinglePlayer' then user_id end) as sp_match_starters
    
    , count(1) as match_start_events
    , sum(case when game_mode = 'Multiplayer' then 1 else 0 end) as mp_match_start_events
    , sum(case when game_mode = 'SinglePlayer' then 1 else 0 end) as sp_match_start_events
    
    , count(distinct match_id) as unique_match_starts
    , count(distinct case when game_mode = 'Multiplayer' then match_id end) as unique_mp_match_starts
    , count(distinct case when game_mode = 'SinglePlayer' then match_id end) as unique_sp_match_starts

from match_start_events 
where event_date >= cast('2026-08-19' as date)
group by 1
order by 1
),

-- Match Completes
match_completes as (
select event_date

    , count(distinct user_id) as match_complete_users
    , count(distinct case when game_mode = 'Multiplayer' then user_id end) as mp_match_completers
    , count(distinct case when game_mode = 'SinglePlayer' then user_id end) as sp_match_completers
    
    , count(1) as match_complete_events
    , sum(case when game_mode = 'Multiplayer' then 1 else 0 end) as mp_match_complete_events
    , sum(case when game_mode = 'SinglePlayer' then 1 else 0 end) as sp_match_complete_events
    
    , count(distinct match_id) as unique_match_completes
    , count(distinct case when game_mode = 'Multiplayer' then match_id end) as unique_mp_match_completes
    , count(distinct case when game_mode = 'SinglePlayer' then match_id end) as unique_sp_match_completes

from match_end_events 
where event_date >= cast('2026-08-19' as date) 
    and match_end_type = 'ematchendtype::completed'
group by 1
order by 1
),

-- Matchmaking Starts 
mm_starts as (
select event_date 
    , count(1) as matchmaking_start_events 
    , count(distinct user_id) as matchmaking_start_users 
from matchmaking_started_events 
where event_date >= cast('2026-08-19' as date)
group by 1
),

-- Matchmaking Success 
mm_ends as (
select event_date 
    , count(1) as matchmaking_success_events 
    , count(distinct user_id) as matchmaking_success_users 
from matchmaking_ended_events 
where event_date >= cast('2026-08-19' as date)
    and matchmaking_end_type = 'Succeeded'
group by 1
)

select *
        -- , match_complete_events*1.0/match_start_events as match_completion_rate
        -- , mp_match_complete_events*1.0/mp_match_start_events as mp_match_completion_rate
        -- , sp_match_complete_events*1.0/sp_match_start_events as sp_match_completion_rate
        
        , unique_match_completes*1.0/unique_match_starts as match_completion_rate
        , unique_mp_match_completes*1.0/unique_mp_match_starts as mp_match_completion_rate
        , unique_sp_match_completes*1.0/unique_sp_match_starts as sp_match_completion_rate
        
        , matchmaking_success_events*1.0/matchmaking_start_events as matchmaking_success_rate

from dau a 
left join match_starts b using(event_date)
left join match_completes c using(event_date)
left join mm_starts c using(event_date)
left join mm_ends c using(event_date)
-- where dau > 100
order by 1 
;
