#!/usr/bin/env bash
set -euo pipefail

echo "==> Comprobando actualizaciones de plugins de opencode..."
# Los plugins están pinneados en opencode.json. Este script puede verificar versiones o actualizar locks si aplica.
echo "Plugins actuales pinneados en opencode.json: opencode-mem@1.0.2"
echo "Para actualizar, modifica la versión en opencode.json y reconstruye con 'make build'."
