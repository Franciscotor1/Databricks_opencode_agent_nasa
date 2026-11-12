# AGENTS.md — Databricks Opencode Agent Guidelines

## ⚠️ Reglas Absolutas
1. **Workspace Exclusivo**: Realiza todo el código, scripts y artefactos exclusivamente dentro de `/workspace`.
2. **Databricks Free Edition Compliance**: 
   - Utiliza únicamente compute serverless, SQL warehouse 2X-Small y Databricks Asset Bundles (DABs).
   - No intentes usar Lakebase, Agent Bricks, APIs de nivel de cuenta ni características de pago no soportadas.
3. **Seguridad y Secretos**: 
   - **Nunca** imprimas, registres ni guardes tokens, PATs, claves API ni el contenido de `.env` en la memoria del agente ni en archivos del workspace.
   - La memoria persistente (`/data/memory`) está prohibida de almacenar secretos.
4. **Operaciones Destructivas**: 
   - Pide confirmación (`ask`) antes de ejecutar operaciones destructivas (borrado masivo de tablas, drop de catálogos o comandos `rm`).
   - Los comandos `rm -rf *`, `sudo *`, y descargas arbitrarias con `curl`/`wget` están bloqueados (`deny`).
5. **Despliegues**: Utiliza siempre DABs (`databricks bundle`) para empaquetar y desplegar trabajos o pipelines en Databricks.

## 🛠️ Comandos de Verificación
- Lint / Validación DABs: `databricks bundle validate`
- Estado de autenticación: `databricks auth env` o `databricks current-user me`
- Pruebas unitarias (si aplican en workspace): `pytest`
