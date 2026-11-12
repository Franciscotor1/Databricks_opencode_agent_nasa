#!/bin/bash
set -euo pipefail

echo "=================================================="
echo "  Autenticación de Sistema - Databricks Opencode"
echo "=================================================="

# Utiliza el subsistema PAM / sudo del sistema operativo para verificar
# la contraseña real del usuario local del sistema.
if ! sudo -v; then
    echo "[!] Autenticación fallida: Contraseña de sistema incorrecta o permisos insuficientes."
    exit 1
fi

echo "[+] Autenticación exitosa. Iniciando el agente..."
docker compose run --rm opencode-databricks "$@"
