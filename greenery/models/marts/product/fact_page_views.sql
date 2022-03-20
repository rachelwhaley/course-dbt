with pageviews as (
    select page_url,
    count(event_id) as num_events,
    count(distinct session_id) as num_sessions,
    min(created_at) as first_viewed_at,
    max(created_at) as last_viewed_at
    from {{ ref('stg_events') }}
    group by 1
),

final as (
    select page_url, num_events, num_sessions,
    num_events*1.0/num_sessions as avg_views_per_session,
    first_viewed_at, last_viewed_at
    from pageviews
    order by num_events desc
)

select * from final