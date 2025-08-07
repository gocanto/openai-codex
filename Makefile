MODEL       := code-davinci-003
SERVICE     := codex
PORT        := 3000
OPENAI_KEY  ?= $(OPENAI_API_KEY)

# Default target
.PHONY: help
help:
	@echo "Usage: make <target> [VARIABLE=value]"
	@echo ""
	@echo "General targets:"
	@echo "  build            Build the Docker image"
	@echo "  up               Start services in detached mode"
	@echo "  down             Stop and remove containers"
	@echo "  restart          Recreate containers"
	@echo "  logs             Tail logs for the 'codex' service"
	@echo "  shell            Open a shell in the 'codex' container"
	@echo ""
	@echo "App commands (inside container):"
	@echo "  install          Install dependencies (npm ci)"
	@echo "  update           Update dependencies (npm update)"
	@echo "  start            Run the app (npm start)"
	@echo "  test             Run tests (npm test)"
	@echo "  lint             Run linter (npm run lint)"
	@echo ""
	@echo "OpenAI Codex targets (run inside Docker container):"
	@echo "  codex-complete   Generate code from a prompt"
	@echo "                   Usage: make codex-complete prompt='Your prompt here'"
	@echo "  codex-edit       Edit existing file with instructions"
	@echo "                   Usage: make codex-edit file=path/to/file prompt='Edit instructions'"

# Docker Compose wrappers (using "docker compose")
.PHONY: build up down restart logs shell
build:
	docker compose build

up:
	docker compose up -d

down:
	docker compose down

restart: down up

logs:
	docker compose logs -f $(SERVICE)

shell:
	docker compose run --rm $(SERVICE) sh

# Application shortcuts inside container
.PHONY: install update start test lint
install:
	docker compose run --rm $(SERVICE) npm ci

update:
	docker compose run --rm $(SERVICE) npm update

start:
	docker compose run --rm -p $(PORT):$(PORT) $(SERVICE) npm start

test:
	docker compose run --rm $(SERVICE) npm test

lint:
	docker compose run --rm $(SERVICE) npm run lint

# OpenAI Codex commands via Docker container
.PHONY: codex-complete codex-edit
codex-complete:
ifndef prompt
	$(error Please set prompt="Your prompt here")
endif
	docker compose run --rm $(SERVICE) openai api completions.create \
	  -m $(MODEL) \
	  -p "$(prompt)" \
	  --stream

codex-edit:
ifndef file
	$(error Please set file=path/to/file)
endif
ifndef prompt
	$(error Please set prompt="Edit instructions here")
endif
	docker compose run --rm $(SERVICE) openai api edits.create \
	  -m $(MODEL) \
	  -i $(file) \
	  -p "$(prompt)" \
	  > $(file).edited && echo "Edited file written to $(file).edited"
