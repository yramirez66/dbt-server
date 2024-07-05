{{
  config(
    materialized = "table",
    tags=["common"]
  )
}}

{{ generate_d_time('00:00:00','23:59:00') }}

SELECT
    md5 ( coalesce(CAST (time AS string)) ) AS pk_id,
    CAST(format_time("%H", time) as int) as hour,
    CAST(format_time("%M", time) as int) as minute,
    format_time("%p", time) as ampm,
    case when extract(hour from time) >= 6 and extract(hour from time) < 12 then true else false end as is_morning,
    case when extract(hour from time) >= 12 and extract(hour from time) < 18 then true else false end as is_afternoon,
    case when extract(hour from time) >= 18 and extract(hour from time) < 24 then true else false end as is_evening,
    case when extract(hour from time) <= 24 and extract(hour from time) < 6 then true else false end as is_night,
    format_time("%H%M", time) as hhmm,
    format_time("%H%M%p", time) as hhmmampm,
    CAST(format_time("%H", time) as int) as offset_hours,
    CAST(format_time("%M", time) as int) as offset_minutes
FROM
 time_range