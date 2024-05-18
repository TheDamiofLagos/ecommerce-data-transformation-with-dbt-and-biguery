select
    p.id,
    p.cost,
    initcap(p.category) as category,
    initcap(p.name) as name,
    initcap(p.brand) as brand,
    p.retail_price,
    initcap(p.department) as department,
    p.sku,
    dc.name as distribution_center_name,
    dc.latitude as distribution_center_latitude,
    dc.longitude as distribution_center_longitude
from 
    {{ ref("br_products") }} p
left join 
    {{ ref("br_distribution_centres") }} dc
on 
    p.distribution_center_id = dc.id