

select cast(app_launch_date as varchar) as app_launch_date
        , count(distinct app_launchers.email) as app_launchers
        , count(distinct case when app_launch_date =  DATE '2026-09-16' THEN app_launchers.email ELSE ftue.email END) as login_success_users
        , count(distinct ftue.email) as ftue_users 
        , count(distinct pack_open_completed.email) as pack_open_completed_users 
        
        , count(distinct match_start.email) as match_start_users
        , count(distinct case when sp_start_flag = 1 then match_start.email end) as sp_match_start_users
        , count(distinct case when mp_start_flag = 1 then match_start.email end) as mp_match_start_users
        
        , count(distinct match_complete.email) as match_complete_users
        , count(distinct case when sp_complete_flag = 1 then match_complete.email end) as sp_match_complete_users
        , count(distinct case when mp_complete_flag = 1 then match_complete.email end) as mp_match_complete_users
        
        , sum(sp_match_starts) as sp_matches_played
        , sum(mp_match_starts) as mp_matches_played
        , sum(total_match_starts) as total_matches_played
        
        , sum(sp_match_completes) as sp_match_completed
        , sum(mp_match_completes) as mp_match_completed
        , sum(total_match_completes) as total_match_completed
from 
(
select distinct event_date as app_launch_date, email
from closed_beta_cycle_2 a 
join user_activity b using(email)
where event_date between DATE '2026-09-16' AND DATE '2026-09-19'
) as app_launchers 

left join 
(
select email, min(event_date) as ftue_date
from closed_beta_cycle_2 a 
join user_activity b using(email)
where event_date between DATE '2026-09-16' AND DATE '2026-09-19'
    and event_name in ('ftue', 'ftueskip')
group by 1
) as ftue 
on app_launchers.email = ftue.email and app_launch_date = ftue_date

left join 
(
select email, min(event_date) as pack_open_completed_date
from closed_beta_cycle_2 a 
join user_activity b using(email)
where event_date between DATE '2026-09-16' AND DATE '2026-09-19'
    and event_name in ('pack_open_completed')
group by 1
) as pack_open_completed 
on pack_open_completed.email = ftue.email and pack_open_completed_date = ftue_date

left join 
(
select event_date as match_start_date
    , email
    , max(case when game_mode = 'SinglePlayer' then 1 else 0 end) as sp_start_flag
    , max(case when game_mode = 'Multiplayer' then 1 else 0 end) as mp_start_flag
    
    , sum(case when game_mode = 'SinglePlayer' then 1 else 0 end) as sp_match_starts
    , sum(case when game_mode = 'Multiplayer' then 1 else 0 end) as mp_match_starts
    , count(1) as total_match_starts
    
from closed_beta_cycle_2 a 
join match_start_events b using(email)
where event_date between DATE '2026-09-16' AND DATE '2026-09-19'
group by 1,2
) as match_start 
on app_launchers.email = match_start.email and app_launch_date = match_start_date

left join 
(
select event_date as match_complete_date
    , email
    , max(case when game_mode = 'SinglePlayer' then 1 else 0 end) as sp_complete_flag
    , max(case when game_mode = 'Multiplayer' then 1 else 0 end) as mp_complete_flag
    
    , sum(case when game_mode = 'SinglePlayer' then 1 else 0 end) as sp_match_completes
    , sum(case when game_mode = 'Multiplayer' then 1 else 0 end) as mp_match_completes
    , count(1) as total_match_completes
    
from closed_beta_cycle_2 a 
join match_end_events b using(email)
where event_date between DATE '2026-09-16' AND DATE '2026-09-19'
    and match_end_type = 'ematchendtype::completed'
group by 1,2
) as match_complete 
on app_launchers.email = match_complete.email and app_launch_date = match_complete_date

group by 1 

union all

select 'Overall' as app_launch_date
        , count(distinct app_launchers.email) as app_launchers
        , count(distinct app_launchers.email) as login_success_users
        , count(distinct ftue.email) as ftue_users 
        , count(distinct pack_open_completed.email) as pack_open_completed_users 
        
        , count(distinct match_start.email) as match_start_users
        , count(distinct case when sp_start_flag = 1 then match_start.email end) as sp_match_start_users
        , count(distinct case when mp_start_flag = 1 then match_start.email end) as mp_match_start_users
        
        , count(distinct match_complete.email) as match_complete_users
        , count(distinct case when sp_complete_flag = 1 then match_complete.email end) as sp_match_complete_users
        , count(distinct case when mp_complete_flag = 1 then match_complete.email end) as mp_match_complete_users
        
        , sum(sp_match_starts) as sp_matches_played
        , sum(mp_match_starts) as mp_matches_played
        , sum(total_match_starts) as total_matches_played
        
        , sum(sp_match_completes) as sp_match_completed
        , sum(mp_match_completes) as mp_match_completed
        , sum(total_match_completes) as total_match_completed
from 
(
select distinct email
from closed_beta_cycle_2 a 
join user_activity b using(email)
where event_date between DATE '2026-09-16' AND DATE '2026-09-19'
) as app_launchers 

left join 
(
select email
from closed_beta_cycle_2 a 
join user_activity b using(email)
where event_date between DATE '2026-09-16' AND DATE '2026-09-19'
    and event_name in ('ftue', 'ftueskip')
group by 1
) as ftue 
on app_launchers.email = ftue.email 

left join 
(
select email
from closed_beta_cycle_2 a 
join user_activity b using(email)
where event_date between DATE '2026-09-16' AND DATE '2026-09-19'
    and event_name in ('pack_open_completed')
group by 1
) as pack_open_completed 
on pack_open_completed.email = ftue.email

left join 
(
select email
    , max(case when game_mode = 'SinglePlayer' then 1 else 0 end) as sp_start_flag
    , max(case when game_mode = 'Multiplayer' then 1 else 0 end) as mp_start_flag
    
    , sum(case when game_mode = 'SinglePlayer' then 1 else 0 end) as sp_match_starts
    , sum(case when game_mode = 'Multiplayer' then 1 else 0 end) as mp_match_starts
    , count(1) as total_match_starts
    
from closed_beta_cycle_2 a 
join match_start_events b using(email)
where event_date between DATE '2026-09-16' AND DATE '2026-09-19'
group by 1
) as match_start 
on app_launchers.email = match_start.email

left join 
(
select email
    , max(case when game_mode = 'SinglePlayer' then 1 else 0 end) as sp_complete_flag
    , max(case when game_mode = 'Multiplayer' then 1 else 0 end) as mp_complete_flag
    
    , sum(case when game_mode = 'SinglePlayer' then 1 else 0 end) as sp_match_completes
    , sum(case when game_mode = 'Multiplayer' then 1 else 0 end) as mp_match_completes
    , count(1) as total_match_completes
    
from closed_beta_cycle_2 a 
join match_end_events b using(email)
where event_date between DATE '2026-09-16' AND DATE '2026-09-19'
    and match_end_type = 'ematchendtype::completed'
group by 1
) as match_complete 
on app_launchers.email = match_complete.email

group by 1 
order by 1 
;

