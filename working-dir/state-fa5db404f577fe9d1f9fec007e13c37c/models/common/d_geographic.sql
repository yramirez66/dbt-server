{{
  config(
    materialized = "table",
    tags=["common"]
  )
}}

{{generate_d_geographic(ref ('us_cities_geographic'))}}

SELECT
    pk_id,
    country_name,
    state_name,
    city_name,
    STRUCT(latitude_amt, 
           longitude_amt, 
           elevation_amt, 
           depth_amt) AS coordinates    
FROM
    location_details     
