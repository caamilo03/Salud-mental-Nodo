-- ============================================================================
-- Script SQL: Creación de Tablas y Consultas - Salud Mental
-- ============================================================================

-- 1. CREACIÓN DE TABLAS

-- Tabla principal: prevalencia_salud_mental
CREATE TABLE IF NOT EXISTS prevalencia_salud_mental (
    id BIGSERIAL PRIMARY KEY,
    pais TEXT NOT NULL,
    codigo_pais TEXT,
    anio INTEGER NOT NULL,
    esquizofrenia NUMERIC(10, 6),
    depresion NUMERIC(10, 6),
    ansiedad NUMERIC(10, 6),
    bipolaridad NUMERIC(10, 6),
    trastornos_alimenticios NUMERIC(10, 6),
    promedio_prevalencia NUMERIC(10, 6),
    total_prevalencia NUMERIC(10, 6),
    decada INTEGER,
    enfermedad_principal TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. CONSULTAS SQL 

-- CONSULTA 1: Agregación - Top 10 países con mayor prevalencia promedio
-- Utiliza: GROUP BY, AVG, ORDER BY, LIMIT
SELECT 
    pais,
    codigo_pais,
    ROUND(AVG(promedio_prevalencia), 4) as promedio_prevalencia,
    COUNT(*) as num_registros,
    MIN(anio) as anio_inicio,
    MAX(anio) as anio_fin
FROM prevalencia_salud_mental
GROUP BY pais, codigo_pais
ORDER BY promedio_prevalencia DESC
LIMIT 10;

-- CONSULTA 2: Filtros y Agregación - Tendencia temporal de depresión (años 2010+)
-- Utiliza: WHERE, GROUP BY, AVG, HAVING, ORDER BY
SELECT 
    anio,
    ROUND(AVG(depresion), 4) as promedio_depresion,
    ROUND(AVG(ansiedad), 4) as promedio_ansiedad,
    COUNT(DISTINCT pais) as num_paises
FROM prevalencia_salud_mental
WHERE anio >= 2010
GROUP BY anio
HAVING AVG(depresion) > 3.0
ORDER BY anio;

-- CONSULTA 3: JOIN - Comparación entre décadas por país
-- Utiliza: JOIN (self-join), agregaciones, filtros
SELECT 
    d1.pais,
    ROUND(AVG(d1.promedio_prevalencia), 4) as promedio_decada_2000,
    ROUND(AVG(d2.promedio_prevalencia), 4) as promedio_decada_2010,
    ROUND(AVG(d2.promedio_prevalencia) - AVG(d1.promedio_prevalencia), 4) as diferencia,
    COUNT(DISTINCT d1.anio) as registros_2000s,
    COUNT(DISTINCT d2.anio) as registros_2010s
FROM prevalencia_salud_mental d1
JOIN prevalencia_salud_mental d2 
    ON d1.pais = d2.pais
WHERE d1.decada = 2000 AND d2.decada = 2010
GROUP BY d1.pais
HAVING COUNT(DISTINCT d1.anio) >= 5 AND COUNT(DISTINCT d2.anio) >= 5
ORDER BY diferencia DESC
LIMIT 15;

-- CONSULTA 4: Agregación por Década - Promedio de prevalencia por década
-- Utiliza: GROUP BY, AVG, COUNT, ORDER BY
SELECT 
    decada,
    COUNT(*) as num_registros,
    ROUND(AVG(esquizofrenia), 4) as promedio_esquizofrenia,
    ROUND(AVG(depresion), 4) as promedio_depresion,
    ROUND(AVG(ansiedad), 4) as promedio_ansiedad,
    ROUND(AVG(promedio_prevalencia), 4) as promedio_general
FROM prevalencia_salud_mental
GROUP BY decada
ORDER BY decada;

-- CONSULTA 5: Filtros Avanzados - Países con alta prevalencia de múltiples enfermedades
-- Utiliza: WHERE múltiple, AND, ORDER BY
SELECT 
    pais,
    anio,
    esquizofrenia,
    depresion,
    ansiedad,
    promedio_prevalencia,
    enfermedad_principal
FROM prevalencia_salud_mental
WHERE depresion > 4.0 
    AND ansiedad > 5.0 
    AND anio >= 2015
ORDER BY promedio_prevalencia DESC
LIMIT 20;

-- ----------------------------------------------------------------------------
-- FIN DEL SCRIPT
-- ============================================================================
