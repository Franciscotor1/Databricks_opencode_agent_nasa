# syntax=docker/dockerfile:1
# Dockerfile para Databricks opencode Agent (Databricks Free Edition)
# Base pinneada por digest sobre Debian Bookworm Slim con Node.js 20

FROM node:20.11.1-bookworm-slim@sha256:2cf067cfed83d5ea958367df9f966191a942351a2df77d6f0193e162b5febfc0 AS builder

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

# Instalar dependencias del sistema necesarias para uv, compilación y databricks CLI
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    unzip \
    ca-certificates \
    python3 \
    python3-pip \
    python3-venv \
    nmap \
    && rm -rf /var/lib/apt/lists/*

# Instalar uv (gestor de paquetes Python ultrarrápido)
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:${PATH}"

# Instalar Databricks CLI oficial
RUN curl -fsSL https://raw.githubusercontent.com/databricks/setup-cli/main/install.sh | sh

# Crear entorno virtual de Python e instalar librerías esenciales (databricks-sdk, databricks-connect)
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:${PATH}"
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir databricks-sdk==0.35.0 databricks-connect==14.1.0

# Instalar opencode CLI de forma global (pinneada a 1.18.13)
RUN npm install -g opencode-ai@1.18.13

# Imagen final ligera
FROM node:20.11.1-bookworm-slim@sha256:2cf067cfed83d5ea958367df9f966191a942351a2df77d6f0193e162b5febfc0

LABEL maintainer="Platform Engineer <databricks-agent@local>"
LABEL description="Opencode agent environment for Databricks Free Edition"

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-venv \
    git \
    curl \
    ca-certificates \
    nmap \
    && rm -rf /var/lib/apt/lists/*

# Copiar entorno virtual de python y binarios de databricks CLI y opencode desde builder
COPY --from=builder /opt/venv /opt/venv
COPY --from=builder /usr/local/bin/databricks /usr/local/bin/databricks
COPY --from=builder /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=builder /usr/local/bin/opencode /usr/local/bin/opencode

ENV PATH="/opt/venv/bin:/usr/local/bin:${PATH}"

# Crear directorios requeridos y asignar permisos al usuario node (UID 1000)
RUN mkdir -p /workspace /data/memory /home/node/.config/opencode && \
    chown -R node:node /workspace /data/memory /home/node

COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /workspace

USER node

# Variables de entorno por defecto
ENV HOME="/home/node"
ENV OPENCODE_MEMORY_PATH="/data/memory"

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["--help"]
