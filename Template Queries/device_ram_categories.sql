
select case 
            when device_ram is null then 'Not available'
            when cast(replace(device_ram, 'GB', '') as integer) < 8 then 'Less than 8 GB'
            when cast(replace(device_ram, 'GB', '') as integer) >= 8 then '8 GB or more'
            else 'Not available'
        end as ram_data
        , cast(event_time as date) as event_date 
        , count(distinct email) as num_users
FROM clevertap.tos_viewed_events
where cast(event_time as date) >= cast('2026-08-10' as date)
    and ct_app_version = '9.4.0'
group by 1,2 
order by 1,2
;

