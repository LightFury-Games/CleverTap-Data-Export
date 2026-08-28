CREATE TABLE clevertap.ball_result_events_table
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/ball_result_events/'
)
AS
SELECT *
FROM clevertap.ball_result_events;