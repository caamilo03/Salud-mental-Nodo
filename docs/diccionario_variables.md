# Diccionario de Variables - Proyecto Salud Mental

## Variables Originales del Dataset

### 1. `Entity` → `pais`
**Tipo:** Texto (String)  
**Descripción:** Nombre del país o región geográfica al que pertenecen los datos.  
**Ejemplo:** Colombia, United States, Brazil  
**Uso:** Permite identificar la ubicación geográfica de cada registro y realizar análisis comparativos entre países.

### 2. `Code` → `codigo_pais`
**Tipo:** Texto (String, 3 caracteres)  
**Descripción:** Código ISO 3166-1 alfa-3 que identifica de manera única a cada país.  
**Ejemplo:** COL (Colombia), USA (Estados Unidos), BRA (Brasil)  
**Uso:** Facilita la integración con otros datasets y visualizaciones geográficas.

### 3. `Year` → `anio`
**Tipo:** Entero (Integer)  
**Descripción:** Año al que corresponden los datos de prevalencia.  
**Rango:** 1990 - 2019  
**Uso:** Permite realizar análisis de tendencias temporales y evolución de enfermedades mentales a lo largo del tiempo.

### 4. `Schizophrenia disorders` → `esquizofrenia`
**Tipo:** Decimal (Float)  
**Descripción:** Porcentaje de la población que padece trastornos de esquizofrenia, estandarizado por edad y sexo.  
**Unidad:** Porcentaje (%)  
**Rango típico:** 0.20% - 0.45%  
**Uso:** Mide la prevalencia de esquizofrenia en la población general.

### 5. `Depressive disorders` → `depresion`
**Tipo:** Decimal (Float)  
**Descripción:** Porcentaje de la población que padece trastornos depresivos, estandarizado por edad y sexo.  
**Unidad:** Porcentaje (%)  
**Rango típico:** 2.5% - 7.0%  
**Uso:** Identifica la prevalencia de depresión, una de las enfermedades mentales más comunes.

### 6. `Anxiety disorders` → `ansiedad`
**Tipo:** Decimal (Float)  
**Descripción:** Porcentaje de la población que padece trastornos de ansiedad, estandarizado por edad y sexo.  
**Unidad:** Porcentaje (%)  
**Rango típico:** 2.5% - 8.0%  
**Uso:** Cuantifica la prevalencia de trastornos de ansiedad en la población.

### 7. `Bipolar disorders` → `bipolaridad`
**Tipo:** Decimal (Float)  
**Descripción:** Porcentaje de la población que padece trastorno bipolar, estandarizado por edad y sexo.  
**Unidad:** Porcentaje (%)  
**Rango típico:** 0.3% - 1.5%  
**Uso:** Mide la prevalencia del trastorno bipolar en la población.

### 8. `Eating disorders` → `trastornos_alimenticios`
**Tipo:** Decimal (Float)  
**Descripción:** Porcentaje de la población que padece trastornos alimenticios (anorexia, bulimia, etc.), estandarizado por edad y sexo.  
**Unidad:** Porcentaje (%)  
**Rango típico:** 0.1% - 1.0%  
**Uso:** Identifica la prevalencia de trastornos de la conducta alimentaria.

---

## Variables Derivadas Creadas

### 9. `promedio_prevalencia`
**Tipo:** Decimal (Float)  
**Descripción:** Promedio aritmético de la prevalencia de las 5 enfermedades mentales registradas.  
**Cálculo:** `(esquizofrenia + depresion + ansiedad + bipolaridad + trastornos_alimenticios) / 5`  
**Unidad:** Porcentaje (%)  
**Uso:** Proporciona una métrica general de carga de enfermedades mentales en un país/año específico.

### 10. `total_prevalencia`
**Tipo:** Decimal (Float)  
**Descripción:** Suma total de la prevalencia de las 5 enfermedades mentales.  
**Cálculo:** `esquizofrenia + depresion + ansiedad + bipolaridad + trastornos_alimenticios`  
**Unidad:** Porcentaje (%)  
**Uso:** Indica la carga total acumulada de enfermedades mentales en la población.

### 11. `decada`
**Tipo:** Entero (Integer)  
**Descripción:** Década a la que pertenece el año del registro.  
**Cálculo:** `(anio // 10) * 10`  
**Ejemplo:** 2005 → 2000, 2019 → 2010  
**Valores posibles:** 1990, 2000, 2010  
**Uso:** Facilita análisis agregados por décadas y comparaciones entre periodos de 10 años.

### 12. `enfermedad_principal`
**Tipo:** Texto (String)  
**Descripción:** Nombre de la enfermedad mental con mayor prevalencia en ese registro (país/año).  
**Valores posibles:** `esquizofrenia`, `depresion`, `ansiedad`, `bipolaridad`, `trastornos_alimenticios`  
**Cálculo:** Determina el valor máximo entre las 5 columnas de enfermedades  
**Uso:** Identifica cuál es la enfermedad mental más prevalente en cada contexto geográfico y temporal.

---

## Agregaciones Realizadas

### 13. `promedio_por_anio`
**Tipo:** DataFrame agrupado  
**Descripción:** Promedio de prevalencia de cada enfermedad mental por año a nivel global.  
**Agrupación:** Por `anio`  
**Uso:** Analizar tendencias temporales globales de cada enfermedad.

### 14. `top_paises`
**Tipo:** Series ordenada  
**Descripción:** Los 10 países con mayor prevalencia promedio de enfermedades mentales.  
**Agrupación:** Por `pais`  
**Uso:** Identificar los países más afectados por enfermedades mentales.

### 15. `stats_decada`
**Tipo:** DataFrame con estadísticas descriptivas  
**Descripción:** Estadísticas descriptivas (media, desviación estándar, mínimo, máximo) de cada enfermedad por década.  
**Agrupación:** Por `decada`  
**Uso:** Comparar la evolución de las enfermedades mentales entre décadas.

---

## Notas Importantes

- **Estandarización por Edad y Sexo:** Todos los porcentajes de prevalencia están estandarizados por edad y sexo, lo que permite comparaciones justas entre países con diferentes estructuras demográficas.

- **Unidad de Medida:** Todos los valores de prevalencia están expresados como porcentaje de la población (%).

- **Periodo de Análisis:** El dataset cubre desde 1990 hasta 2019 (30 años de datos).

- **Dataset Final:** Para el análisis final, se filtran únicamente los datos desde el año 2000 en adelante (variable `df_final`).

- **Volumen de Datos:** El dataset procesado contiene más de 500 registros, cumpliendo con los requisitos mínimos del proyecto.
