#!/usr/bin/env bash
set -euo pipefail

echo "==> Configurando entorno para Databricks Opencode Agent..."

# Crear workspace si no existe
mkdir -p workspace

# Comprobar si .env existe, si no copiar desde .env.example
if [ ! -f .env ]; then
    if [ -f .env.example ]; then
        cp .env.example .env
        chmod 600 .env
        echo "[+] Creado archivo .env desde .env.example (por favor edítalo con tus credenciales)."
    else
        echo "[-] Advertencia: No se encontró .env.example"
    fi
else
    echo "[+] Archivo .env ya existe."
fi

echo "==> Setup completado. Ejecuta 'make build' para compilar la imagen."
