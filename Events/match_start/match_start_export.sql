CREATE TABLE clevertap.match_start_events_table
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/match_start_events/'
)
AS
SELECT *
FROM clevertap.match_start_events;