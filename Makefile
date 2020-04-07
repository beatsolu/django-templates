# Directories
BASE_DIR := project_name
APPS_DIR := $(BASE_DIR)/apps/

# Color
RESET := \033[0m
BOLD := \033[1m
CYAN:=\033[36m

# Commands
RUN = pipenv run

#  Virtualenv
.PHONY: virtualenv
virtualenv: EMPTY :=
virtualenv:
	@pipenv install --dev
	@echo $(EMPTY)

# Clean code
.PHONY: isort
isort:
	@echo "$(CYAN) ✔ Organizing imports..."
	@$(RUN) isort --quiet

.PHONY: autopep8
autopep8:
	@echo "$(CYAN) ✔ Formatting the code based on pep8..."
	@$(RUN) autopep8 --in-place --aggressive --aggressive --recursive $(BASE_DIR)

.PHONY: flake8
flake8:
	@echo "$(CYAN) ✔ Checking the code formatting based on pep8..."
	@$(RUN) flake8

.PHONY: test
test:
	@echo "$(CYAN) ✔ Running tests..."
	@$(RUN) pytest  &> /dev/null

# CD/CI

.PHONY: pre-commit
pre-commit:
	@echo "$(BOLD) ➮ Checking code and testing:"
	@$(MAKE) isort autopep8 flake8 test


# Managers
.PHONY: startapp
startapp:
	@echo "$(CYAN) ✔ Creating $(NAME) app in apps folder..."
	@mkdir -p $(APPS_DIR)$(NAME)
	@$(MAKE) run python manage.py startapp $(NAME) $(APPS_DIR)$(NAME)


.PHONY: clean
clean:
	@echo "$(CYAN) ✔  Cleaning project ..."
	@rm -rf htmlcov .coverage .pytest_cache
	@find . -type d -name __pycache__ -delete
	@find . -name *.pyc -delete
	@find . -name db.sqlite3 -delete
