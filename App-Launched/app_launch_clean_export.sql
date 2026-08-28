CREATE TABLE clevertap.app_launched_events_table
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/app_launched_events/'
)
AS
SELECT *
FROM clevertap.app_launched_events;