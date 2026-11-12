# Databricks Opencode Agent (Free Edition)

Agente de desarrollo inteligente basado en **opencode**, empaquetado en un contenedor Docker seguro y optimizado para **Databricks Free Edition** (Unity Catalog, serverless, DABs, MCP connectors) sobre Arch Linux / Podman / Docker.

## 🚀 Características Principales
- **Zero Token Overhead en Startup**: Skills y herramientas CLI instalados durante el build de la imagen.
- **Modelo Avanzado con Pensamiento**: Configurado con `google/gemini-3.5-flash-lite` y nivel de pensamiento `medium`.
- **Hardening de Seguridad Extremo**: Contenedor no root, capacidades descartadas (`cap_drop: ALL`), modo solo lectura (`read_only: true`), límites de recursos (CPU/Memoria/PIDs) y permisos estrictos en opencode.
- **Memoria Persistente**: SQLite + índice vectorial en volumen dedicado (`/data/memory`), excluyendo estrictamente secretos.
- **Conectores MCP**: Integración con herramientas gestionadas de Databricks (SQL y funciones de Unity Catalog).

---

## ⚙️ Requisitos Previos
1. Docker o Podman con Docker Compose v2+.
2. Una cuenta en Databricks Free Edition y un Personal Access Token (PAT).
3. Una clave API de Google Gemini (`GEMINI_API_KEY`).

---

## 🛠️ Instalación y Setup

1. Clona o sitúate en el repositorio.
2. Ejecuta el script de configuración inicial:
   ```bash
   make help
   ./scripts/setup.sh
   ```
3. Edita el archivo `.env` creado y añade tus credenciales (asegúrate de que tenga permisos `600`):
   ```bash
   nano .env
   ```

---

## 🚀 Uso

### Construir la imagen Docker:
```bash
make build
```

### Iniciar el agente interactivo:
```bash
make run
```

### Abrir una shell en el contenedor en ejecución:
```bash
make shell
```

---

## 🔒 Seguridad
- **Aislamiento**: El contenedor corre sin privilegios (`user: 1000:1000`), con todas las capacidades Linux descartadas (`cap_drop: ALL`), sistema de archivos raíz de solo lectura y volumen temporal `/tmp` en memoria.
- **Restricciones del Agente**: `edit` y `bash` requieren aprobación (`ask`); comandos destructivos (`rm -rf *`, `sudo`) o descargas arbitrarias están bloqueados (`deny`).

---

## 📚 Documentación Adicional
- [Resultados de Verificación](docs/VERIFICACION.md)
- [Reglas del Agente](AGENTS.md)
