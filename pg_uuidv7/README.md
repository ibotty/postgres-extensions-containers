# pg_uuidv7 Extension

PostgreSQL pg_uuidv7 Extension.

## Supported Versions

| PostgreSQL | pg_uuidv7 | Distros | Status |
|------------|----------------|---------|--------|
| 18         | 0.1.4     | bookworm, trixie | ✅ Active |

## Usage

### PostgreSQL 18
```yaml
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: postgres-with-pg_uuidv7
spec:
  instances: 3
  imageName: ghcr.io/cloudnative-pg/postgresql:18-bookworm
  postgresql:
    extensions:
      - name: pg-uuidv7
        image:
          reference: ghcr.io/cloudnative-pg/pg_uuidv7:18-18.0-bookworm
  storage:
    size: 1Gi
```



## Available Images

- `ghcr.io/cloudnative-pg/pg_uuidv7:18-18.0-bookworm`
- `ghcr.io/cloudnative-pg/pg_uuidv7:18-18.0-trixie`

## Links

- [pg_uuidv7 Documentation](https://github.com/fboulnois/pg_uuidv7)
- [CloudNativePG Extensions Guide](https://cloudnative-pg.io/documentation/current/imagevolume_extensions/)
