# python:3.8-slim-bullseye
ARG BASE_IMAGE=python@sha256:4502482bdbd43fb51f3f5ca54a7303f3dbcae66a39414ebdf6ef57e4234bcc37
FROM $BASE_IMAGE

ARG DBT_PIP_FLAGS
ARG DBT_CORE_PACKAGE
ARG DBT_DATABASE_ADAPTER_PACKAGE
ARG DATADOG_PACKAGE
ARG PRJ_NAME=iota-dev-66d-20231205

RUN apt-get -y update && apt-get -y upgrade && \
  apt-get -y update --fix-missing && \
  apt-get -y install && apt-get -y upgrade && \
  apt-get -y install software-properties-common && \
  apt-get -y install curl && \
  apt-get -y install iputils-ping &&\
  apt-get -y install git libpq-dev openssh-client openssl && \
  apt-get -y autoremove && \
  rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

RUN groupadd -g 999 restricted && \
  useradd -s /bin/sh \
  -m -d /home/restricted \
  -r -u 999 -g restricted restricted

COPY ./bash /usr/src/app/bash
# Copy celery config and serviced.
COPY ./configs/celeryd /etc/default/celeryd
COPY ./bash/celeryd.sh /etc/init.d/celeryd
# Create celery worker user.
RUN groupadd celery && useradd celery -g celery
# Install redis server.
RUN /usr/src/app/bash/ubuntu-setup-redis.sh

COPY requirements.txt /usr/src/app
COPY dev-requirements.txt /usr/src/app

RUN pip install --upgrade pip

RUN pip install                     \
    --no-cache-dir                  \
    --upgrade                       \
    -r requirements.txt             \
    ${DBT_PIP_FLAGS}                \
    ${DBT_CORE_PACKAGE}             \
    ${DBT_DATABASE_ADAPTER_PACKAGE} \
    ${DATADOG_PACKAGE}

RUN pip install                     \
    --no-cache-dir                  \
    --upgrade                       \
    -r dev-requirements.txt         

RUN pip install --force-reinstall MarkupSafe==2.0.1 # TODO: find better fix for this

COPY ./dbt_server /usr/src/app/dbt_server
COPY ./dbt_worker /usr/src/app/dbt_worker
COPY ./working-dir /usr/src/app/working-dir

EXPOSE 8080
CMD ["uvicorn", "dbt_server.server:app", "--reload", "--host", "0.0.0.0", "--port", "8080"]