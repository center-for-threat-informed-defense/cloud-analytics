# syntax=docker/dockerfile:1

# Build Python App
FROM python:3.8-bullseye as python
RUN mkdir /app \
    && python -m venv /app/.venv \
    && /app/.venv/bin/python -m pip install -U pip wheel setuptools

ENV LC_ALL=C.UTF-8 LANG=C.UTF-8 \
    PATH=/app/.venv/bin:${PATH}

WORKDIR /app

COPY requirements.txt ./
COPY requirements ./requirements
RUN pip install -r requirements.txt -r requirements/dev.txt
COPY setup.cfg setup.py ./
COPY cloud-analytics/__init__.py ./cloud-analytics/
RUN pip install --no-deps -e .

COPY . ./

# CMD /app/.venv/bin/python
