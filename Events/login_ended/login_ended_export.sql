CREATE TABLE clevertap.login_ended_events_table
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/login_ended_events/'
)
AS
SELECT *
FROM clevertap.login_ended_events;