# QuejasHistorico-pipeline-JorgeHarry

# Proyecto de Analítica de Interacciones Ciudadanas

## Descripción General
Este proyecto tiene como objetivo modelar y analizar las interacciones ciudadanas (quejas, sugerencias, agradecimientos, etc.) para facilitar el seguimiento del desempeño administrativo y la calidad del servicio público.

Se basa en una arquitectura por capas (raw → staging/intermediate → marts), donde los datos son progresivamente limpiados, estandarizados y agregados para su consumo en herramientas de BI.

---

## Procesamiento de Datos

### 🔹 Capa Intermedia (Intermediate)
En esta capa se preparan los datos a nivel de detalle:

- Limpieza y estandarización de campos (uso de macros como `clean_string`)
- Gestión de valores nulos mediante `COALESCE`
- Eliminación de duplicados con `ROW_NUMBER()`
- Generación de claves sustitutas (`id_registro`) mediante macros (`sk_interaccion`)
- Carga incremental basada en fecha (`fecha_entrada`)

Ejemplo de entidades tratadas:
- Interacciones ciudadanas (agradecimientos, quejas, sugerencias)
- Normalización de atributos: tipo, estado, canal, consejería, unidad, tema, subtema

---

## Modelo Dimensional

El proyecto incluye dimensiones que permiten enriquecer el análisis:

- **Dim Calendario**: permite análisis temporal (mes, año, etc.)
- **Dim Consejería**: jerarquía organizativa
- **Dim Tema/Subtema**: categorización de las interacciones

---

## Capa de Marts

La capa *marts* está orientada a negocio y diseñada para consumo directo en reporting.

### Objetivo
Proporcionar métricas agregadas que permitan evaluar:
- Volumen de interacciones
- Calidad del servicio
- Eficiencia en la gestión

### Principales KPIs

Los modelos de marts calculan indicadores como:

- Total de interacciones
- Número y porcentaje de quejas
- Ratio de quejas sobre sugerencias
- Número y porcentaje de quejas rechazadas
- Tiempo medio de respuesta
- Porcentaje de respuestas fuera de plazo (>30 días)

### Nivel de Agregación

Los datos se agrupan por:

- Consejería
- Unidad
- Mes (derivado de `fecha_entrada`)

---

## Casos de Uso

- Cuadros de mando para seguimiento institucional
- Evaluación del desempeño por unidad administrativa
- Identificación de cuellos de botella en la gestión
- Análisis de tendencias en la percepción ciudadana

---

## Características Técnicas

- Modelos incrementales para eficiencia en carga
- Uso de macros reutilizables para estandarización
- Generación de claves surrogate para trazabilidad
- Preparado para integración con herramientas BI (Power BI, Tableau, etc.)

---

## Conclusión

El proyecto proporciona una base sólida para el análisis de la interacción entre ciudadanía y administración, permitiendo tomar decisiones basadas en datos mediante métricas claras, consistentes y orientadas a negocio.
