CREATE OR REPLACE VIEW clevertap.ball_result_events AS

SELECT
    -- Event
    eventName AS event_name,

    -- Unix epoch seconds -> timestamp
    from_unixtime(
        TRY_CAST(eventTime AS BIGINT)
    ) AS event_time,
    
    cast(from_unixtime(
    TRY_CAST(eventTime AS BIGINT)
    ) as date) AS event_date,

    -- Event identifiers
    element_at(eventProps, 'user_id').member5
        AS user_id,

    element_at(eventProps, 'session_id').member5
        AS session_id,

    -- Match & Game Info
    element_at(eventProps, 'match_id').member5
        AS match_id,

    element_at(eventProps, 'game_mode').member5
        AS game_mode,

    element_at(eventProps, 'ball_index_in_over').member1
        AS ball_index_in_over,

    element_at(eventProps, 'bowler').member5
        AS bowler,

    element_at(eventProps, 'striker').member5
        AS striker,

    element_at(eventProps, 'non_striker').member5
        AS non_striker,

    -- Ball Outcomes & Runs
    element_at(eventProps, 'runs_scored').member1
        AS runs_scored,

    element_at(eventProps, 'extra_runs_scored').member1
        AS extra_runs_scored,

    element_at(eventProps, 'is_four').member5
        AS is_four,

    element_at(eventProps, 'is_six').member5
        AS is_six,

    element_at(eventProps, 'is_wicket').member5
        AS is_wicket,

    element_at(eventProps, 'is_extra').member5
        AS is_extra,

    element_at(eventProps, 'is_no_ball').member5
        AS is_no_ball,

    element_at(eventProps, 'is_wide').member5
        AS is_wide,

    -- Bowling Inputs & Outputs
    element_at(eventProps, 'rawbowlinginput_pace_variation').member5
        AS rawbowlinginput_pace_variation,

    element_at(eventProps, 'rawbowlinginput_spin_variation').member5
        AS rawbowlinginput_spin_variation,

    element_at(eventProps, 'rawbowlinginput_attempted_speed').member4
        AS rawbowlinginput_attempted_speed,

    COALESCE(
        TRY_CAST(element_at(eventProps, 'rawbowlinginput_attempted_deviation').member4 AS DOUBLE),
        TRY_CAST(element_at(eventProps, 'rawbowlinginput_attempted_deviation').member1 AS DOUBLE)
    ) AS rawbowlinginput_attempted_deviation,

    element_at(eventProps, 'computedbowlinginput_line_name').member5
        AS computedbowlinginput_line_name,

    element_at(eventProps, 'computedbowlinginput_line_index').member5
        AS computedbowlinginput_line_index,

    element_at(eventProps, 'computedbowlinginput_length_name').member5
        AS computedbowlinginput_length_name,

    element_at(eventProps, 'computedbowlinginput_length_index').member5
        AS computedbowlinginput_length_index,

    element_at(eventProps, 'computedbowlinginput_computed_speed').member5
        AS computedbowlinginput_computed_speed,

    element_at(eventProps, 'computedbowlinginput_computed_deviation').member5
        AS computedbowlinginput_computed_deviation,

    element_at(eventProps, 'computedbowlinginput_timing').member5
        AS computedbowlinginput_timing,

    element_at(eventProps, 'computedbowlinginput_pitching_point').member5
        AS computedbowlinginput_pitching_point,

    element_at(eventProps, 'currentbowlingoutput_releasetiming').member5
        AS currentbowlingoutput_releasetiming,

    -- Batting Inputs & Shot Outcomes
    element_at(eventProps, 'battinginput_footwork').member5
        AS battinginput_footwork,

    element_at(eventProps, 'battinginput_shot_style').member5
        AS battinginput_shot_style,

    element_at(eventProps, 'battinginput_batsman_location').member5
        AS battinginput_batsman_location,

    element_at(eventProps, 'battinginput_timing').member4
        AS battinginput_timing,

    element_at(eventProps, 'battinginput_direction').member4
        AS battinginput_direction,

    element_at(eventProps, 'shotoutcome_selected_shot').member5
        AS shotoutcome_selected_shot,

    element_at(eventProps, 'shotoutcome_timing_tag').member5
        AS shotoutcome_timing_tag,

    element_at(eventProps, 'shotoutcome_contact_zone').member5
        AS shotoutcome_contact_zone,

    element_at(eventProps, 'shotoutcome_movement_assist_tag').member5
        AS shotoutcome_movement_assist_tag,

    -- Bowler Attributes
    element_at(eventProps, 'bowler_overall_rating').member1
        AS bowler_overall_rating,

    element_at(eventProps, 'bowler_confidence').member1
        AS bowler_confidence,

    element_at(eventProps, 'bowler_batting_accuracy').member1
        AS bowler_batting_accuracy,

    element_at(eventProps, 'bowler_batting_power').member1
        AS bowler_batting_power,

    element_at(eventProps, 'bowler_batting_timing').member1
        AS bowler_batting_timing,

    element_at(eventProps, 'bowler_batting_movement_assist').member1
        AS bowler_batting_movement_assist,

    element_at(eventProps, 'bowler_batting_perception').member1
        AS bowler_batting_perception,

    element_at(eventProps, 'bowler_bowling_precision').member1
        AS bowler_bowling_precision,

    element_at(eventProps, 'bowler_bowling_swing_control').member1
        AS bowler_bowling_swing_control,

    element_at(eventProps, 'bowler_bowling_spin_control').member1
        AS bowler_bowling_spin_control,

    element_at(eventProps, 'bowler_bowling_speed_control').member1
        AS bowler_bowling_speed_control,

    element_at(eventProps, 'bowler_bowling_deception').member1
        AS bowler_bowling_deception,

    element_at(eventProps, 'bowler_bowling_concentration').member1
        AS bowler_bowling_concentration,

    element_at(eventProps, 'bowler_bowling_release_timer').member1
        AS bowler_bowling_release_timer,

    -- Striker Attributes
    element_at(eventProps, 'striker_overall_rating').member1
        AS striker_overall_rating,

    element_at(eventProps, 'striker_confidence').member1
        AS striker_confidence,

    element_at(eventProps, 'striker_batting_accuracy').member1
        AS striker_batting_accuracy,

    element_at(eventProps, 'striker_batting_power').member1
        AS striker_batting_power,

    element_at(eventProps, 'striker_batting_timing').member1
        AS striker_batting_timing,

    element_at(eventProps, 'striker_batting_movement_assist').member1
        AS striker_batting_movement_assist,

    element_at(eventProps, 'striker_batting_perception').member1
        AS striker_batting_perception,

    element_at(eventProps, 'striker_bowling_precision').member1
        AS striker_bowling_precision,

    element_at(eventProps, 'striker_bowling_swing_control').member1
        AS striker_bowling_swing_control,

    element_at(eventProps, 'striker_bowling_spin_control').member1
        AS striker_bowling_spin_control,

    element_at(eventProps, 'striker_bowling_speed_control').member1
        AS striker_bowling_speed_control,

    element_at(eventProps, 'striker_bowling_deception').member1
        AS striker_bowling_deception,

    element_at(eventProps, 'striker_bowling_concentration').member1
        AS striker_bowling_concentration,

    element_at(eventProps, 'striker_bowling_release_timer').member1
        AS striker_bowling_release_timer,

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
