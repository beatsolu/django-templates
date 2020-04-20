FROM python:3.8.2-alpine
ENV PYTHONUNBUFFERED 1
ENV DJANGO_SETTINGS_MODULE project_name.settings
ENV DJANGO_CONFIGURATION Production
ARG DEVELOPMENT
RUN apk update && \
    apk add \
    gcc \
    musl-dev \
    python3-dev \
    postgresql-dev
WORKDIR project_name
COPY . /project_name
RUN pip install pipenv
RUN pipenv install --system --deploy $DEVELOPMENT
EXPOSE 8000
CMD ["gunicorn", \
     "--workers=2",\
     "--worker-class=gthread",  \
     "--worker-tmp-dir=/dev/shm",\
     "--threads=4", \
     "--log-file=-", \
     "--bind=0.0.0.0:8000",\
     "project_name.wsgi"]
