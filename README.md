# Django Templates  
Template design for django LTS projects.  
  
## Quickstart  
  
Create a virtualenv and install django with the desired version.  

    python -m venv .venv
    source .venv/bin/activate 
    pip install django==<VERSION>
> Note: The `<VERSION>` of django must be LTS and must be the same as the branch you chose.

  
After installing django you have available the `django-admin` utility that you use to start your project based on the template.  

    django-admin startproject -v2 --template https://github.com/beatsolu/django-templates/archive/<VERSAO>.zip --extension py,yml,json,md,example,cfg --name Dockerfile,Makefile,Procfile  myproject 
    
Follow the instructions in the README of the generated project.
> Note: The `<VERSION>` in the url is the name of the branch of the installed django version. e.g. `v2.2` .



### Useful commands

`make`

To list all available commands

`make setup`

This command is the starting point for the configurations of the project under development. It creates a virtualenv to run some commands locally, copies the file `.env.example` to` .development`, creates the docker image, executes the migrations in a postgres database, installs the development dependencies and starts the project .

![setup](images/setup.svg)

`make pre-commit`

This command is used automatically by `pre-commit-hook`.

![pre-commit](images/pre-commit.svg)
  
## Overview  

These are the libraries used in the project.
  
### Configuration  
  
[django-configurations](https://django-configurations.readthedocs.io/):  
  
> A helper for organizing Django project settings by relying on well established programming patterns.  
  
[whitenoise](http://whitenoise.evans.io/)  
  
> With a couple of lines of config WhiteNoise allows your web app to serve its own static files, making it a self-contained unit that can be deployed anywhere without relying on nginx, Amazon S3 or any other external service.  
  
### Code quality and Test  

##### Code quality  
  
[isort](https://github.com/timothycrosley/isort)  
  
> isort is a Python utility / library to sort imports alphabetically, and automatically separated into sections and by type.  
  
[autopep8](https://github.com/hhatto/autopep8)  
  
> A tool that automatically formats Python code to conform to the PEP 8 style guide.  
  
[autoflake](https://github.com/myint/autoflake)  
  
> Removes unused imports and unused variables as reported by pyflakes  
  
[flake8](https://github.com/PyCQA/flake8)  
  
> Tool for style guide enforcement.  
  
##### Tests  (Using pytest)
  
[pytest-cov](https://github.com/pytest-dev/pytest-cov)  
  
> Coverage plugin for pytest.  
  
[pytest-django](https://github.com/pytest-dev/pytest-django)  
  
> A Django plugin for pytest.  
 
[pytest-factoryboy](https://github.com/pytest-dev/pytest-factoryboy)  
  
> Factoryboy integration the pytest runner  
  
[coverage-badge](https://github.com/dbrgn/coverage-badge)  
> A small script to generate coverage badges using coverage.

### Version control

[commitlint](https://github.com/conventional-changelog/commitlint)
> Lint commit messages

[husky](https://github.com/typicode/husky)
> Git hooks made easy

[standard-version](https://github.com/conventional-changelog/standard-version)
>Automate versioning and CHANGELOG generation, with semver.org and conventionalcommits.org

[commitizen](https://github.com/commitizen/cz-cli)
> When you commit with Commitizen, you'll be prompted to fill out any required commit fields at commit time.

### Deploy

It is pre-configured to deploy on heroku and aws Elastic Beanstalk docker platform.

### API with Django Rest Framework

Configured with django rest framework with the `/users/` endpoint available. Self-generated documentation is also available with `swagger-ui` and `openapi schema` accessible in the url `/docs`.