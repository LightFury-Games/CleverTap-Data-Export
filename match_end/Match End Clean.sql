CREATE OR REPLACE VIEW clevertap.match_end_events AS

SELECT
    -- Event
    eventName AS event_name,

    -- Epoch seconds -> timestamp
    from_unixtime(CAST(eventTime AS BIGINT)) AS event_time,

    -- Event properties
    element_at(eventProps, 'match_id').member5 AS match_id,

    element_at(eventProps, 'user_id').member5 AS user_id,

    element_at(eventProps, 'session_id').member5 AS session_id,

    element_at(eventProps, 'match_end_type').member5 AS match_end_type,

    element_at(eventProps, 'opponent_type').member5 AS opponent_type,

    element_at(eventProps, 'match_result').member5 AS match_result,

    element_at(eventProps, 'game_mode').member5 AS game_mode,

    TRY_CAST(
        element_at(eventProps, 'runs_scored').member5
        AS INTEGER
    ) AS runs_scored,

    TRY_CAST(
        element_at(eventProps, 'wickets_taken').member5
        AS INTEGER
    ) AS wickets_taken,

    element_at(eventProps, 'culpritplayer_id').member5
        AS culprit_player_id,

    element_at(eventProps, 'device_ram').member5
        AS device_ram,

    element_at(eventProps, 'app_version').member5
        AS app_version,

    element_at(eventProps, 'CT App Version').member5
        AS ct_app_version,

    element_at(eventProps, 'CT Source').member5
        AS ct_source,

    element_at(eventProps, 'client_platform').member5
        AS client_platform,

    element_at(eventProps, 'app_build').member5
        AS app_build,

    element_at(eventProps, 'build_environment').member5
        AS build_environment,

    element_at(eventProps, 'match_end_error_type').member5
        AS match_end_error_type,

    -- Identity
    element_at(identity, 'identity').member0
        AS identity_email,

    -- Profile
    element_at(profile, 'Full Name').member0
        AS full_name,

    element_at(profile, 'Email').member0
        AS email,

    element_at(profile, 'Device Model').member0
        AS device_model,

    element_at(profile, 'Device Brand').member0
        AS device_brand,

    element_at(profile, 'RAM').member0
        AS profile_ram,

    -- Device
    element_at(deviceInfo, 'platform').member0
        AS platform,

    element_at(deviceInfo, 'browser').member0
        AS browser,

    TRY_CAST(
        element_at(deviceInfo, 'sdkVersion').member0
        AS INTEGER
    ) AS sdk_version,

    TRY_CAST(
        element_at(deviceInfo, 'dpi').member0
        AS INTEGER
    ) AS dpi,

    element_at(deviceInfo, 'unit').member0
        AS screen_unit,

    TRY_CAST(
        element_at(deviceInfo, 'width').member0
        AS INTEGER
    ) AS screen_width,

    TRY_CAST(
        element_at(deviceInfo, 'height').member0
        AS INTEGER
    ) AS screen_height,

    element_at(deviceInfo, 'token').member0
        AS device_token

FROM clevertap.match_end;