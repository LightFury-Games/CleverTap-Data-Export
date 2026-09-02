-- STAN Playtest
WITH player_matches AS (
    SELECT
        game_mode,
        email,
        COUNT(DISTINCT match_id) AS unique_matches
    FROM match_end_events
    WHERE match_end_type = 'ematchendtype::completed'
        AND event_date = CAST('2026-08-19' AS DATE)
        -- AND game_mode IN ('Multiplayer', 'SinglePlayer')
    GROUP BY 1, 2
)

SELECT
    game_mode,
    APPROX_PERCENTILE(unique_matches, 0.1) AS p10,
    APPROX_PERCENTILE(unique_matches, 0.2) AS p20,
    APPROX_PERCENTILE(unique_matches, 0.3) AS p30,
    APPROX_PERCENTILE(unique_matches, 0.4) AS p40,
    APPROX_PERCENTILE(unique_matches, 0.5) AS p50,
    APPROX_PERCENTILE(unique_matches, 0.6) AS p60,
    APPROX_PERCENTILE(unique_matches, 0.7) AS p70,
    APPROX_PERCENTILE(unique_matches, 0.8) AS p80,
    APPROX_PERCENTILE(unique_matches, 0.9) AS p90,
    APPROX_PERCENTILE(unique_matches, 0.9) AS p95,
    APPROX_PERCENTILE(unique_matches, 0.9) AS p99
FROM player_matches
WHERE game_mode IN ('Multiplayer', 'SinglePlayer')
GROUP BY game_mode
ORDER BY game_mode
;
