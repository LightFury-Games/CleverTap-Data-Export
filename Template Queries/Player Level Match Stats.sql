SELECT 
    COALESCE(bat.email, ball.email)                 AS email,
    COALESCE(bat.total_runs, 0)                     AS total_runs,
    COALESCE(bat.num_fours, 0)                      AS num_fours,
    COALESCE(bat.num_sixes, 0)                      AS num_sixes,
    COALESCE(ball.wickets_taken, 0)                 AS wickets_taken,
    COALESCE(ball.no_balls_bowled, 0)               AS no_balls_bowled,
    COALESCE(ball.wide_balls_bowled, 0)             AS wide_balls_bowled

FROM (
    -- Aggregate batting stats at email level first
    SELECT
        email,
        SUM(runs_scored)                                        AS total_runs,
        SUM(CASE WHEN is_four = 'Yes' THEN 1 ELSE 0 END)       AS num_fours,
        SUM(CASE WHEN is_six = 'Yes' THEN 1 ELSE 0 END)        AS num_sixes
    FROM clevertap.bat_result_events
    WHERE CAST(event_time AS DATE) = CAST('2026-08-22' AS DATE)
    AND game_mode = 'Multiplayer'
    GROUP BY email
) bat

FULL OUTER JOIN (
    -- Aggregate bowling stats at email level first
    SELECT
        email,
        SUM(CASE WHEN is_wicket = 'Yes' THEN 1 ELSE 0 END)     AS wickets_taken,
        SUM(CASE WHEN is_no_ball = 'Yes' THEN 1 ELSE 0 END)     AS no_balls_bowled,
        SUM(CASE WHEN is_wide = 'Yes' THEN 1 ELSE 0 END)        AS wide_balls_bowled
    FROM clevertap.ball_result_events
    WHERE CAST(event_time AS DATE) = CAST('2026-08-22' AS DATE)
    AND game_mode = 'Multiplayer'
    GROUP BY email
) ball

ON bat.email = ball.email

ORDER BY total_runs DESC;
