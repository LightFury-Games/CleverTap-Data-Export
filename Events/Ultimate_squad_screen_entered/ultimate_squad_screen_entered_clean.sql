CREATE OR REPLACE VIEW clevertap.ultimate_squad_screen_entered_events AS

SELECT
    -- Event
    eventName AS event_name,
    FROM_UNIXTIME(TRY_CAST(eventTime AS BIGINT)) AS event_time,
    CAST(FROM_UNIXTIME(TRY_CAST(eventTime AS BIGINT)) AS DATE) AS event_date,

    -- User and session
    NULLIF(element_at(eventProps, 'user_id').member5, '') AS user_id,
    NULLIF(element_at(eventProps, 'session_id').member5, '') AS session_id,
    TRY_CAST(
        element_at(eventProps, 'CT Session Id').member1 AS BIGINT
    ) AS ct_session_id,

    -- Squad
    TRY_CAST(
        REGEXP_REPLACE(element_at(eventProps, 'squad_ovr').member5, '_$', '')
        AS INTEGER
    ) AS squad_ovr,
    NULLIF(
        REGEXP_REPLACE(element_at(eventProps, 'squad_id').member5, '_$', ''),
        ''
    ) AS squad_id,
    NULLIF(
        REGEXP_REPLACE(element_at(eventProps, 'squad_name').member5, '_$', ''),
        ''
    ) AS squad_name,
    TRY_CAST(
        element_at(eventProps, 'selected_squad_index').member5 AS INTEGER
    ) AS selected_squad_index,

    -- App
    element_at(eventProps, 'app_version').member5 AS app_version,
    element_at(eventProps, 'CT App Version').member5 AS ct_app_version,
    element_at(eventProps, 'app_build').member5 AS app_build,
    element_at(eventProps, 'build_environment').member5 AS build_environment,
    element_at(eventProps, 'client_platform').member5 AS client_platform,
    element_at(eventProps, 'CT Source').member5 AS ct_source,

    -- Device
    element_at(eventProps, 'device_ram').member5 AS device_ram,
    element_at(deviceInfo, 'platform').member0 AS device_platform,
    element_at(deviceInfo, 'osVersion').member0 AS os_version,
    element_at(deviceInfo, 'model').member0 AS device_model,
    element_at(deviceInfo, 'make').member0 AS device_make,
    TRY_CAST(element_at(deviceInfo, 'sdkVersion').member0 AS INTEGER) AS sdk_version,

    -- Identity and profile
    element_at(identity, 'clevertapId').member0 AS clevertap_id,
    NULLIF(element_at(identity, 'identity').member0, '') AS identity,
    NULLIF(element_at(profile, 'Email').member0, '') AS email,
    NULLIF(element_at(profile, 'Full Name').member0, '') AS full_name

FROM clevertap.ultimate_squad_screen_entered
WHERE eventName = 'ultimate_squad_screen_entered';