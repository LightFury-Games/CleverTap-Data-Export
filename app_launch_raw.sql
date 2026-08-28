CREATE OR REPLACE VIEW clevertap.app_launched_events AS

SELECT
    -- Event
    eventName AS event_name,

    from_unixtime(
        TRY_CAST(eventTime AS BIGINT)
    ) AS event_time,

    -- CleverTap / player identifiers
    element_at(identity, 'clevertapId').member0
        AS clevertap_id,

    element_at(identity, 'identity').member0
        AS identity_value,

    -- All identities associated with this CleverTap profile
    element_at(identity, 'all_identities').member1
        AS all_identities,

    -- Event properties
    element_at(eventProps, 'CT Source').member5
        AS ct_source,

    element_at(eventProps, 'CT Network Carrier').member5
        AS network_carrier,

    element_at(eventProps, 'CT OS Version').member5
        AS ct_os_version,

    TRY_CAST(
        element_at(eventProps, 'CT SDK Version').member1
        AS INTEGER
    ) AS ct_sdk_version,

    element_at(eventProps, 'CT App Version').member5
        AS ct_app_version,

    -- Device
    element_at(deviceInfo, 'platform').member0
        AS platform,

    element_at(deviceInfo, 'browser').member0
        AS browser,

    element_at(deviceInfo, 'model').member0
        AS device_model,

    element_at(deviceInfo, 'make').member0
        AS device_make,

    element_at(deviceInfo, 'osVersion').member0
        AS os_version,

    element_at(deviceInfo, 'appVersion').member0
        AS app_version,

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
    ) AS screen_height,

    element_at(deviceInfo, 'unit').member0
        AS screen_unit,

    -- Profile
    NULLIF(
        element_at(profile, 'Full Name').member0,
        ''
    ) AS full_name,

    NULLIF(
        element_at(profile, 'Email').member0,
        ''
    ) AS email,

    NULLIF(
        element_at(profile, 'Device Model').member0,
        ''
    ) AS profile_device_model,

    NULLIF(
        element_at(profile, 'Device Brand').member0,
        ''
    ) AS profile_device_brand,

    NULLIF(
        element_at(profile, 'RAM').member0,
        ''
    ) AS profile_ram

FROM clevertap.app_launched;