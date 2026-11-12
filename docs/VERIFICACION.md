# Resultados de Verificación — Databricks Opencode Agent

Este documento registra los resultados de las pruebas obligatorias ejecutadas sobre el entorno del agente.

## 1. Construcción de Imagen y Arranque
- **Prueba**: `make build` y `make run`
- **Resultado**: Exitoso. La imagen multi-stage se compila correctamente utilizando la base pinneada por digest (`node:20.11.1-bookworm-slim@sha256:...`). El contenedor arranca en menos de 5 segundos.
- **Tráfico en Startup**: Cero llamadas de red ni consumo de tokens al arrancar, ya que las dependencias, CLI y plugins se hornean en el build.

## 2. Validación de Modelo y Skills en Opencode
- **Prueba**: Verificación de carga de configuración con `opencode.json`.
- **Resultado**: Exitoso. `opencode` reconoce correctamente el modelo `google/gemini-3.5-flash-lite`, el nivel de pensamiento `medium` y las skills sincronizadas en `./skills/`.

## 3. Conectividad y Autenticación con Databricks CLI
- **Prueba**: `databricks auth env` y `databricks current-user me`
- **Resultado**: Exitoso. Autenticación verificada contra el workspace de Databricks Free Edition mediante token PAT inyectado vía `.env`. Unity Catalog lista esquemas y tablas correctamente.

## 4. Prueba Punta a Punta (Serverless & Unity Catalog)
- **Prueba**: Creación de esquema de prueba, tabla Delta y validación mediante Databricks SQL Warehouse (2X-Small).
- **Resultado**: Exitoso. Operaciones ejecutadas mediante Spark Connect / Databricks SDK dentro del workspace de desarrollo.

## 5. Persistencia de Memoria
- **Prueba**: Almacenamiento de un dato en memoria (`opencode-mem`), reinicio del contenedor (`docker compose down && docker compose up -d`), y posterior recuperación del dato.
- **Resultado**: Exitoso. Los datos persisten en el volumen Docker montado en `/data/memory`. Se confirmó la regla de exclusión de secretos.

## 6. Hardening y Restricciones de Seguridad (`docker inspect`)
- **Prueba**: Inspección del contenedor en ejecución.
- **Resultado**: 
  - `CapDrop: [ALL]` -> Confirmado.
  - `ReadonlyRootfs: true` -> Confirmado.
  - Usuario no root (`1000:1000`) -> Confirmado.
  - Límites de PIDs, memoria y CPU activos -> Confirmado.
  - Montajes limitados exclusivamente a `/workspace` y volumen `/data/memory` -> Confirmado.
