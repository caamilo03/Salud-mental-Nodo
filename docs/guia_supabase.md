# Guía Paso a Paso: Configuración de Supabase

## 📋 Requisitos Previos
- Tener una cuenta de correo electrónico
- Navegador web actualizado
- Datos procesados listos para cargar (archivo CSV o DataFrame)

---

## 🚀 Paso 1: Crear Cuenta en Supabase

1. **Visita el sitio web oficial:**
   - Abre tu navegador y ve a: [https://supabase.com](https://supabase.com)

2. **Registro:**
   - Haz clic en **"Start your project"** o **"Sign Up"**
   - Puedes registrarte con:
     - GitHub (recomendado para desarrolladores)
     - Google
     - Correo electrónico

3. **Verificación:**
   - Si usas correo electrónico, revisa tu bandeja de entrada y confirma tu cuenta

---

## 🏗️ Paso 2: Crear un Nuevo Proyecto

1. **Dashboard de Supabase:**
   - Una vez iniciada sesión, verás el dashboard principal
   - Haz clic en **"New Project"** (Nuevo Proyecto)

2. **Configuración del Proyecto:**
   - **Project Name (Nombre):** `salud-mental-nodo` (o el nombre que prefieras)
   - **Database Password (Contraseña):** Crea una contraseña segura y **guárdala en un lugar seguro**
   - **Region (Región):** Selecciona la más cercana geográficamente
     - Para Colombia/Latinoamérica: `South America (São Paulo)`
     - Para USA: `East US (North Virginia)` o `West US (Oregon)`
   - **Pricing Plan:** Selecciona **"Free"** para comenzar

3. **Crear Proyecto:**
   - Haz clic en **"Create new project"**
   - Espera 1-2 minutos mientras Supabase configura tu base de datos

---

## 🔑 Paso 3: Obtener Credenciales de Conexión

1. **Acceder a la Configuración:**
   - En el menú lateral izquierdo, haz clic en el ícono de **engranaje ⚙️** (Settings)
   - Selecciona **"API"** en el submenú

2. **Copiar Credenciales:**
   Necesitarás 2 valores importantes:

   **a) Project URL:**
   ```
   https://xxxxxxxxxxxxx.supabase.co
   ```
   - Copia este valor completo (incluye `https://`)

   **b) API Key (anon/public):**
   ```
   eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
   ```
   - Busca la sección **"Project API keys"**
   - Copia el valor de **"anon" / "public"** (es una cadena larga)

3. **Guardar Credenciales:**
   - Guarda estas 2 credenciales en un archivo de texto temporal
   - **NUNCA las compartas públicamente ni las subas a GitHub**

---

## 📊 Paso 4: Crear la Tabla en Supabase

### Opción A: Usar el Editor SQL (Recomendado)

1. **Abrir el Editor SQL:**
   - En el menú lateral, haz clic en **"SQL Editor"**
   - Haz clic en **"New query"**

2. **Ejecutar el Script de Creación:**
   Copia y pega el siguiente código SQL en el editor:

```sql
-- Crear la tabla prevalencia_salud_mental
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

-- Crear índices para mejorar el rendimiento de consultas
CREATE INDEX IF NOT EXISTS idx_pais ON prevalencia_salud_mental(pais);
CREATE INDEX IF NOT EXISTS idx_anio ON prevalencia_salud_mental(anio);
CREATE INDEX IF NOT EXISTS idx_decada ON prevalencia_salud_mental(decada);
CREATE INDEX IF NOT EXISTS idx_pais_anio ON prevalencia_salud_mental(pais, anio);

-- Comentarios sobre las columnas
COMMENT ON TABLE prevalencia_salud_mental IS 'Datos de prevalencia de enfermedades mentales por país y año (2000-2019)';
COMMENT ON COLUMN prevalencia_salud_mental.pais IS 'Nombre del país';
COMMENT ON COLUMN prevalencia_salud_mental.codigo_pais IS 'Código ISO 3166-1 alfa-3 del país';
COMMENT ON COLUMN prevalencia_salud_mental.anio IS 'Año del registro';
COMMENT ON COLUMN prevalencia_salud_mental.esquizofrenia IS 'Prevalencia de esquizofrenia (% población)';
COMMENT ON COLUMN prevalencia_salud_mental.depresion IS 'Prevalencia de depresión (% población)';
COMMENT ON COLUMN prevalencia_salud_mental.ansiedad IS 'Prevalencia de ansiedad (% población)';
COMMENT ON COLUMN prevalencia_salud_mental.bipolaridad IS 'Prevalencia de trastorno bipolar (% población)';
COMMENT ON COLUMN prevalencia_salud_mental.trastornos_alimenticios IS 'Prevalencia de trastornos alimenticios (% población)';
COMMENT ON COLUMN prevalencia_salud_mental.promedio_prevalencia IS 'Promedio de prevalencia de todas las enfermedades';
COMMENT ON COLUMN prevalencia_salud_mental.total_prevalencia IS 'Suma total de prevalencia de todas las enfermedades';
COMMENT ON COLUMN prevalencia_salud_mental.decada IS 'Década del registro (1990, 2000, 2010)';
COMMENT ON COLUMN prevalencia_salud_mental.enfermedad_principal IS 'Enfermedad con mayor prevalencia';
```

