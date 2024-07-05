{{
  config(
    materialized = "table",
    tags=["common"]
  )
}}

  SELECT
      md5 ( coalesce( CAST(Id AS string) ) ) as pk_id,
      STRUCT(Date as date, 
            Type as type, 
            Description as domain_desc, 
            EntityId as entity_id, 
            Value as value, 
            Context as context, 
            Domain as domain,
            Origin as origin) AS event    
  FROM
      {{ref ('us_domain')}}       