# Directories
BASE_DIR := project_name
APPS_DIR := $(BASE_DIR)/apps/

# Color
RESET := \033[0m
BOLD := \033[1m
CYAN:=\033[36m


# Clean code
.PHONY: isort
isort:
	@echo "$(CYAN) ✔ Organizing imports..."
	@pipenv run isort --quiet

.PHONY: autopep8
autopep8:
	@echo "$(CYAN) ✔ Formatting the code based on pep8..."
	@pipenv run autopep8 --in-place --aggressive --aggressive --recursive $(BASE_DIR)

.PHONY: flake8
flake8:
	@echo "$(CYAN) ✔ Checking the code formatting based on pep8..."
	@pipenv run flake8

# CD/CI

.PHONY: pre-commit
pre-commit:
	@echo "$(BOLD) ➮ Checking code and testing:"
	@$(MAKE) isort autopep8 flake8


# Managers
.PHONY: startapp
startapp:
	@echo "$(CYAN) ✔ Creating $(NAME) app in apps folder..."
	@mkdir -p $(APPS_DIR)$(NAME)
	@pipenv run python manage.py startapp $(NAME) $(APPS_DIR)$(NAME)