3. **Ejecutar el Script:**
   - Haz clic en el botón **"Run"** o presiona `Ctrl + Enter` (Windows) / `Cmd + Enter` (Mac)
   - Deberías ver el mensaje: **"Success. No rows returned"**

4. **Verificar la Tabla:**
   - Ve a **"Table Editor"** en el menú lateral
   - Deberías ver la tabla `prevalencia_salud_mental` en la lista

### Opción B: Usar la Interfaz Visual

1. **Table Editor:**
   - Haz clic en **"Table Editor"** en el menú lateral
   - Clic en **"New table"**

2. **Configuración:**
   - **Name:** `prevalencia_salud_mental`
   - Desmarca **"Enable Row Level Security (RLS)"** (por ahora)
   - Agrega las columnas manualmente según la tabla anterior

---

## 🔐 Paso 5: Configurar Políticas de Seguridad (Opcional pero Recomendado)

Por defecto, Supabase requiere políticas de seguridad (RLS - Row Level Security). Para desarrollo inicial, puedes deshabilitarlas temporalmente:

1. **Deshabilitar RLS (Solo para Desarrollo):**
```sql
ALTER TABLE prevalencia_salud_mental DISABLE ROW LEVEL SECURITY;
```

2. **O crear una política permisiva (Desarrollo):**
```sql
-- Permitir lectura pública
CREATE POLICY "Permitir lectura pública"
ON prevalencia_salud_mental
FOR SELECT
TO public
USING (true);

-- Permitir inserción pública (solo para desarrollo)
CREATE POLICY "Permitir inserción pública"
ON prevalencia_salud_mental
FOR INSERT
TO public
WITH CHECK (true);
```

⚠️ **IMPORTANTE:** Para producción, debes configurar políticas de seguridad más restrictivas.

---

## 🔌 Paso 6: Actualizar el Código del Notebook

1. **Abrir el notebook:** `notebooks/analisis_exploratorio.ipynb`

2. **Buscar la sección:** "## 10. Conexión a Supabase"

3. **Reemplazar las credenciales:**
```python
# Reemplaza estos valores con tus credenciales reales
SUPABASE_URL = "https://xxxxxxxxxxxxx.supabase.co"  # Tu Project URL
SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."  # Tu anon/public key
```

4. **Guardar el notebook**

---

## 📤 Paso 7: Ejecutar la Carga de Datos

1. **Ejecutar las celdas del notebook:**
   - Celda de conexión a Supabase (verifica que conecte correctamente)
   - Celda de inserción de datos (descomenta el código si está comentado)

2. **Verificar la Carga:**
   - Ve a **"Table Editor"** en Supabase
   - Selecciona la tabla `prevalencia_salud_mental`
   - Deberías ver los registros cargados

---

## ✅ Verificación Final

### Verificar Cantidad de Registros:
```sql
SELECT COUNT(*) FROM prevalencia_salud_mental;
```

### Ver Primeros 10 Registros:
```sql
SELECT * FROM prevalencia_salud_mental LIMIT 10;
```

### Verificar Países Únicos:
```sql
SELECT DISTINCT pais FROM prevalencia_salud_mental ORDER BY pais;
```

---

## 🛠️ Solución de Problemas Comunes

### Error: "relation 'prevalencia_salud_mental' does not exist"
**Solución:** La tabla no existe. Vuelve al Paso 4 y crea la tabla.

### Error: "JWT expired" o problemas de autenticación
**Solución:** Verifica que estás usando la API Key correcta (anon/public, NO la service_role).

### Error: "new row violates row-level security policy"
**Solución:** Deshabilita RLS temporalmente o crea políticas permisivas (ver Paso 5).

### Los datos no se insertan
**Solución:** 
- Verifica que el código de inserción esté descomentado
- Revisa la consola para ver mensajes de error
- Verifica que los tipos de datos coincidan con el esquema de la tabla

---

## 📚 Recursos Adicionales

- **Documentación Oficial:** [https://supabase.com/docs](https://supabase.com/docs)
- **Python Client:** [https://supabase.com/docs/reference/python](https://supabase.com/docs/reference/python)
- **SQL Reference:** [https://supabase.com/docs/guides/database](https://supabase.com/docs/guides/database)

---

## 🔒 Mejores Prácticas de Seguridad

1. **Nunca subas credenciales a GitHub:**
   - Usa variables de entorno
   - Crea un archivo `.env` (y agrégalo a `.gitignore`)

2. **En Producción:**
   - Habilita Row Level Security (RLS)
   - Usa políticas de seguridad restrictivas
   - Usa la `service_role` key solo en el backend

3. **Backup Regular:**
   - Supabase hace backups automáticos (plan Free: 7 días)
   - Considera exportar datos regularmente

---

¡Tu base de datos en Supabase está lista para usar! 🎉
