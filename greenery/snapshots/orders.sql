{% snapshot orders_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='order_id',

      strategy='timestamp',
      updated_at='status',
    )
}}

select * from {{ source('greenery', 'orders') }}

{% endsnapshot %}