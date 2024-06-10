

  SELECT
      md5 ( coalesce( CAST(Id AS string) ) ) as pk_id,
      Enumerator AS enumerator_name, 
      ARRAY_AGG(DISTINCT definitions) AS enum_definitions,
      Offset AS offset, 
      Ordinal AS ordinal
  FROM
      `dwt-ingestion-poc-20230921`.`test_dbt`.`us_utility`        
  GROUP BY
    id, enumerator_name, offset, ordinal