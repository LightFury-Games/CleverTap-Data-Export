
WITH ranked_users AS (
    SELECT
        clevertap_id,
        identity_value,
        email,

        device_model,
        device_make,
        platform,
        ct_os_version,
        ct_app_version,
        ct_sdk_version,
        network_carrier,

        event_time,

        ROW_NUMBER() OVER (
            PARTITION BY identity_value
            ORDER BY event_time DESC
        ) AS rn

    FROM clevertap.app_launched_events

    WHERE identity_value IS NOT NULL 
        and identity_value <> ''
        -- and event_date = cast('2026-08-22' as date)
)

SELECT identity_value,

    -- Latest known user information
    MAX(
        CASE WHEN rn = 1 THEN clevertap_id END
    ) AS latest_clevertap_id,

    MAX(
        CASE WHEN rn = 1 THEN email END
    ) AS latest_email,

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
        CASE WHEN rn = 1 THEN ct_os_version END
    ) AS latest_os_version,

    MAX(
        CASE WHEN rn = 1 THEN ct_app_version END
    ) AS latest_app_version,

    MAX(
        CASE WHEN rn = 1 THEN ct_sdk_version END
    ) AS latest_sdk_version,

    MAX(
        CASE WHEN rn = 1 THEN network_carrier END
    ) AS latest_network_carrier

FROM ranked_users

GROUP BY 1

;
