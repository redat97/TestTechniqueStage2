FROM postgres:15.2

RUN apt-get update -y
RUN apt-get install -f -y build-essential
RUN apt-get install -f -y postgresql-server-dev-15
RUN apt-get install -f -y git

RUN git clone https://github.com/ankane/pgvector.git \
    && cd pgvector \
    && make \
    && make install

COPY 00_create_database.sql /docker-entrypoint-initdb.d/
COPY 01_create_user.sql /docker-entrypoint-initdb.d/
COPY 02_grant_privileges.sql /docker-entrypoint-initdb.d/