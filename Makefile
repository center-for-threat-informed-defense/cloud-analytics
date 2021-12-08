#
# See `make help` for a list of all available commands.
#

APP_NAME := cloud_analytics
VENV := .venv
PY_VERSION := python3.8
TIMESTAMP := $(shell date -u +"%Y%m%d_%H%M%S")
GIT_HASH := $(shell git rev-parse --short HEAD)

.DEFAULT_GOAL := help

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# the aliasing for the venv target is done primarily for readability
$(VENV): $(VENV)/bin/activate

venv: $(VENV)  ## build python venv

$(VENV)/bin/activate:
	$(PY_VERSION) -m venv --prompt $(APP_NAME) $(VENV)

.PHONY: install
install: venv  upgrade-pip ## Install Python dependencies
	./$(VENV)/bin/python -m pip install -r requirements.txt
	./$(VENV)/bin/python -m pip install -e .

.PHONY: install-dev
install-dev: venv upgrade-pip  ## Install Python dependencies and dev dependencies
	./$(VENV)/bin/python -m pip install -r requirements/dev.txt
	./$(VENV)/bin/python -m pip install -e .

.PHONY: upgrade-pip
upgrade-pip: venv  ## Upgrade pip and related
	./$(VENV)/bin/python -m pip install --upgrade pip wheel setuptools pip-tools

requirements.txt: venv requirements/requirements.in  ## Update requirements dependency tree for main app dependencies
	./$(VENV)/bin/pip-compile  --allow-unsafe --generate-hashes --output-file=$@ requirements/requirements.in

requirements/dev.txt: venv requirements/dev.in requirements.txt  ## Update requirements dependency tree for dev dependencies
	./$(VENV)/bin/pip-compile --allow-unsafe --generate-hashes --output-file=$@ requirements/dev.in

.PHONY: pre-commit-run
pre-commit-run: venv ## Run pre-commit manually on changed files
	./$(VENV)/bin/pre-commit run

.PHONY: pre-commit-run-all
pre-commit-run-all: venv ## Run pre-commit manually on all files
	./$(VENV)/bin/pre-commit run -a

.PHONY: build-container
build-container: venv ## Build container image
	docker build -t $(APP_NAME):dev -t $(APP_NAME):

clean: ## Clean up pycache files
	find . -name '*.pyc' -delete
	find . -name '__pycache__' -type d -delete

clean-all: clean ## Clean up venv and tox if necessary, in addition to standard clean
	rm -rf *.egg *.egg-info/ .venv/ .tox/
