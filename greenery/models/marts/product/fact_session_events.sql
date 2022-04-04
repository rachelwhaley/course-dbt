with sessions as (
    select session_id,
    user_id,
    order_id,
    min(created_at) as session_started_at,
    {{tally_column_values(ref('stg_events'),'event_type')}}
    from {{ ref('stg_events')}}
    group by 1,2,3

),

orders as (
    select order_id,
    delivered_at
    from {{ ref('stg_orders')}}
),

final as (
    select * 
    from sessions
    left join orders using (order_id)
)

select * from final
