POETRY_VERSION = 1.4.2

.PHONY: get-poetry
get-poetry:
	curl -sSL https://install.python-poetry.org | python3 - --version $(POETRY_VERSION)

.PHONY: build-env
build-env:
	python3 -m venv .venv
	poetry run pip install --upgrade pip
	poetry run poetry install
	pip install -e .

# Tests
.PHONY: tests
tests:
	poetry run pytest --cov=gwlad --cov-report=term-missing --cov-report=xml tests

# Passive linters
.PHONY: black
black:
	poetry run black gwlad tests --check

.PHONY: flake8
flake8:
	poetry run flake8 gwlad tests

.PHONY: isort
isort:
	poetry run isort gwlad --profile=black --check

.PHONY: mypy
mypy:
	poetry run mypy gwlad tests

.PHONY: pylint
pylint:
	poetry run pylint "gwlad/"

# Aggresive linters
.PHONY: black!
black!:
	poetry run black gwlad tests

.PHONY: isort!
isort!:
	poetry run isort gwlad --profile=black
