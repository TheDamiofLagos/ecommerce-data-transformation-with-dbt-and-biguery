select
    u.id as customerID,
    upper(u.first_name) as first_name,
    upper(u.last_name) as last_name,
    lower(u.email) as email,
    u.age,
    ifnull(u.gender, 'N/A') gender,
    upper(u.state) as state,
    u.street_address,
    u.postal_code,
    upper(u.city) as city,
    u.country,
    u.latitude,
    u.longitude,
    u.traffic_source,
    date(u.created_at) as created_date,
    timestamp(u.created_at) as created_timestamp
from    
    {{ ref("br_users") }} u