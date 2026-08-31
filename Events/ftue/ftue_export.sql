CREATE TABLE clevertap.ftue_events_table
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/ftue_events/'
)
AS
SELECT *
FROM clevertap.ftue_events;