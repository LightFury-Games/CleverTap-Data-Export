CREATE OR REPLACE VIEW clevertap.squad_edit_completed_events AS

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

    -- Squad before and after
    NULLIF(element_at(eventProps, 'squad_id_before').member5, '')
        AS squad_id_before,
    NULLIF(element_at(eventProps, 'squad_id_after').member5, '')
        AS squad_id_after,
    TRY_CAST(element_at(eventProps, 'squad_ovr_before').member5 AS INTEGER)
        AS squad_ovr_before,
    TRY_CAST(element_at(eventProps, 'squad_ovr_after').member5 AS INTEGER)
        AS squad_ovr_after,

    -- Leadership before and after; the source uses 'None' for no selection
    NULLIF(NULLIF(element_at(eventProps, 'captain_bundle_id_before').member5, ''), 'None')
        AS captain_bundle_id_before,
    NULLIF(NULLIF(element_at(eventProps, 'captain_bundle_id_after').member5, ''), 'None')
        AS captain_bundle_id_after,
    NULLIF(NULLIF(element_at(eventProps, 'vice_captain_bundle_id_before').member5, ''), 'None')
        AS vice_captain_bundle_id_before,
    NULLIF(NULLIF(element_at(eventProps, 'vice_captain_bundle_id_after').member5, ''), 'None')
        AS vice_captain_bundle_id_after,
    NULLIF(NULLIF(element_at(eventProps, 'wicket_keeper_bundle_id_before').member5, ''), 'None')
        AS wicket_keeper_bundle_id_before,
    NULLIF(NULLIF(element_at(eventProps, 'wicket_keeper_bundle_id_after').member5, ''), 'None')
        AS wicket_keeper_bundle_id_after,

    -- Card lists before
    SPLIT(
        NULLIF(REGEXP_REPLACE(element_at(eventProps, 'card_name_before').member5, '_$', ''), ''),
        '_'
    ) AS card_names_before,
    TRANSFORM(
        SPLIT(
            NULLIF(REGEXP_REPLACE(element_at(eventProps, 'card_ovr_before').member5, '_$', ''), ''),
            '_'
        ),
        x -> TRY_CAST(x AS DOUBLE)
    ) AS card_ovrs_before,
    SPLIT(
        NULLIF(REGEXP_REPLACE(element_at(eventProps, 'card_primary_role_before').member5, '_$', ''), ''),
        '_'
    ) AS card_primary_roles_before,

    -- Card lists after
    SPLIT(
        NULLIF(REGEXP_REPLACE(element_at(eventProps, 'card_name_after').member5, '_$', ''), ''),
        '_'
    ) AS card_names_after,
    TRANSFORM(
        SPLIT(
            NULLIF(REGEXP_REPLACE(element_at(eventProps, 'card_ovr_after').member5, '_$', ''), ''),
            '_'
        ),
        x -> TRY_CAST(x AS DOUBLE)
    ) AS card_ovrs_after,
    SPLIT(
        NULLIF(REGEXP_REPLACE(element_at(eventProps, 'card_primary_role_after').member5, '_$', ''), ''),
        '_'
    ) AS card_primary_roles_after,

    -- App and device
    element_at(eventProps, 'app_version').member5 AS app_version,
    element_at(eventProps, 'CT App Version').member5 AS ct_app_version,
    element_at(eventProps, 'app_build').member5 AS app_build,
    element_at(eventProps, 'build_environment').member5 AS build_environment,
    element_at(eventProps, 'client_platform').member5 AS client_platform,
    element_at(eventProps, 'CT Source').member5 AS ct_source,
    element_at(eventProps, 'device_ram').member5 AS device_ram,
    element_at(deviceInfo, 'platform').member0 AS device_platform,
    element_at(deviceInfo, 'osVersion').member0 AS os_version,
    element_at(deviceInfo, 'model').member0 AS device_model,
    element_at(deviceInfo, 'make').member0 AS device_make,

    -- Identity
    element_at(identity, 'clevertapId').member0 AS clevertap_id,
    NULLIF(element_at(identity, 'identity').member0, '') AS identity,
    NULLIF(element_at(profile, 'Email').member0, '') AS email

FROM clevertap.squad_edit_completed
WHERE eventName = 'squad_edit_completed';