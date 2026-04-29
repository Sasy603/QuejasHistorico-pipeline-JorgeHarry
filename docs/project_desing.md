#  Modelo de Datos – Quejas, Agradecimientos y Sugerencias  
### *Arquitectura RAW → STAGING → MODELO ESTRELLA*

    Este proyecto implementa un modelo de datos robusto para procesar diariamente la información de **quejas, agradecimientos y sugerencias** recibidas por la Comunidad de Madrid. El objetivo es garantizar:

- Integridad de los datos  
- Capacidad de manejar correcciones  
- Soporte para *late arriving data*  
- Escalabilidad y auditoría histórica  

---

##  Arquitectura General

### 1 **RAW**  
Contiene los datos tal y como llegan desde la fuente (CSV diario).  
Aquí residen las tablas:

- `FACT_QUEJAS`
- `FACT_AGRADECIMIENTOS`
- `FACT_SUGERENCIAS`
- `DIM_CALENDARIO`
- `DIM_CONSEJERIA`
- `DIM_TEMA`

No se transforman, solo se almacenan.

---

### 2 **STAGING (STAGING SCHEMA)**  
Es la capa donde DBT:

- Limpia los datos  
- Normaliza formatos  
- Aplica lógica incremental  
- Detecta nuevas filas  
- Actualiza filas existentes  
- Gestiona *late arriving data*  

Cada tabla RAW tiene su modelo STAGING:

- `stg_fact_quejas`
- `stg_fact_agradecimientos`
- `stg_fact_sugerencias`

Además, cada modelo tiene un modelo de auditoría:

- `stg_fact_quejas__audit`
- `stg_fact_agradecimientos__audit`
- `stg_fact_sugerencias__audit`

---
### 3 **INTERMEDIATE (INTERMEDIATE SCHEMA)**
Es la capa en la que DBT unifica los datos para el analisis

---
### 4 **MARTS (MARTS SCHEMA)**
Analisis de la informacion para generar las medidas utilizadas en power BI

---

## Lógica Incremental

Los modelos STAGING usan:

```yaml
materialized: incremental
incremental_strategy: merge
unique_key: natural_key
```

### ✔ ¿Qué permite esto?

### ** Inserts nuevos**  
Si el CSV diario trae filas nuevas, se insertan automáticamente.

---

## Tests de Calidad

Cada modelo incremental tiene dos tipos de tests:

### ✔ **1. No duplicados**
Se verifica que la clave natural sea única:

```yaml
tests:
  - unique: natural_key
  - not_null: natural_key
```

### ✔ **2. El número de filas nunca decrece**
Un test personalizado compara:

- El número de filas actual  
- El número máximo histórico registrado en el modelo audit  

Si el número baja, el test falla.

Esto protege contra:

- Borrados accidentales  
- Errores en la ingestión  
- CSV incompletos  

---

## ¿Por qué este modelo?

### ✔ **Robustez ante datos reales**  
Los datos administrativos suelen tener correcciones, duplicados y registros tardíos.  
Este modelo los maneja sin romper integridad.

### ✔ **Escalabilidad**  
El incremental evita recargar millones de filas cada día.

### ✔ **Simplicidad analítica**  
El modelo estrella final será fácil de consultar por analistas y BI.

### ✔ **Buenas prácticas DBT**  
Uso de:

- `sources`
- `ref()`
- tests automáticos
- incremental con merge
- claves naturales