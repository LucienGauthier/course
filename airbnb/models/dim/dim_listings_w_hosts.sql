with 

listings as (

    select *
    from {{ ref('dim_listings_cleansed') }}

),

hosts as (

    select *
    from {{ ref('dim_hosts_cleansed') }}

)

select
    l.listing_id                                as listing_id,
    l.listing_name                              as listing_name,
    l.room_type                                 as room_type,
    l.minimum_nights                            as minimum_nights,
    l.price                                     as price,
    l.host_id                                   as host_id,
    h.host_name                                 as host_name,
    h.is_superhost                              as host_is_superhost,
    l.created_at                                as created_at,
    greatest(l.updated_at, h.updated_at)        as updated_at

from
    listings                                    as l left join
    hosts                                       as h using (host_id)