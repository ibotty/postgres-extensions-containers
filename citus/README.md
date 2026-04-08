# Citus

[Citus](https://www.citusdata.com/) is a PostgreSQL extension that transforms
Postgres into a distributed database.

This image provides a convenient way to deploy and manage Citus with
[CloudNativePG](https://cloudnative-pg.io/).

## Usage

### 1. Add the Citus extension image to your Cluster

Define the `citus` extension under the `postgresql.extensions` section of
your `Cluster` resource. For example:

```yaml
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: cluster-citus
spec:
  imageName: ghcr.io/cloudnative-pg/postgresql:18-minimal-trixie
  instances: 1

  storage:
    size: 1Gi

  shared_preload_libraries:
  - citus

  postgresql:
    extensions:
    - name: citus
      image:
        # renovate: suite=trixie-citus-community depName=postgresql-18-citus-14.0
        reference: ghcr.io/cloudnative-pg/citus-extension:14.0.0.citus-1-18-trixie
      ld_library_path:
      - system
