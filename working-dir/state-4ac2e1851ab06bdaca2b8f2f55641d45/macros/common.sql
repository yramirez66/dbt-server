{% macro generate_d_date(start_date, end_date) %}
    WITH date_range AS (
            SELECT date_add('{{ start_date }}', interval n day) AS date
            FROM
                unnest(
                    generate_array(0, date_diff('{{ end_date }}', '{{ start_date }}', day))
                ) AS n
        )

{% endmacro %}

{% macro generate_d_time(start_time, end_time) %}

    WITH time_range AS (
            SELECT time_add(time '{{start_time}}', interval n minute) AS time
            FROM
                unnest(
                    generate_array(
                        0, time_diff(time '{{end_time}}', time '{{start_time}}', minute)
                    )
                ) AS n
        )

{% endmacro %}

{% macro generate_d_geographic(geo_table) %}

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
            {{geo_table}}           
    )

{% endmacro %}
