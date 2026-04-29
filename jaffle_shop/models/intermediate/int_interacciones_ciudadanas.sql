{{ config(materialized='view') }}

SELECT * FROM {{ ref('stg_fact_agradecimientos') }}
UNION ALL
SELECT * FROM {{ ref('stg_fact_quejas') }}
UNION ALL
SELECT * FROM {{ ref('stg_fact_sugerencias') }}
