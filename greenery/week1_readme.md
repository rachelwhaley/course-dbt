How many users do we have?
`select count(user_id) from dbt_rachelw.stg_users;`
* Result: 130

On average, how many orders do we receive per hour?
```select avg(sub.hourly_order_count) from 
(select extract(hour from created_at) as hour, count(order_id) as hourly_order_count
from dbt_rachelw.stg_orders
group by 1) sub```
* Result: 15

On average, how long does an order take from being placed to being delivered?
```select avg(sub.total_time) from 
(select delivered_at-created_at as total_time
from dbt_rachelw.stg_orders) sub```
* Result: 3 days 21 hours 24 minutes

How many users have only made one purchase? Two purchases? Three+ purchases?
```select sub.order_count, count(sub.user_id) as count_users from 
(select user_id, count(order_id) as order_count
from dbt_rachelw.stg_orders
group by 1) sub
group by 1 order by 1```

* Result: 

| order_count | count_users |
| --- | ----------- |
| 1 | 25 |
| 2 | 28 |
| 3+ | 71 |

On average, how many unique sessions do we have per hour?
```select avg(sub.hourly_session_count) from 
(select extract(hour from created_at) as hour, count(distinct session_id) as hourly_session_count
from dbt_rachelw.stg_events
group by 1) sub```
* Result: 39