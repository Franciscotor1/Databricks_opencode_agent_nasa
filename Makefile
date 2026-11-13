.PHONY: help build run shell update-skills update-plugins clean purge

help:
	@echo "Databricks Opencode Agent - Makefile"
	@echo ""
	@echo "Targets:"
	@echo "  make build           Construye la imagen Docker"
	@echo "  make run             Inicia el agente interactivo vía Docker Compose"
	@echo "  make shell           Abre una shell bash dentro del contenedor en ejecución"
	@echo "  make update-skills   Actualiza las skills desde el repositorio oficial"
	@echo "  make update-plugins  Actualiza los plugins de opencode"
	@echo "  make clean           Limpia contenedores sin borrar la memoria persistente"
	@echo "  make purge           Limpia contenedores y elimina la memoria (con confirmación)"

build:
	docker compose build

run:
	@mkdir -p workspace data/memory
	docker compose run --rm opencode-databricks

shell:
	docker compose exec opencode-databricks /bin/bash

update-skills:
	@echo "Actualizando skills de Databricks..."
	./scripts/update-skills.sh

update-plugins:
	@echo "Actualizando plugins de opencode..."
	./scripts/update-plugins.sh

clean:
	docker compose down

purge:
	@echo "¡ADVERTENCIA! Esto borrará la memoria persistente del agente en data/memory."
	@read -p "¿Estás seguro? (y/N) " confirm && [ "$$confirm" = "y" ] && docker compose down -v && rm -rf data/memory || echo "Cancelado."
