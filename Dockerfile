# syntax=docker/dockerfile:1

# OCI labels
LABEL "org.opencontainers.image.title"="Cloud Analytics"
LABEL "org.opencontainers.image.url"="https://ctid.mitre-engenuity.org/"

# Build Python base image
FROM python:3.8-bullseye as python
RUN mkdir /app && \
    python -m venv /app/.venv && \
    /app/.venv/bin/python -m pip install -U pip wheel setuptools

ENV LC_ALL=C.UTF-8 LANG=C.UTF-8 \
    PATH=/app/.venv/bin:${PATH}

WORKDIR /app

# common python base stage, specific app stage
FROM python as app-build

COPY requirements.txt ./
COPY requirements ./requirements
COPY setup.cfg setup.py ./
COPY cloud-analytics/__init__.py ./cloud-analytics/
RUN --mount=type=cache,target=/root/.cache && \
    python -m pip install -r requirements.txt -r requirements/dev.txt && \
    python -m pip install --no-deps -e .

COPY . ./

# CMD /app/.venv/bin/python
