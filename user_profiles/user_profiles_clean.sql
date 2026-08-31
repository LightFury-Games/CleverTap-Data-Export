CREATE OR REPLACE VIEW clevertap.user_profiles_clean AS

SELECT
    -- Base & CleverTap Identifiers
    identity AS primary_identity,

    element_at(profileIdentities, 'clevertapId').member0
        AS clevertap_id,

    element_at(profileIdentities, 'all_identities').member0
        AS all_identities,

    -- User Identity & Demographics
    COALESCE(
        NULLIF(element_at(profileProps, 'Full Name').member5, ''),
        NULLIF(element_at(profileProps, 'Name').member5, '')
    ) AS full_name,

    COALESCE(
        NULLIF(element_at(profileProps, 'First Name').member5, ''),
        NULLIF(element_at(profileProps, 'FNAME').member5, '')
    ) AS first_name,

    COALESCE(
        NULLIF(element_at(profileProps, 'Last Name').member5, ''),
        NULLIF(element_at(profileProps, 'LNAME').member5, '')
    ) AS last_name,

    COALESCE(
        NULLIF(element_at(profileProps, 'Email').member5, ''),
        NULLIF(element_at(profileProps, 'Email Address').member5, '')
    ) AS email,

    COALESCE(
        NULLIF(element_at(profileProps, 'Google Play Gmail ID').member5, ''),
        NULLIF(element_at(profileProps, 'Google Play Email').member5, ''),
        NULLIF(element_at(profileProps, 'PLAYGMAIL').member5, '')
    ) AS google_play_email,

    COALESCE(
        NULLIF(element_at(profileProps, 'Phone').member5, ''),
        NULLIF(element_at(profileProps, 'Whatsapp Phone Number').member5, '')
    ) AS phone_number,

    NULLIF(element_at(profileProps, 'Gender').member5, '')
        AS gender,

    COALESCE(
        NULLIF(element_at(profileProps, 'Age Group').member5, ''),
        NULLIF(element_at(profileProps, 'AGEGRP').member5, '')
    ) AS age_group,

    NULLIF(element_at(profileProps, 'DOB').member5, '')
        AS dob,

    -- Location & Localization
    COALESCE(
        NULLIF(element_at(profileProps, 'Country').member5, ''),
        NULLIF(element_at(profileProps, 'Country Of Residence').member5, '')
    ) AS country,

    NULLIF(element_at(profileProps, 'CC').member5, '')
        AS country_code,

    NULLIF(element_at(profileProps, 'REGION').member5, '')
        AS region,

    NULLIF(element_at(profileProps, 'TIMEZONE').member5, '')
        AS timezone,

    -- Hardware & Device Specifications
    NULLIF(element_at(profileProps, 'Device Brand').member5, '')
        AS profile_device_brand,

    NULLIF(element_at(profileProps, 'Device Model').member5, '')
        AS profile_device_model,

    COALESCE(
        NULLIF(element_at(profileProps, 'RAM').member5, ''),
        NULLIF(element_at(profileProps, 'RAM Data').member5, '')
    ) AS profile_ram,

    -- Social & Community
    COALESCE(
        NULLIF(element_at(profileProps, 'Discord ID').member5, ''),
        NULLIF(element_at(profileProps, 'Discord User ID').member5, '')
    ) AS discord_id,

    NULLIF(element_at(profileProps, 'Discord Joined').member5, '')
        AS discord_joined,

    -- Marketing, Campaign & Engagement Attributes
    NULLIF(element_at(profileProps, 'MEMBER_RATING').member5, '')
        AS member_rating,

    NULLIF(element_at(profileProps, 'TAGS').member5, '')
        AS tags,

    NULLIF(element_at(profileProps, 'mailchimp_email_status').member5, '')
        AS mailchimp_email_status,

    TRY_CAST(NULLIF(element_at(profileProps, 'OPTIN_TIME').member5, '') AS TIMESTAMP) AS optin_time,
    
    TRY_CAST(NULLIF(element_at(profileProps, 'CONFIRM_TIME').member5, '') AS TIMESTAMP) AS confirm_time,

    NULLIF(element_at(profileProps, 'LAST_CHANGED').member5, '')
        AS last_changed,

    NULLIF(element_at(profileProps, 'OPTIN_IP').member5, '')
        AS optin_ip,

    NULLIF(element_at(profileProps, 'EUID').member5, '')
        AS euid,

    NULLIF(element_at(profileProps, 'LEID').member5, '')
        AS leid,

    NULLIF(element_at(profileProps, 'Referring Employee ID').member5, '')
        AS referring_employee_id,

    NULLIF(element_at(profileProps, 'Referring Employee Name').member5, '')
        AS referring_employee_name

FROM clevertap.user_profiles;