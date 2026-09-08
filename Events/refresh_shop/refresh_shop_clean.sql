CREATE OR REPLACE VIEW clevertap.refresh_shop_events AS

SELECT

    -- =========================================================
    -- EVENT
    -- =========================================================

    eventName AS event_name,

    -- Unix epoch seconds -> timestamp
    from_unixtime(
        TRY_CAST(eventTime AS BIGINT)
    ) AS event_time,

    -- Derived from event_time
    CAST(
        from_unixtime(
            TRY_CAST(eventTime AS BIGINT)
        ) AS DATE
    ) AS event_date,


    -- =========================================================
    -- SHOP REFRESH
    -- =========================================================

    element_at(
        eventProps,
        'refresh_type'
    ).member5 AS refresh_type,

    TRY_CAST(
        element_at(
            eventProps,
            'item_price'
        ).member5
        AS DOUBLE
    ) AS item_price,

    element_at(
        eventProps,
        'purchase_end_type'
    ).member5 AS purchase_end_type,

    element_at(
        eventProps,
        'shop_id'
    ).member5 AS shop_id,

    element_at(
        eventProps,
        'currency_id'
    ).member5 AS currency_id,


    -- =========================================================
    -- USER / SESSION
    -- =========================================================

    element_at(
        eventProps,
        'user_id'
    ).member5 AS user_id,

    element_at(
        eventProps,
        'session_id'
    ).member5 AS session_id,


    -- =========================================================
    -- APPLICATION
    -- =========================================================

    element_at(
        eventProps,
        'app_version'
    ).member5 AS app_version,

    element_at(
        eventProps,
        'CT App Version'
    ).member5 AS ct_app_version,

    element_at(
        eventProps,
        'app_build'
    ).member5 AS app_build,

    element_at(
        eventProps,
        'build_environment'
    ).member5 AS build_environment,

    element_at(
        eventProps,
        'CT Source'
    ).member5 AS ct_source,

    element_at(
        eventProps,
        'client_platform'
    ).member5 AS client_platform,

    element_at(
        eventProps,
        'device_ram'
    ).member5 AS device_ram,


    -- =========================================================
    -- CLEVERTAP IDENTITY
    -- =========================================================

    element_at(
        identity,
        'clevertapId'
    ).member0 AS clevertap_id,

    element_at(
        identity,
        'identity'
    ).member0 AS identity_value,


    -- =========================================================
    -- PROFILE
    -- =========================================================

    NULLIF(
        element_at(
            profile,
            'Full Name'
        ).member0,
        ''
    ) AS full_name,

    NULLIF(
        element_at(
            profile,
            'Email'
        ).member0,
        ''
    ) AS email,

    NULLIF(
        element_at(
            profile,
            'Device Model'
        ).member0,
        ''
    ) AS profile_device_model,

    NULLIF(
        element_at(
            profile,
            'Device Brand'
        ).member0,
        ''
    ) AS profile_device_brand,

    NULLIF(
        element_at(
            profile,
            'RAM'
        ).member0,
        ''
    ) AS profile_ram,


    -- =========================================================
    -- DEVICE
    -- =========================================================

    element_at(
        deviceInfo,
        'platform'
    ).member0 AS device_platform,

    element_at(
        deviceInfo,
        'browser'
    ).member0 AS browser,

    element_at(
        deviceInfo,
        'appVersion'
    ).member0 AS device_app_version,

    element_at(
        deviceInfo,
        'osVersion'
    ).member0 AS os_version,

    element_at(
        deviceInfo,
        'model'
    ).member0 AS device_model,

    element_at(
        deviceInfo,
        'make'
    ).member0 AS device_make,

    element_at(
        deviceInfo,
        'unit'
    ).member0 AS screen_unit,

    element_at(
        deviceInfo,
        'token'
    ).member0 AS device_token,

    TRY_CAST(
        element_at(
            deviceInfo,
            'sdkVersion'
        ).member0
        AS INTEGER
    ) AS sdk_version,

    TRY_CAST(
        element_at(
            deviceInfo,
            'dpi'
        ).member0
        AS INTEGER
    ) AS dpi,

    TRY_CAST(
        element_at(
            deviceInfo,
            'width'
        ).member0
        AS INTEGER
    ) AS screen_width,

    TRY_CAST(
        element_at(
            deviceInfo,
            'height'
        ).member0
        AS INTEGER
    ) AS screen_height


FROM clevertap.refresh_shop

WHERE eventName = 'refresh_shop';