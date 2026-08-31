CREATE TABLE clevertap.bat_result_events_table
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/bat_result_events/'
)
AS
SELECT *
FROM clevertap.bat_result_events;