



    WITH location_details AS (
        SELECT
            md5 ( coalesce(City) ) AS pk_id,
            Country AS country_name,
            State AS state_name,
            City AS city_name,
            Latitude AS latitude_amt, 
            Longitude AS longitude_amt, 
            Elevation AS elevation_amt, 
            Depth AS depth_amt
        FROM
            `dwt-ingestion-poc-20230921`.`test_dbt`.`us_cities_geographic`           
    )



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