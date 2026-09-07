
select email 
    , coalesce(count_sp_matches_started, 0) as sp_match_starts
    , coalesce(count_sp_matches_completed, 0) as sp_matches_completed
    
    , coalesce(count_mp_matches_started, 0) as mp_match_starts
    , coalesce(count_mp_matches_completed, 0) as mp_matches_completed
from 
(
select distinct email
from user_activity
where event_date = cast('2026-09-05' as date)
    and email is not null
    and email <> ''
) a 
left join
(
select email
     , sum(case when game_mode = 'SinglePlayer' then 1 else 0 end) as count_sp_matches_started
     , sum(case when game_mode = 'Multiplayer' then 1 else 0 end) as count_mp_matches_started
from match_start_events 
where event_date = cast('2026-09-05' as date)
group by 1 
) b using(email)
left join
(
select email
     , sum(case when game_mode = 'SinglePlayer' then 1 else 0 end) as count_sp_matches_completed
     , sum(case when game_mode = 'Multiplayer' then 1 else 0 end) as count_mp_matches_completed
from match_end_events 
where event_date = cast('2026-09-05' as date)
    and match_end_type = 'ematchendtype::completed'
group by 1
) c using(email)
order by 1
;
