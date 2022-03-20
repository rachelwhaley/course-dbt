with products as (
    select *
    from {{ ref('stg_products') }}
),

items as (
    select product_id,
    count(order_id) as num_ordered
    from {{ ref('stg_order_items') }}
    group by 1
),

final as (
    select *
    from products
    left join items using (product_id)
)

select * from final