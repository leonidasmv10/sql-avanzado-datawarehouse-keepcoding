create
or replace table keepcoding.ivr_summary as
select
    calls_ivr_id as ivr_id,
    calls_phone_number as phone_number,
    calls_ivr_result as ivr_result,
    vdn_aggregation,
    calls_start_date as start_date,
    calls_end_date as end_date,
    calls_total_duration as total_duration,
    calls_customer_segment as customer_segment,
    calls_ivr_language as ivr_language,
    count(distinct module_sequece) as steps_module,
    string_agg(distinct module_name, ', ') as module_aggregation,
    max(document_type) as document_type,
    max(document_identification) as document_identification,
    max(customer_phone) as customer_phone,
    max(billing_account_id) as billing_account_id,
    max(masiva_lg) as masiva_lg,
    max(info_by_phone_lg) as info_by_phone_lg,
    max(info_by_dni_lg) as info_by_dni_lg,
    max(repeated_phone_24h) as repeated_phone_24h,
    max(cause_recall_phone_24h) as cause_recall_phone_24h
from
    keepcoding.ivr_detail
group by
    calls_ivr_id,
    calls_phone_number,
    calls_ivr_result,
    vdn_aggregation,
    calls_start_date,
    calls_end_date,
    calls_total_duration,
    calls_customer_segment,
    calls_ivr_language;