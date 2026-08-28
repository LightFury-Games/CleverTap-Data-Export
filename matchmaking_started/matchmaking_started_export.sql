CREATE TABLE clevertap.matchmaking_started_events_table
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/matchmaking_started_events/'
)
AS
SELECT *
FROM clevertap.matchmaking_started_events;