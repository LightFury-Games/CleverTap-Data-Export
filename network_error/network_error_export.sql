CREATE TABLE clevertap.network_error_events_table
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/network_error_events/'
)
AS
SELECT *
FROM clevertap.network_error_events;