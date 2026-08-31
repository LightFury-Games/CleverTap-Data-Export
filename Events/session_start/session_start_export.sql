CREATE TABLE clevertap.session_start_events_table
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/session_start_events/'
)
AS
SELECT *
FROM clevertap.session_start_events;