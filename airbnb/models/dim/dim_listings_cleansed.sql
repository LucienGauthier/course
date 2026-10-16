{{ 
    config(
        materialized = 'view'
    ) 
}}

with src_listings as (

    select *
    from {{ ref('src_listings') }}

)

select
    listing_id                                  as listing_id,
    listing_name                                as listing_name,
    room_type                                   as room_type,
    case
        when minimum_nights = 0 then 1
        else minimum_nights
    end                                         as minimum_nights,
    host_id                                     as host_id,
    cast(price_str as numeric)                  as price,
    created_at                                  as created_at,
    updated_at                                  as updated_at

from
    src_listings

