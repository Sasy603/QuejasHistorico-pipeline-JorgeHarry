{{ config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key='id_registro'
) }}

WITH base AS (
    SELECT
        COALESCE(TIPO, 'DESCONOCIDO') AS TIPO,
        COALESCE(ESTADO, 'DESCONOCIDO') AS ESTADO,
        COALESCE(CANAL_ENTRADA, 'NO ESPECIFICADO') AS CANAL_ENTRADA,
        COALESCE(FECHA_ENTRADA, '1900-01-01') AS FECHA_ENTRADA,
        COALESCE(FECHA_CONTESTACION, '1900-01-01') AS FECHA_CONTESTACION,
        COALESCE(CONSEJERIA, 'SIN CONSEJERIA') AS CONSEJERIA,
        COALESCE(UNIDAD_DESCRIPCION, 'SIN UNIDAD') AS UNIDAD_DESCRIPCION,
        COALESCE(TEMA, 'SIN TEMA') AS TEMA,
        COALESCE(SUBTEMA, 'SIN SUBTEMA') AS SUBTEMA,

        ROW_NUMBER() OVER (
            PARTITION BY
                TIPO, ESTADO, CANAL_ENTRADA, FECHA_ENTRADA,
                CONSEJERIA, UNIDAD_DESCRIPCION, TEMA, SUBTEMA
            ORDER BY FECHA_ENTRADA DESC
        ) AS rn
    FROM {{ source('raw', 'FACT_SUGERENCIAS') }}
)

SELECT
    *,
    {{ dbt_utils.generate_surrogate_key([
        'TIPO', 'ESTADO', 'CANAL_ENTRADA', 'FECHA_ENTRADA',
        'CONSEJERIA', 'UNIDAD_DESCRIPCION', 'TEMA', 'SUBTEMA'
    ]) }} AS id_registro
FROM base
WHERE rn = 1

{% if is_incremental() %}
  AND FECHA_ENTRADA >= (
      SELECT COALESCE(MAX(FECHA_ENTRADA), '1900-01-01')
      FROM {{ this }}
  )
{% endif %}
