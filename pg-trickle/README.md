# PG-Trickle
<!--
SPDX-FileCopyrightText: Copyright © contributors to CloudNativePG, established as CloudNativePG a Series of LF Projects, LLC.
SPDX-License-Identifier: Apache-2.0
-->

The pg-trickle extension is an extension for streaming tables with incremental
view maintenance, powered by differential dataflow in Rust.
For more information, see the [official documentation](https://trickle-labs.github.io/pg-trickle).

## Usage

### 1. Add the pg-trickle extension image to your Cluster

Define the `pg-trickle` extension under the `postgresql.extensions` section of
your `Cluster` resource. For example:

```yaml
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: cluster-pg-trickle
spec:
  imageName: ghcr.io/cloudnative-pg/postgresql:18-minimal-trixie
  instances: 1

  storage:
    size: 1Gi

  postgresql:
    extensions:
    - name: pg-trickle
      image:
        reference: ghcr.io/cloudnative-pg/pg-trickle-extension:0.81.0-trixie
```

### 2. Enable the extension in a database

You can install `pg-trickle` in a specific database by creating or updating a
`Database` resource. For example, to enable it in the `app` database:

```yaml
apiVersion: postgresql.cnpg.io/v1
kind: Database
metadata:
  name: cluster-pg-trickle-app
spec:
  name: app
  owner: app
  cluster:
    name: cluster-pg-trickle
  extensions:
  - name: pg-trickle
    version: '0.81.0'
```

<!--
TODO: Adjust the extractVersion regex pattern above based on your extension's versioning scheme
Examples: \d+\.\d+ for major.minor (e.g., "18.0"), \d+\.\d+\.\d+ for major.minor.patch (e.g., "0.8.2")
-->

### 3. Verify installation

Once the database is ready, connect to it with `psql` and run:

```sql
\dx
```

You should see `pg-trickle` listed among the installed extensions.

## Contributors

This extension is maintained by:

- FirstName LastName (@GitHub_Handle)

The maintainers are responsible for:

- Monitoring upstream releases and security vulnerabilities.
- Ensuring compatibility with supported PostgreSQL versions.
- Reviewing and merging contributions specific to this extension's container
  image and lifecycle.

---

## Licenses and Copyright

This container image contains software that may be licensed under various
open-source licenses.

All relevant license and copyright information for the `pg-trickle` extension
and its dependencies are bundled within the image at:

```text
/licenses/
```

By using this image, you agree to comply with the terms of the licenses
contained therein.
