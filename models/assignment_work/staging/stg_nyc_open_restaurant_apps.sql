with source as (

    select *
    from {{ source('raw', 'source_nyc_open_restaurant_apps') }}

),

staged as (

    select
        cast(objectid as int64) as object_id,
        restaurant_name,
        borough,
        zip,

        cast(latitude as numeric) as latitude,
        cast(longitude as numeric) as longitude,

        seating_interest_sidewalk,
        approved_for_sidewalk_seating,
        approved_for_roadway_seating,

        cast(sidewalk_dimensions_area as numeric) as sidewalk_area,
        cast(roadway_dimensions_area as numeric) as roadway_area,

        cast(time_of_submission as timestamp) as time_of_submission

    from source

)

select *
from staged