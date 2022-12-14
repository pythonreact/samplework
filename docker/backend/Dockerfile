FROM python:3.10-alpine
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONNUNBUFFERED 1
WORKDIR /backend
COPY ./python/django/requirements.txt /tmp/requirements.txt
#RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev libc-dev linux-headers
#RUN apk add jpeg-dev zlib-dev libjpeg
RUN pip install --upgrade pip
RUN pip install -r /tmp/requirements.txt
RUN pip install gunicorn

ADD ./python /backend
EXPOSE 8000
COPY ./docker/backend/wsgi-entrypoint.sh /tmp/wsgi-entrypoint.sh
RUN chmod o+x /tmp/wsgi-entrypoint.sh
ENTRYPOINT ["sh", "-c", "/tmp/wsgi-entrypoint.sh"]
