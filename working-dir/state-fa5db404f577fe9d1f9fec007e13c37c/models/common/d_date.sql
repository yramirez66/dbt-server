{{
  config(
    materialized = "table",
    tags=["common"]
  )
}}

{{generate_d_date('2023-10-08','2023-11-08')}}
  
    SELECT
        md5 ( coalesce(CAST (date AS string)) ) AS pk_id,
        date AS full_date,
        extract(dayofweek from date) AS num_day_of_week,
        extract(day from date) AS day,
        format_date('%A', date) AS day_of_week_name,
        format_date('%a', date) AS day_of_week_short,
        extract(dayofyear from date) AS num_day_of_year,
        (DIV(EXTRACT(DAY FROM date), 7) + 1)  AS week_of_month,
        extract(week from date) AS week_of_year,
        extract(month from date) AS numeric_month,
        format_date('%B', date) AS month_name,
        format_date('%b', date) AS month_name_short,
        CAST(format_date('%Y', date) as int) AS year,
        CAST(format_date('%Q', date) as int) AS quarter,
        cast(format_date('%Y-%m', date) AS string) AS year_month,
        CASE
            WHEN extract(dayofweek from date) = 1 or extract(dayofweek from date) = 7
            THEN true
            ELSE false
        end AS is_weekend,
        date_sub(date, interval 1 year) AS same_date_last_year,
        date_sub(date, interval 1 week) AS same_date_last_week,
        false AS isdst,
        CASE
            WHEN extract(day from date) = 1
            THEN "st"
            WHEN extract(day from date) = 2
            THEN "nd"
            WHEN extract(day from date) = 3
            THEN "rd"
            ELSE "th"
        end AS suffix,
        substr(format_date('%a', date), 0, 1) AS weekday_firstletter,
        substr(format_date('%b', date), 0, 1) AS month_firstletter,
        CASE
            WHEN
                mod(extract(year from date), 4) = 0
                and mod(extract(year from date), 100) <> 0
            THEN true
            ELSE false
        end AS is_leap_year
    from date_range