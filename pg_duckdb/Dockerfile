FROM ghcr.io/cloudnative-pg/postgresql:18-minimal-bookworm AS builder

USER 0

RUN set -eux; \
	# Initial system libraries
	ldconfig -p | awk '{print $NF}' | grep '^/' | sort | uniq > /tmp/base-image-libs.out

RUN set -eux; \
	mkdir -p /opt/extension && \
	apt-get update && \
	apt-get install -y --no-install-recommends build-essential git "postgresql-server-dev-18=18*"

RUN set -eux; \
        apt-get install -y --no-install-recommends \
        build-essential libreadline-dev zlib1g-dev flex bison libxml2-dev \
        libxslt-dev libssl-dev libxml2-utils xsltproc pkg-config libc++-dev \
        libc++abi-dev libglib2.0-dev libtinfo6 cmake libstdc++-12-dev \
        liblz4-dev libcurl4-openssl-dev ninja-build

COPY . /tmp/pg_duckdb

RUN set -eux; \
	cd /tmp/pg_duckdb && \
        ls && \
	PG_CONFIG=/usr/lib/postgresql/18/bin/pg_config USE_PGXS=1 make clean && \
	PG_CONFIG=/usr/lib/postgresql/18/bin/pg_config USE_PGXS=1 DUCKDB_BUILD=ReleaseStatic make -j "$(nproc)" && \
	PG_CONFIG=/usr/lib/postgresql/18/bin/pg_config USE_PGXS=1 DUCKDB_BUILD=ReleaseStatic make install datadir=/opt/extension/share/ pkglibdir=/opt/extension/lib/

RUN set -eux; \
        mkdir /system && \
        ldd /opt/extension/lib/*.so \
		| awk '{print $3}' | grep '^/' | sort | uniq > /tmp/all-deps.out && \
        comm -13 /tmp/base-image-libs.out /tmp/all-deps.out > /tmp/libraries.out && \
        while read -r lib; do \
		resolved=$(readlink -f "$lib"); \
		dir=$(dirname "$lib"); \
		base=$(basename "$lib"); \
		# Copy the real file
		cp -a "$resolved" /system/; \
		# Reconstruct all its symlinks
		for file in "$dir"/"${base%.so*}.so"*; do \
			[ -e "$file" ] || continue; \
			# If it's a symlink and it resolves to the same real file, we reconstruct it
			if [ -L "$file" ] && [ "$(readlink -f "$file")" = "$resolved" ]; then \
				ln -sf "$(basename "$resolved")" "/system/$(basename "$file")"; \
			fi; \
		done; \
	done < /tmp/libraries.out

FROM scratch

COPY --from=builder /opt/extension/lib/ /lib/
COPY --from=builder /opt/extension/share/ /share/
COPY --from=builder /system /system/

USER 65532:65532
