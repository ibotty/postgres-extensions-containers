metadata = {
  name                     = "pg-clickhouse"
  sql_name                 = "pg_clickhouse"
  image_name               = "pg-clickhouse-extension"
  licenses                 = [ "GPL-2.0-or-later", "MIT", "LGPL-2.1-or-later",
                               "GPL-3.0-or-later", "Apache-2.0", "PostgreSQL", "Zlib" ]
  shared_preload_libraries = []
  postgresql_parameters    = {}
  extension_control_path   = []
  dynamic_library_path     = []
  ld_library_path          = ["system"]
  bin_path                 = []
  env                      = {}
  auto_update_os_libs      = true
  required_extensions      = []
  create_extension         = true

  versions = {
    bookworm = {
      "18" = {
        // renovate: suite=bookworm-pgdg depName=pg-clickhouse
        package = "0.2.0-pg18"
        // renovate: suite=bookworm-pgdg depName=pg-clickhouse extractVersion=^(?<version>\d+\.\d+\.\d+)
        sql     = "0.2.0"
      }
    }
    trixie = {
      "18" = {
        // renovate: suite=trixie-pgdg depName=pg-clickhouse
        package = "0.2.0-pg18"
        // renovate: suite=trixie-pgdg depName=pg-clickhouse extractVersion=^(?<version>\d+\.\d+\.\d+)
        sql     = "0.2.0"
      }
    }
  }
}

target "default" {
  name = "${metadata.name}-${sanitize(getExtensionVersion(distro, pgVersion))}-${pgVersion}-${distro}"
  matrix = {
    pgVersion = pgVersions
    distro = distributions
  }
}
