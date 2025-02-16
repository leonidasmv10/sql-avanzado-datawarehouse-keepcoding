CREATE
OR REPLACE TABLE keepcoding.ivr_detail AS WITH base AS (
  SELECT
    -- Datos de ivr_calls
    c.ivr_id AS calls_ivr_id,
    c.phone_number AS calls_phone_number,
    c.ivr_result AS calls_ivr_result,
    c.vdn_label AS calls_vdn_label,
    c.start_date AS calls_start_date,
    FORMAT_DATE('%Y%m%d', DATE(c.start_date)) AS calls_start_date_id,
    c.end_date AS calls_end_date,
    FORMAT_DATE('%Y%m%d', DATE(c.end_date)) AS calls_end_date_id,
    c.total_duration AS calls_total_duration,
    c.customer_segment AS calls_customer_segment,
    c.ivr_language AS calls_ivr_language,
    c.steps_module AS calls_steps_module,
    c.module_aggregation AS calls_module_aggregation,
    -- Datos de ivr_modules (nos quedamos con el último módulo por llamada)
    m.module_sequece,
    m.module_name,
    m.module_duration,
    m.module_result,
    -- Datos de ivr_steps (nos quedamos con el último paso dentro del módulo seleccionado)
    s.step_sequence,
    s.step_name,
    s.step_result,
    s.step_description_error,
    s.document_type,
    s.document_identification,
    s.customer_phone,
    s.billing_account_id,
    ROW_NUMBER() OVER (
      PARTITION BY CAST(c.ivr_id AS STRING)
      ORDER BY
        m.module_sequece DESC,
        s.step_sequence DESC
    ) AS rn
  FROM
    keepcoding.ivr_calls c
    LEFT JOIN keepcoding.ivr_modules m ON c.ivr_id = m.ivr_id
    LEFT JOIN keepcoding.ivr_steps s ON c.ivr_id = s.ivr_id
    AND m.module_sequece = s.module_sequece
)
SELECT
  calls_ivr_id,
  calls_phone_number,
  calls_ivr_result,
  calls_vdn_label,
  calls_start_date,
  calls_start_date_id,
  calls_end_date,
  calls_end_date_id,
  calls_total_duration,
  calls_customer_segment,
  calls_ivr_language,
  calls_steps_module,
  calls_module_aggregation,
  module_sequece,
  module_name,
  module_duration,
  module_result,
  step_sequence,
  step_name,
  step_result,
  step_description_error,
  document_type,
  document_identification,
  customer_phone,
  billing_account_id
FROM
  base
WHERE
  rn = 1;