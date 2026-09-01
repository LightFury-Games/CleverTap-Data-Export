
select 'Discord Beta - 22nd Aug' as playtest, count(distinct clevertap_id) as app_launchers
from discord_22nd_aug_email_list a 
join app_launched_events b using(email)
where cast(event_time as date) = cast('2026-08-22' as date)
    and app_version = '9.4.0'
group by 1 
;
