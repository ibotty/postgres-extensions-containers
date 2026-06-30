# SPDX-FileCopyrightText: Copyright © contributors to CloudNativePG, established as CloudNativePG a Series of LF Projects, LLC.
# SPDX-License-Identifier: Apache-2.0

ARG BASE=ghcr.io/cloudnative-pg/postgresql:18-minimal-trixie
FROM $BASE AS builder

ARG PG_MAJOR
ARG EXT_VERSION
ARG TARGETARCH

USER 0

RUN set -x && apt-get update && \
    apt-get install -y curl && \
    cd /tmp && \
    curl -LfsSo pg-trickle.tar.gz https://github.com/trickle-labs/pg-trickle/releases/download/v${EXT_VERSION}/pg_trickle-${EXT_VERSION}-pg${PG_MAJOR}-linux-${TARGETARCH}.tar.gz && \
    tar xzf pg-trickle.tar.gz && \
    mv pg_trickle-*/ pg-trickle

FROM scratch
ARG PG_MAJOR

# Licenses
COPY --from=builder /tmp/pg-trickle/LICENSE /licenses/pg-trickle/

# Libraries
COPY --from=builder /tmp/pg-trickle/lib/* /lib/

# Share
COPY --from=builder /tmp/pg-trickle//extension/* /share/extension/

USER 65532:65532
