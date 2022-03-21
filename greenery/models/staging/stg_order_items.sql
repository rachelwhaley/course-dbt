with items as (
    select 
    order_id,
    product_id,
    quantity

    from {{ source('greenery','order_items')}}
    )
select * from items