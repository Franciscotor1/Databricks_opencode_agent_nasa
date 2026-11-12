.PHONY: help build run shell update-skills update-plugins clean

help:
	@echo "Databricks Opencode Agent - Makefile"
	@echo ""
	@echo "Targets:"
	@echo "  make build           Construye la imagen Docker"
	@echo "  make run             Inicia el agente interactivo vía Docker Compose"
	@echo "  make shell           Abre una shell bash dentro del contenedor en ejecución"
	@echo "  make update-skills   Actualiza las skills desde el repositorio oficial"
	@echo "  make update-plugins  Actualiza los plugins de opencode"
	@echo "  make clean           Limpia contenedores y volúmenes temporales"

build:
	docker compose build

run:
	@mkdir -p workspace
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
	docker compose down -v
