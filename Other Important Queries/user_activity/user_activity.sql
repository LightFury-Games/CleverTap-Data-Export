
CREATE OR REPLACE VIEW clevertap.user_activity AS

SELECT *
FROM
(
    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM app_has_entered_foreground_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM app_will_enter_background_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM ball_result_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM bat_result_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM ftue_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM login_ended_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM login_started_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM match_end_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM match_start_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM matchmaking_ended_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM matchmaking_started_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM network_error_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM pack_open_completed_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM session_start_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM task_board_viewed_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM task_completed_notified_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM task_milestone_reward_claimed_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM task_reward_claimed_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM tos_accepted_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM tos_viewed_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'

    UNION ALL

    SELECT event_name, event_time, event_date, email, user_id, session_id, ct_app_version, device_model, device_make, device_ram
    FROM ftueskip_events
    -- WHERE email = 'nsgamingyt0701@gmail.com'
)
ORDER BY email, event_time;
