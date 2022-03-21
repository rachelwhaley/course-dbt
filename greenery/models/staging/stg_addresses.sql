with addresses as (
    SELECT
    address_id,
    address,
    zipcode,
    state,
    country

    from {{ source('greenery', 'addresses')}}
    )
select * from addresses