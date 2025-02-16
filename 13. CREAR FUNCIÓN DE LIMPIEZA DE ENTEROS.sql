create
or replace function keepcoding.clean_integer(value int64) returns int64 as (coalesce(value, -999999));

select keepcoding.clean_integer(null) as resultado;
select keepcoding.clean_integer(123) as resultado;
select keepcoding.clean_integer(-5) as resultado;
