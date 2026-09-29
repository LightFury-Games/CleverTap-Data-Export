CREATE OR REPLACE VIEW clevertap.squad_change_completed_events AS

SELECT
    -- Event
    eventName AS event_name,
    FROM_UNIXTIME(TRY_CAST(eventTime AS BIGINT)) AS event_time,
    CAST(FROM_UNIXTIME(TRY_CAST(eventTime AS BIGINT)) AS DATE) AS event_date,

    -- User and session
    NULLIF(element_at(eventProps, 'user_id').member5, '') AS user_id,
    NULLIF(element_at(eventProps, 'session_id').member5, '') AS session_id,
    TRY_CAST(element_at(eventProps, 'CT Session Id').member1 AS BIGINT)
        AS ct_session_id,

    -- Squad change
    NULLIF(element_at(eventProps, 'squad_id_previous').member5, '')
        AS squad_id_previous,
    NULLIF(element_at(eventProps, 'squad_id').member5, '')
        AS squad_id,
    NULLIF(element_at(eventProps, 'squad_type').member5, '')
        AS squad_type,

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

    -- Identity and profile
    element_at(identity, 'clevertapId').member0 AS clevertap_id,
    NULLIF(element_at(identity, 'identity').member0, '') AS identity,
    NULLIF(element_at(profile, 'Email').member0, '') AS email

FROM clevertap.squad_change_completed
WHERE eventName = 'squad_change_completed';