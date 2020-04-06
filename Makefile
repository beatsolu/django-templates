# Directories
APPS_DIR := project_name/apps/

# Color
RESET := \033[0m
BOLD := \033[1m
CYAN:=\033[36m

startapp:
	@echo "$(CYAN) ✔ Creating $(NAME) app in apps folder..."
	@mkdir -p $(APPS_DIR)$(NAME)
	@pipenv run python manage.py startapp $(NAME) $(APPS_DIR)$(NAME)
