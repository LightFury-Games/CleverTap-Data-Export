CREATE TABLE clevertap.matchmaking_ended_events_table
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/matchmaking_ended_events/'
)
AS
SELECT *
FROM clevertap.matchmaking_ended_events;