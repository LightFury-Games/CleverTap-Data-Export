CREATE TABLE clevertap.user_profiles_clean_table
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/user_profiles_clean/'
)
AS
SELECT *
FROM clevertap.user_profiles_clean
;