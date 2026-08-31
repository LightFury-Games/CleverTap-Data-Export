CREATE TABLE clevertap.match_end_events_table
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/match_end_events/'
)
AS
SELECT *
FROM clevertap.match_end_events;