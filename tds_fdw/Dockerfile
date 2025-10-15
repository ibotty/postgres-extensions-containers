FROM ghcr.io/cloudnative-pg/postgresql:18-minimal-bookworm AS builder

USER 0

RUN set -eux; \
        LIBDIR=/opt/extension/lib && \
        SHAREDIR=/opt/extension/share/extension && \
	mkdir -p "$LIBDIR" "$SHAREDIR" && \
	apt-get update && \
        apt-get install -y --no-install-recommends postgresql-18-tds-fdw && \
        dpkg -L freetds-common libsybdb5 postgresql-18-tds-fdw | sort -u | while read p; do \
            case $p in \
            /usr/share/postgresql/*/extension/*) cp -P "$p" "$SHAREDIR";; \
            /usr/lib/postgresql/*/lib/*) n="${p##*/lib/}"; [ -d "$p" ] && mkdir -p "$LIBDIR/$n" || cp -P "$p" "$LIBDIR/$n" ;; \
            /usr/lib/x86_64-linux-gnu/*) cp -P "$p" /opt/extension/lib;; \
            esac; \
        done && \
        ls -R /opt/extension

FROM scratch

COPY --from=builder /opt/extension/lib/ /lib/
COPY --from=builder /opt/extension/share/ /share/
