CREATE TABLE clevertap.pack_open_completed_events_table
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/pack_open_completed_events/'
)
AS
SELECT *
FROM clevertap.pack_open_completed_events;