CREATE TABLE clevertap.dim_users
WITH (
    format = 'PARQUET',
    external_location = 's3://clevertap-prod-export/athena/dim_users/'
)
AS

WITH ranked_users AS (
    SELECT
        clevertap_id,
        identity_value,
        email,
        full_name,

        device_model,
        device_make,
        platform,
        os_version,
        app_version,
        sdk_version,
        network_carrier,

        event_time,

        ROW_NUMBER() OVER (
            PARTITION BY clevertap_id
            ORDER BY event_time DESC
        ) AS rn

    FROM clevertap.app_launched_events_table

    WHERE clevertap_id IS NOT NULL
)

SELECT
    clevertap_id,

    -- Latest known user information
    MAX(
        CASE WHEN rn = 1 THEN identity_value END
    ) AS current_identity,

    MAX(
        CASE WHEN rn = 1 THEN email END
    ) AS current_email,

    MAX(
        CASE WHEN rn = 1 THEN full_name END
    ) AS full_name,

    -- Latest device used
    MAX(
        CASE WHEN rn = 1 THEN device_model END
    ) AS latest_device_model,

    MAX(
        CASE WHEN rn = 1 THEN device_make END
    ) AS latest_device_make,

    MAX(
        CASE WHEN rn = 1 THEN platform END
    ) AS latest_platform,

    MAX(
        CASE WHEN rn = 1 THEN os_version END
    ) AS latest_os_version,

    MAX(
        CASE WHEN rn = 1 THEN app_version END
    ) AS latest_app_version,

    MAX(
        CASE WHEN rn = 1 THEN sdk_version END
    ) AS latest_sdk_version,

    MAX(
        CASE WHEN rn = 1 THEN network_carrier END
    ) AS latest_network_carrier

FROM ranked_users

GROUP BY clevertap_id;