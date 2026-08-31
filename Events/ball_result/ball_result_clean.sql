CREATE OR REPLACE VIEW clevertap.ball_result_events AS

SELECT
    -- Event
    eventName AS event_name,

    -- Unix epoch seconds -> timestamp
    from_unixtime(
        TRY_CAST(eventTime AS BIGINT)
    ) AS event_time,

    -- Event identifiers
    element_at(eventProps, 'user_id').member5
        AS user_id,

    element_at(eventProps, 'session_id').member5
        AS session_id,

    element_at(eventProps, 'match_id').member5
        AS match_id,

    -- Ball result
    element_at(eventProps, 'striker').member5
        AS striker,

    element_at(eventProps, 'non_striker').member5
        AS non_striker,

    element_at(eventProps, 'bowler').member5
        AS bowler,

    TRY_CAST(
        element_at(eventProps, 'runs_scored').member1
        AS INTEGER
    ) AS runs_scored,

    TRY_CAST(
        element_at(eventProps, 'extra_runs_scored').member1
        AS INTEGER
    ) AS extra_runs_scored,

    TRY_CAST(
        element_at(eventProps, 'ball_index_in_over').member1
        AS INTEGER
    ) AS ball_index_in_over,

    element_at(eventProps, 'is_four').member5
        AS is_four,

    element_at(eventProps, 'is_six').member5
        AS is_six,

    element_at(eventProps, 'is_wicket').member5
        AS is_wicket,

    element_at(eventProps, 'is_no_ball').member5
        AS is_no_ball,

    element_at(eventProps, 'is_wide').member5
        AS is_wide,

    element_at(eventProps, 'is_extra').member5
        AS is_extra,

    -- Match
    element_at(eventProps, 'game_mode').member5
        AS game_mode,

    -- Application
    element_at(eventProps, 'app_version').member5
        AS app_version,

    element_at(eventProps, 'CT App Version').member5
        AS ct_app_version,

    element_at(eventProps, 'app_build').member5
        AS app_build,

    element_at(eventProps, 'build_environment').member5
        AS build_environment,

    element_at(eventProps, 'CT Source').member5
        AS ct_source,

    element_at(eventProps, 'client_platform').member5
        AS client_platform,

    element_at(eventProps, 'device_ram').member5
        AS device_ram,

    -- CleverTap
    element_at(identity, 'clevertapId').member0
        AS clevertap_id,

    element_at(identity, 'identity').member0
        AS identity_value,

    -- Profile
    NULLIF(element_at(profile, 'Full Name').member0, '')
        AS full_name,

    NULLIF(element_at(profile, 'Email').member0, '')
        AS email,

    NULLIF(element_at(profile, 'Device Model').member0, '')
        AS profile_device_model,

    NULLIF(element_at(profile, 'Device Brand').member0, '')
        AS profile_device_brand,

    NULLIF(element_at(profile, 'RAM').member0, '')
        AS profile_ram,

    -- Device
    element_at(deviceInfo, 'platform').member0
        AS device_platform,

    element_at(deviceInfo, 'browser').member0
        AS browser,

    element_at(deviceInfo, 'appVersion').member0
        AS device_app_version,

    element_at(deviceInfo, 'osVersion').member0
        AS os_version,

    element_at(deviceInfo, 'model').member0
        AS device_model,

    element_at(deviceInfo, 'make').member0
        AS device_make,

    element_at(deviceInfo, 'unit').member0
        AS screen_unit,

    element_at(deviceInfo, 'token').member0
        AS device_token,

    TRY_CAST(
        element_at(deviceInfo, 'sdkVersion').member0
        AS INTEGER
    ) AS sdk_version,

    TRY_CAST(
        element_at(deviceInfo, 'dpi').member0
        AS INTEGER
    ) AS dpi,

    TRY_CAST(
        element_at(deviceInfo, 'width').member0
        AS INTEGER
    ) AS screen_width,

    TRY_CAST(
        element_at(deviceInfo, 'height').member0
        AS INTEGER
    ) AS screen_height

FROM clevertap.ball_result;