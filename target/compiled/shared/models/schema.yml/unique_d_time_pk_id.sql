
    
    

with dbt_test__target as (

  select pk_id as unique_field
  from `dwt-ingestion-poc-20230921`.`test_dbt`.`d_time`
  where pk_id is not null

)

select
    unique_field,
    count(*) as n_records

from dbt_test__target
group by unique_field
having count(*) > 1


