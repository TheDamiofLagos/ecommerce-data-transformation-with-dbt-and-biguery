select
    o.customerID,
    u.first_name,
    u.last_name,
    o.created_at AS transactionDate,
    ROW_NUMBER() OVER (PARTITION BY o.customerID ORDER BY o.created_at ASC) as transactionNumber,
    MIN(date(o.created_at)) OVER (PARTITION BY o.customerID) as firstTransactionDate
from    
    {{ ref("sl_orders") }} o
left join   
    {{ ref("sl_users") }} u
on  
    o.customerID = u.customerID
where
    o.status IN ('Shipped', 'Complete', 'Processing')