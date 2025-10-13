# first_last_agg Extension

PostgreSQL first_last_agg Extension.

## Supported Versions

| PostgreSQL | first_last_agg | Distros | Status |
|------------|----------------|---------|--------|
| 18         | 0.1.4          | bookworm, trixie | ✅ Active |

## Usage

### PostgreSQL 18
```yaml
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: postgres-with-first_last_agg
spec:
  instances: 3
  imageName: ghcr.io/cloudnative-pg/postgresql:18-bookworm
  postgresql:
    extensions:
      - name: first-last-agg
        image:
          reference: ghcr.io/cloudnative-pg/first_last_agg:18-18.0-bookworm
  storage:
    size: 1Gi
```



## Available Images

- `ghcr.io/cloudnative-pg/first_last_agg:18-18.0-bookworm`
- `ghcr.io/cloudnative-pg/first_last_agg:18-18.0-trixie`

## Links

- [first_last_agg Documentation](https://github.com/wulczer/first_last_agg)
- [CloudNativePG Extensions Guide](https://cloudnative-pg.io/documentation/current/imagevolume_extensions/)
