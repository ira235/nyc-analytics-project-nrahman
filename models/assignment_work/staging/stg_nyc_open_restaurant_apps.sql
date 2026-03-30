with source as (

    select *
    from {{ source('raw', 'source_nyc_open_restaurant_apps') }}

),

staged as (

    select
        cast(objectid as int64) as object_id,
        restaurant_name,
        legal_business_name,
        doing_business_as_dba,
        borough,
        building_number,
        street,
        business_address,
        zip,
        cast(latitude as numeric) as latitude,
        cast(longitude as numeric) as longitude,
        community_board,
        council_district,
        census_tract,
        nta,
        bbl,
        bin,
        globalid,

        case
            when lower(approved_for_sidewalk_seating) = 'yes' then true
            when lower(approved_for_sidewalk_seating) = 'no' then false
            else null
        end as approved_for_sidewalk_seating,

        case
            when lower(approved_for_roadway_seating) = 'yes' then true
            when lower(approved_for_roadway_seating) = 'no' then false
            else null
        end as approved_for_roadway_seating,

        seating_interest_sidewalk,
        cast(sidewalk_dimensions_length as numeric) as sidewalk_dimensions_length,
        cast(sidewalk_dimensions_width as numeric) as sidewalk_dimensions_width,
        cast(sidewalk_dimensions_area as numeric) as sidewalk_dimensions_area,
        cast(roadway_dimensions_length as numeric) as roadway_dimensions_length,
        cast(roadway_dimensions_width as numeric) as roadway_dimensions_width,
        cast(roadway_dimensions_area as numeric) as roadway_dimensions_area,
        sla_license_type,
        sla_serial_number,

        case
            when lower(qualify_alcohol) = 'yes' then true
            when lower(qualify_alcohol) = 'no' then false
            else null
        end as qualify_alcohol,

        case
            when lower(healthcompliance_terms) = 'yes' then true
            when lower(healthcompliance_terms) = 'no' then false
            else null
        end as healthcompliance_terms,

        case
            when lower(landmark_district_or_building) = 'yes' then true
            when lower(landmark_district_or_building) = 'no' then false
            else null
        end as landmark_district_or_building,

        landmarkdistrict_terms,
        cast(time_of_submission as timestamp) as time_of_submission

    from source

)

select *
from staged