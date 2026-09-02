select
       game_mode, 
       email, 
  sum(runs_scored) as total_runs,
  sum(case when is_four =  'Yes' then 1 else 0 end) as num_fours,
  sum(case when is_six = 'Yes' then 1 else 0 end) as num_sixes
from clevertap.bat_result_events
where event_date = cast('2026-08-22' as date )
group by 1 , 2 
order by total_runs desc
;
