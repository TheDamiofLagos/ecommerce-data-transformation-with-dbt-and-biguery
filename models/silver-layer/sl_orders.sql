select
    o.order_id,
    o.user_id as customerID,
    o.status,
    o.gender,
    date(o.created_at) as created_at,
    date(o.returned_at) as returned_at,
    date(o.shipped_at) as shipped_at,
    date(o.delivered_at) as delivered_at,
    date_diff(date(o.shipped_at), date(o.created_at), day) as time_to_ship,
    date_diff(date(o.shipped_at), date(o.delivered_at), day) as time_to_deliver,
    SUM(p.cost) AS costPrice,
    SUM(oi.sale_price) AS totalRetailPrice,
    case
        when o.delivered_at is not null then 1
        else 0
    end as isDelivered,
    case
        when o.shipped_at is not null then 1
        else 0
    end as isShipped,
    case
        when o.returned_at is not null then 1
        else 0
    end as isReturned
from    
    {{ ref("br_orders") }} o
left join   
    {{ ref("br_order_items") }} oi
on  
    o.order_id = oi.order_id
left join   
    {{ ref("br_products") }} p
on  
    oi.product_id = p.id
group by
    all
