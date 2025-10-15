# tds_fdw Extension

PostgreSQL tds_fdw Extension.

## Supported Versions

| PostgreSQL | Distros  | Status |
|------------|----------|--------|
| 18         | bookworm | ✅ Active |

## Usage

### PostgreSQL 18
```yaml
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: postgres-with-tds_fdw
spec:
  instances: 1
  imageName: ghcr.io/cloudnative-pg/postgresql:18-bookworm
  postgresql:
    extensions:
      - name: tds-fdw
        ld_library_path:
        - lib
        image:
          reference: ghcr.io/cloudnative-pg/tds_fdw:18-1.0.0-bookworm
  storage:
    size: 1Gi
```



## Available Images

- `ghcr.io/cloudnative-pg/tds_fdw:18-bookworm`

## Links

- [tds_fdw Documentation](https://github.com/duckdb/tds_fdw)
- [CloudNativePG Extensions Guide](https://cloudnative-pg.io/documentation/current/imagevolume_extensions/)
