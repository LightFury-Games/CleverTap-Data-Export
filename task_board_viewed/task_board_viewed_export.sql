CREATE TABLE clevertap.task_board_viewed_events_table
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/task_board_viewed_events/'
)
AS
SELECT *
FROM clevertap.task_board_viewed_events;