FROM python:3.10-buster

# dont write pyc files
ENV PYTHONDONTWRITEBYTECODE 1
# dont buffer to stdout/stderr
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt requirements.txt

# dependencies
RUN set -eux \
    && pip install --upgrade pip setuptools wheel \
    && pip install -r requirements.txt \
    && rm -rf /root/.cache/pip

COPY ./src /src
COPY ./logging.yml logging.yml
