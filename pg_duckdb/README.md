# pg_duckdb Extension

PostgreSQL pg_duckdb Extension.

## Supported Versions

| PostgreSQL | pg_duckdb | Distros | Status |
|------------|-----------|---------|--------|
| 18         | 1.0.0     | bookworm, trixie | ✅ Active |

## Usage

### PostgreSQL 18
```yaml
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: postgres-with-pg_duckdb
spec:
  instances: 1
  imageName: ghcr.io/cloudnative-pg/postgresql:18-bookworm
  postgresql:
    shared_preload_libraries:
    - pg_duckdb
    extensions:
      - name: pg-duckdb
        image:
          reference: ghcr.io/cloudnative-pg/pg_duckdb:18-1.0.0-bookworm
  storage:
    size: 1Gi
```



## Available Images

- `ghcr.io/cloudnative-pg/pg_duckdb:18-1.0.0-bookworm`

## Links

- [pg_duckdb Documentation](https://github.com/duckdb/pg_duckdb)
- [CloudNativePG Extensions Guide](https://cloudnative-pg.io/documentation/current/imagevolume_extensions/)
