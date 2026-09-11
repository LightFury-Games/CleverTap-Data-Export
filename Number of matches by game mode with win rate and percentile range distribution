WITH player_stats AS (
    SELECT
          game_mode
        , email
        , COUNT(DISTINCT match_id)                                          AS matches_played
        , COUNT(DISTINCT CASE WHEN match_result = 'Win'
                              THEN match_id END)                            AS wins
    FROM match_end_events
    WHERE match_end_type = 'ematchendtype::completed'
        AND event_date = CAST('2026-09-10' AS DATE)
        AND game_mode IN ('Multiplayer', 'SinglePlayer')
    GROUP BY 1, 2
)

SELECT
      game_mode

    -- Summary stats
    , SUM(matches_played)                                                   AS unique_matches
    , COUNT(DISTINCT email)                                                 AS unique_users
    , ROUND(
          SUM(matches_played) * 1.0
          / NULLIF(COUNT(DISTINCT email), 0)
      , 2)                                                                  AS matches_per_user
    , SUM(wins)                                                             AS total_wins
    , ROUND(
          SUM(wins) * 100.0
          / NULLIF(SUM(matches_played), 0)
      , 2)                                                                  AS win_rate_pct

    -- Percentile distribution of matches per user
    , APPROX_PERCENTILE(matches_played, 0.10)                              AS p10
    , APPROX_PERCENTILE(matches_played, 0.20)                              AS p20
    , APPROX_PERCENTILE(matches_played, 0.30)                              AS p30
    , APPROX_PERCENTILE(matches_played, 0.40)                              AS p40
    , APPROX_PERCENTILE(matches_played, 0.50)                              AS p50
    , APPROX_PERCENTILE(matches_played, 0.60)                              AS p60
    , APPROX_PERCENTILE(matches_played, 0.70)                              AS p70
    , APPROX_PERCENTILE(matches_played, 0.80)                              AS p80
    , APPROX_PERCENTILE(matches_played, 0.90)                              AS p90
    , APPROX_PERCENTILE(matches_played, 0.95)                              AS p95
    , APPROX_PERCENTILE(matches_played, 0.99)                              AS p99

FROM player_stats
GROUP BY 1
ORDER BY 1
;
