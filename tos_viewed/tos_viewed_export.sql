CREATE TABLE clevertap.tos_viewed_events_table
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/tos_viewed_events/'
)
AS
SELECT *
FROM clevertap.tos_viewed_events;