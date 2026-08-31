CREATE TABLE clevertap.tos_accepted_events_table
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/tos_accepted_events/'
)
AS
SELECT *
FROM clevertap.tos_accepted_events;