How are our users moving through the product funnel?
```
select * from dbt_rachelw.fact_session_events
```


Which steps in the funnel have largest drop off points?
```
with funnel_levels as (
  select
  sum(case when count_page_view then 1 else 0 end) as page_view_sessions,
  sum(case when count_add_to_cart then 1 else 0 end) as cart_sessions,
  sum(case when count_checkout then 1 else 0 end) as checkout_sessions
  from dbt_rachelw.fact_session_events
),

dropoffs as (
  select page_view_sessions - cart_sessions as cart_dropoffs,
  cart_sessions - checkout_sessions as checkout_dropoffs,
  (page_view_sessions - cart_sessions)*100.0/page_view_sessions as percent_cart_dropoffs,
  (cart_sessions - checkout_sessions)*100.0/cart_sessions as percent_checkout_dropoffs
  from funnel_levels
)

select * from dropoffs;
```

| cart_dropoffs | checkout_dropoffs | percent_cart_dropoffs | percent_checkout_dropoffs |
|---------------|-------------------|-----------------------|---------------------------|
| 111           | 106               | 19.20                 | 22.70                     |

--

Product funnel is defined with 3 levels for our dataset:

Sessions with any event of type page_view / add_to_cart / checkout

Sessions with any event of type add_to_cart / checkout

Sessions with any event of type checkout