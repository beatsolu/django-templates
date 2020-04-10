# Directories
BASE_DIR := {{project_name}}
APPS_DIR := $(BASE_DIR)/apps/

# Color
RESET := \033[0m
BOLD := \033[1m
BLUE := \033[34m
YELLOW := \033[33m

CYAN :=\033[36m

# Commands
RUN = pipenv run


.PHONY: help
.DEFAULT: help
help:
	@echo "$(CYAN)make $(BLUE)setup:$(CYAN) Installs development dependencies and creates tables in the database."
	@echo $(EMPTY)
	@echo "$(CYAN)make $(BLUE)up:$(CYAN) Starts project in daemon."
	@echo $(EMPTY)
	@echo "$(CYAN)make $(BLUE)stop:$(CYAN) Stop project services."
	@echo $(EMPTY)
	@echo "$(CYAN)make $(BLUE)clean:$(CYAN) Removes htmlcov, .coverage, .pytest_cache and all *.pyc and __pycache__"
	@echo $(EMPTY)
	@echo "$(CYAN)make $(BLUE)clean-all:$(CYAN) Use the clean target and remove virtualenv, node_module and .development file"
	@echo $(EMPTY)
	@echo "$(CYAN)make $(BLUE)manage:$(CYAN) Django’s command-line utility for administrative tasks."
	@echo " e.g: $(CYAN)make $(BLUE)manage $(CYAN)ARGS='createsuperuser --username=admin --email=admin@example.com' "
	@echo $(EMPTY)
	@echo "$(CYAN)make $(BLUE)startapp:$(CYAN) Create app in apps directorie"
	@echo " e.g: $(CYAN)make $(BLUE)startapp $(CYAN)NAME=app_name "
	@echo $(EMPTY)
	@echo "$(CYAN)make $(BLUE)install:$(CYAN) Run pipenv install."
	@echo " e.g: $(CYAN)make $(BLUE)install $(CYAN)ARGS=django "
	@echo $(EMPTY)
	@echo "$(CYAN)make $(BLUE)release:$(CYAN) Run standard-version cli steps."
	@echo " e.g: $(CYAN)make $(BLUE)release $(CYAN)ARGS=--first-release "
	@echo $(EMPTY)

#  Virtualenv
.PHONY: virtualenv
virtualenv:
	@echo "$(CYAN) ✔ Creating virtualenv if  not exists $(RESET)(This may take a few minutes)$(CYAN)..."
	@[[ -d .venv ]] || PIPENV_VENV_IN_PROJECT=true pipenv install --dev &> /dev/null

# Configure development enviroment
.PHONY: setup
setup:
	@clear
	@echo "$(BOLD) ➮ $(YELLOW)Starting development environment for this project: $(RESET)"
	@$(MAKE) virtualenv
	@echo "$(CYAN) ✔ Creating a copy of the .env.example to .development ..."
	@cp .env.example .development
	@echo "$(CYAN) ✔ Creating an image for the project from the Dockerfile $(RESET)(This may take a few minutes)$(CYAN)..."
	@docker-compose  build --build-arg DEVELOPMENT=--dev --quiet
	@echo "$(CYAN) ✔ Creating tables in the database from migrations ..."
	@docker-compose run --rm web python manage.py migrate &> /dev/null
	@echo "$(CYAN) ✔ Installing development dependencies ..."
	@npm install &> /dev/null
	@$(MAKE) up

# Clean code
.PHONY: organize
organize:
	@echo "$(CYAN) ✔ Organizing imports...$(RESET)"
	@$(RUN) isort --quiet

.PHONY: format
format:
	@echo "$(CYAN) ✔ Formatting the code based ...$(RESET)"
	@$(RUN) autopep8 --in-place --aggressive --aggressive --recursive $(BASE_DIR)
	@$(RUN) autoflake --in-place --remove-all-unused-imports --remove-unused-variables --recursive $(BASE_DIR)

.PHONY: check
check:
	@echo "$(CYAN) ✔ Checking the code ...$(RESET)"
	@$(RUN) flake8 $(BASE_DIR)

.PHONY: test
test:
	@echo "$(CYAN) ✔ Running tests...$(RESET)"
	@$(RUN) pytest

# CD/CI

.PHONY: coverage-badge
coverage-badge:
	@echo "$(CYAN) ✔  Create coverage badge ...$(RESET)"
	@$(RUN) coverage-badge > coverage.svg

.PHONY: pre-commit
pre-commit:
	@clear
	@echo "$(BOLD) ➮ $(YELLOW)Checking code and testing: "
	@$(MAKE) organize format check test coverage-badge


# Managers

.PHONY: manage
manage: ARGS = 'help'
manage:
	@$(RUN) python manage.py $(ARGS) --settings={{project_name}}.settings --configuration=Development

.PHONY: startapp
startapp:
	@echo "$(CYAN) ✔ Creating $(NAME) app in apps folder..."
	@mkdir -p $(APPS_DIR)$(NAME)
	@$(MAKE) run python manage.py startapp $(NAME) $(APPS_DIR)$(NAME)


# Utilities

.PHONY: up
up:
	@docker-compose up -d &> /dev/null
	@echo $(EMPTY)
	@echo "$(CYAN) 🐍 Running in http://127.0.0.1:8000"
	@echo $(EMPTY)

.PHONY:
stop:
	@docker-compose stop &> /dev/null
	@echo $(EMPTY)
	@echo "$(CYAN) 😢 Stopped"
	@echo $(EMPTY)

.PHONY: install
install:
	@pipenv install $(ARGS)

.PHONY: release
release:
	@npm run release -- $(ARGS)

.PHONY: clean
clean:
	@echo "$(CYAN) 🧹 Cleaning project  ..."
	@find . -type d -name htmlcov -exec rm -rf {} +
	@find . -type d -name .pytest_cache -exec rm -rf {} +
	@find . -type d -name __pycache__ -exec rm -rf {} +
	@find . -name *.pyc -delete
	@find . -name .coverage -delete
	@find . -name db.sqlite3 -delete

.PHONY: clean-all
clean-all:
	@echo "$(YELLOW) 🚫️ CAUTION $(RESET)" ️
	@while [ -z "$$CONTINUE" ]; do \
	read -r -p "It will be necessary to redo the setup. Do you wish to continue? [y/N]:" CONTINUE; \
	done ; \
	if [ $$CONTINUE == "y" ]; then \
		$(MAKE) clean ; \
		find . -name .development -delete; \
		find . -type d -name .venv -exec rm -rf {} +; \
		find . -type d -name node_modules -exec rm -rf {} +; \
	fi


