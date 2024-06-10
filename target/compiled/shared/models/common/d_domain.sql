

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
      `dwt-ingestion-poc-20230921`.`test_dbt`.`us_domain`