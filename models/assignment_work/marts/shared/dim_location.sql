-- Location dimension shared by both restaurant applications and 311 service reqs

WITH all_locations AS (

    -- Get locations from 311 requests
    SELECT distinct
        borough,
        incident_zip as zip_code
    from {{ ref('stg_nyc_311_dot') }}
    where borough is not null

    union distinct

    -- Get locations from restaurant applications
    select distinct
        borough,
        zip as zip_code
    from {{ ref('stg_nyc_open_restaurant_apps') }}
    where borough is not null
),

location_dimension as (
    select
        {{ dbt_utils.generate_surrogate_key(['borough', 'zip_code']) }} as location_key,
        borough,
        zip_code
    from all_locations
)

select *
from location_dimension