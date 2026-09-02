CREATE OR REPLACE VIEW clevertap.user_activity AS

select * 
from
(
select event_name, event_time, event_date, email, '' as user_id 
from app_launched_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from ball_result_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from bat_result_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from ftue_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from login_ended_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from login_started_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from match_end_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from match_start_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from matchmaking_ended_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from matchmaking_started_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from network_error_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from pack_open_completed_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from session_start_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from task_board_viewed_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from task_completed_notified_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from task_milestone_reward_claimed_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from task_reward_claimed_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from tos_accepted_events 
-- where email = 'nsgamingyt0701@gmail.com'

union all 

select event_name, event_time, event_date, email, user_id 
from tos_viewed_events 
-- where email = 'nsgamingyt0701@gmail.com'
)
order by email, event_time
;

