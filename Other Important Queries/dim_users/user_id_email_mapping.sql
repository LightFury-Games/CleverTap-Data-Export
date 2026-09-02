
CREATE OR REPLACE VIEW clevertap.user_id_email_mapping AS

select distinct event_date, user_id, email
from user_activity 
where 1=1 
    and user_id is not null and user_id <> '' 
    and email is not null and email <> ''
