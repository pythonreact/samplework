#!/bin/sh
while ! nc -zv $POSTGRES_HOST $POSTGRES_PORT; do
    echo "Waiting for postgres..."
    sleep 1
done
echo "PostgreSQL started"



if [ "${DJANGO_SETTINGS_DEBUG}" = "1" ]
then
    until /backend/django/manage.py makemigrations 
    do
        echo "Make migrations..."; 
        sleep 1
    done
    echo "Make migrations ok"


    until /backend/django/manage.py migrate 
    do
        echo "Migrate..."
        sleep 1
    done
    echo "Migration ok"

    until /backend/django/manage.py collectstatic --noinput 
    do
        echo "Collect Static..."
        sleep 1
    done
    echo "Collect Static ok"

    echo "Debug mode"
    /backend/django/manage.py runserver 0.0.0.0:8000

else
    echo "Production mode"

    until cd /backend/django 

    do
        echo "Change to folder..."
        sleep 1
    done
    echo "Starting Gunicorn"

    gunicorn fullstack.wsgi:application --bind 0.0.0.0:8000 \
        --worker-class=gthread \
        --workers 3 \
        --worker-connections 1000 \
        --threads 9 \
        --log-level=info \
        --log-file=/backend/django/logs/gunicorn_log.log \
        --error-logfile=/backend/django/logs/gunicorn_error.log \
        --access-logfile=/backend/django/logs/gunicorn_access.log 
fi
exec "$@"
