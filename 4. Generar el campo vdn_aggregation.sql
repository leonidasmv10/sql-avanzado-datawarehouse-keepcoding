alter table
    keepcoding.ivr_detail
add
    column vdn_aggregation string;

update
    keepcoding.ivr_detail
set
    vdn_aggregation = case
        when calls_vdn_label like 'ATC%' then 'FRONT'
        when calls_vdn_label like 'TECH%' then 'TECH'
        when calls_vdn_label = 'ABSORPTION' then 'ABSORPTION'
        else 'resto'
    end
where
    calls_vdn_label is not null;