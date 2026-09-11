
CREATE OR REPLACE VIEW clevertap.user_activity AS

SELECT *
FROM
(
    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM app_has_entered_foreground_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM app_will_enter_background_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM ball_result_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM bat_result_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM ftue_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM login_ended_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM login_started_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM match_end_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM match_start_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM matchmaking_ended_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM matchmaking_started_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM network_error_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM pack_open_completed_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM session_start_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM task_board_viewed_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM task_completed_notified_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM task_milestone_reward_claimed_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM task_reward_claimed_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM tos_accepted_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id
    FROM tos_viewed_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'
)
ORDER BY email, event_time;
