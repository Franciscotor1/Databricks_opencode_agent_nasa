#!/bin/bash
set -euo pipefail

# Si se define AGENT_PASSWORD en el entorno, se valida. De lo contrario, opcionalmente verifica autenticación del sistema o inicia directamente.
if [ -n "${AGENT_PASSWORD:-}" ]; then
    echo "=================================================="
    echo "  Databricks Opencode Agent - Security Check"
    echo "=================================================="
    read -s -p "Ingrese su contraseña de acceso: " entered_password
    echo ""

    if [ "$entered_password" != "$AGENT_PASSWORD" ]; then
        echo "[!] Acceso denegado: Contraseña incorrecta."
        exit 1
    fi
    echo "[+] Acceso concedido."
fi

exec opencode "$@"
