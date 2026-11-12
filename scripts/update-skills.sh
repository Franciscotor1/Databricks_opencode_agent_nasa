#!/usr/bin/env bash
set -euo pipefail

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

SKILLS_DIR="skills"

echo "==> Clonando databricks/databricks-agent-skills..."
git clone --depth 1 https://github.com/databricks/databricks-agent-skills.git "$TEMP_DIR/skills-repo"

echo "==> Filtrando skills aplicables a Databricks Free Edition..."
mkdir -p "$SKILLS_DIR"

# Seleccionar solo skills relevantes con prefijo oficial databricks-
APPLICABLE_SKILLS=(
    "databricks-core"
    "databricks-apps"
    "databricks-pipelines"
    "databricks-dabs"
    "databricks-model-serving"
    "databricks-vector-search"
    "databricks-serverless-migration"
    "databricks-unity-catalog"
)

for skill in "${APPLICABLE_SKILLS[@]}"; do
    if [ -d "$TEMP_DIR/skills-repo/skills/$skill" ]; then
        rm -rf "$SKILLS_DIR/$skill"
        cp -r "$TEMP_DIR/skills-repo/skills/$skill" "$SKILLS_DIR/"
        echo "[+] Skill sincronizado: $skill"
    else
        echo "[-] Skill no encontrado en repositorio upstream: $skill"
    fi
done

echo "==> Skills actualizadas correctamente."
