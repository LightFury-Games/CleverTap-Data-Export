SELECT 
    cb.email,
    CASE WHEN b.email IS NOT NULL THEN 'Yes' ELSE 'No' END AS match_start_single_player,
    CASE WHEN c.email IS NOT NULL THEN 'Yes' ELSE 'No' END AS match_end_single_player,
    CASE WHEN d.email IS NOT NULL THEN 'Yes' ELSE 'No' END AS match_start_multiplayer,
    CASE WHEN e.email IS NOT NULL THEN 'Yes' ELSE 'No' END AS match_end_multiplayer

FROM clevertap.closed_beta_cycle_1 cb

LEFT JOIN (
    SELECT DISTINCT email
    FROM clevertap.Match_start_events
    WHERE game_mode = 'SinglePlayer'
    AND event_date BETWEEN DATE '2026-09-09' AND DATE '2026-09-12'
) b ON cb.email = b.email

LEFT JOIN (
    SELECT DISTINCT email
    FROM clevertap.Match_end_events
    WHERE game_mode = 'SinglePlayer'
    AND event_date BETWEEN DATE '2026-09-09' AND DATE '2026-09-12'
) c ON cb.email = c.email

LEFT JOIN (
    SELECT DISTINCT email
    FROM clevertap.Match_start_events
    WHERE game_mode = 'Multiplayer'
    AND event_date BETWEEN DATE '2026-09-09' AND DATE '2026-09-12'
) d ON cb.email = d.email

LEFT JOIN (
    SELECT DISTINCT email
    FROM clevertap.Match_end_events
    WHERE game_mode = 'Multiplayer'
    AND event_date BETWEEN DATE '2026-09-09' AND DATE '2026-09-12'
) e ON cb.email = e.email;
