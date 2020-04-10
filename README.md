# {{project_name | title}}

Instructions for setting up the project.

![coverage](./coverage.svg)
[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg)](http://commitizen.github.io/cz-cli/)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
## Quickstart

Clone the project in your development environment

```shell script
git clone <CHANGE_FOR_REPO_URL>/{{project_name}}.git
```

Enter the project folder and download and install the dependencies

> Note: Assuming you have [pipenv](https://github.com/pypa/pipenv#installation),  [docker](https://docs.docker.com/install/), [docker-compose](https://docs.docker.com/compose/install/) and [nodejs](https://nodejs.org/en/download/)  installed


```shell script
make setup
```

Install the Commitizen cli tools (Simple commit conventions for internet citizens.)

```shell script
npm install commitizen -g
```
> Note: Now use `git cz` instead of `git commit` when committing.

## Useful commands

```shell script
make setup: Installs development dependencies and creates tables in the database.

make up: Starts project in daemon.

make stop: Stop project services.

make clean: Removes htmlcov, .coverage, .pytest_cache and all *.pyc and __pycache__

make clean-all: Use the clean target and remove virtualenv, node_module and .development file

make manage: Django’s command-line utility for administrative tasks.
 e.g: make manage ARGS='createsuperuser --username=admin --email=admin@example.com'

make startapp: Create app in apps directorie
 e.g: make startapp NAME=app_name

make install: Run pipenv install.
 e.g: make install ARGS=django

make release: Run standard-version cli steps.
 e.g: make release ARGS=--first-release
```
