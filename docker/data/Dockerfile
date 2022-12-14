FROM postgres:14.5-alpine



# sudo -u postgres pg_dump database  > database_copy.sql  terminal command

COPY ./docker/data/database_copy.sql /docker-entrypoint-initdb.d/
RUN chmod a+r /docker-entrypoint-initdb.d/*

