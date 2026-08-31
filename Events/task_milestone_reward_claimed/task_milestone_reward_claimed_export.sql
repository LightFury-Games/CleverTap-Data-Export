CREATE TABLE clevertap.task_milestone_reward_claimed_events_table
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/task_milestone_reward_claimed_events/'
)
AS
SELECT *
FROM clevertap.task_milestone_reward_claimed_events;