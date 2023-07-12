FROM postgres:15.2

RUN apt-get update -y
RUN apt-get install -f -y build-essential
RUN apt-get install -f -y postgresql-server-dev-15
RUN apt-get install -f -y git

RUN git clone https://github.com/ankane/pgvector.git \
    && cd pgvector \
    && make \
    && make install

RUN echo "listen_addresses='*'" >> /var/lib/postgresql/data/postgresql.conf
RUN echo "host all all 0.0.0.0/0 md5" >> /var/lib/postgresql/data/pg_hba.conf



COPY init.sql /docker-entrypoint-initdb.d/