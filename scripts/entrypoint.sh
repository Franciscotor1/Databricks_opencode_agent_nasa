#!/bin/bash
set -euo pipefail

EXPECTED_PASSWORD="${AGENT_PASSWORD:-databricks2026}"

echo "=================================================="
echo "  Databricks Opencode Agent - Security Check"
echo "=================================================="
read -s -p "Ingrese la contraseña de acceso al agente: " entered_password
echo ""

if [ "$entered_password" != "$EXPECTED_PASSWORD" ]; then
    echo "[!] Acceso denegado: Contraseña incorrecta."
    exit 1
fi

echo "[+] Acceso concedido. Iniciando agente..."
exec opencode "$@"
