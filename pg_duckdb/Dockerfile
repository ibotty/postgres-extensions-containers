FROM ghcr.io/cloudnative-pg/postgresql:18-minimal-bookworm AS builder

USER 0

RUN set -eux; \
	mkdir -p /opt/extension && \
	apt-get update && \
	apt-get install -y --no-install-recommends build-essential git "postgresql-server-dev-18=18*"

COPY . /tmp/pg_duckdb

RUN set -eux; \
        apt-get install -y --no-install-recommends build-essential \
        libreadline-dev zlib1g-dev flex bison libxml2-dev \
        libxslt-dev libssl-dev libxml2-utils xsltproc pkg-config libc++-dev \
        libc++abi-dev libglib2.0-dev libtinfo6 cmake libstdc++-12-dev \
        liblz4-dev ninja-build

RUN set -eux; \
	cd /tmp/pg_duckdb && \
	PG_CONFIG=/usr/lib/postgresql/18/bin/pg_config USE_PGXS=1 make clean && \
	PG_CONFIG=/usr/lib/postgresql/18/bin/pg_config USE_PGXS=1 DUCKDB_BUILD=ReleaseStatic make -j "$(nproc)" && \
	PG_CONFIG=/usr/lib/postgresql/18/bin/pg_config USE_PGXS=1 DUCKDB_BUILD=ReleaseStatic make install datadir=/opt/extension/share/ pkglibdir=/opt/extension/lib/

FROM scratch

COPY --from=builder /opt/extension/lib/ /lib/
COPY --from=builder /opt/extension/share/ /share/
