select event_date
    , task_title
    , task_completers
    , dau 
    , task_completers*100.0/dau as perc_completion
from 
(
select event_date, count(distinct email) as dau
from closed_beta_cycle_1 a 
join user_activity b using(email) 
WHERE event_date >= CAST('2026-09-09' AS DATE)
group by 1
) a 
join 
(
SELECT event_date
    , task_title
    , COUNT(DISTINCT email) AS task_completers
FROM task_completed_notified_events
WHERE event_date >= CAST('2026-09-09' AS DATE)
group by 1,2 
) b using(event_date)
order by 1,2
;
