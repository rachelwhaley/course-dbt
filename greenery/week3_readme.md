What is our overall conversion rate?
* Query: 
```
with session_orders as (
    select 
        session_id,
        user_id,
        order_id
    from dbt_rachelw.stg_events
    where order_id is not null 
    group by 1,2,3
),

pageviews as (
    select 
        distinct session_id
    from dbt_rachelw.stg_events
    where event_type = 'page_view'
    and product_id is not null 
),

joined as (
    select
        count(distinct session_id) as unique_sessions,
        sum(case when order_id is not null then 1 else 0 end) as num_with_purchase
    from pageviews
    left join session_orders using (session_id)
),

final as (
    select 
        unique_sessions,
        num_with_purchase,
        round(num_with_purchase*100.0/unique_sessions,2) as conversion_rate_percent
    from joined
)

select * from final
```

* Result: 62.46%

What is our conversion rate by product?

| product_name | conversion_rate_percent |
| ------------------ | ----------- |
| Bird of Paradise | 75.00 |
| Devil's Ivy | 75.56 |
| Dragon Tree | 79.03 |
| Pothos | 73.77 | 
| Philodendron | 74.19 |
| Rubber Plant | 77.78 |
| Angel Wings Begonia | 73.77 |
| Pilea Peperomioides | 74.58 |
| Majesty Palm | 82.09 |
| Aloe Vera | 66.15 |
| Spider Plant | 83.05 |
| Bamboo | 83.58 |
| Alocasia Polly | 66.67 | 
| Arrow Head | 79.37 |
| Pink Anthurium | 72.97 |
| Ficus | 72.06 |
| Jade Plant | 69.57 |
| ZZ Plant | 87.30 | 
| Calathea Makoyana | 83.02 | 
| Birds Nest Fern | 73.08 |
| Monstera | 87.76 |
| Cactus | 85.45 |
| Orchid | 73.33 |
| Money Tree | 78.57 |
| Ponytail Palm | 78.57 | 
| Boston Fern | 71.43 |
| Peace Lily | 72.73| 
| Fiddle Leaf Fig | 89.29 |
| Snake Plant| 76.71 | 
| String of pearls | 89.06 |


NOTE: conversion rate is defined as the # of unique sessions with a purchase event / total number of unique sessions. Conversion rate by product is defined as the # of unique sessions with a purchase event of that product / total number of unique sessions that viewed that product