metadata = {
  name                     = "citus"
  sql_name                 = "citus_columnar"
  image_name               = "citus-extension"
  licenses                 = [ "AGPL-3.0-or-later", "PostgreSQL" ]
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
        // renovate: suite=bookworm-citus-community depName=postgresql-18-citus-14.0
        package = "14.0.0.citus-1"
        // renovate: suite=bookworm-citus-community depName=postgresql-18-citus-14.0 extractVersion=^(?<version>\d+\.\d+)
        sql     = "14.0"
      }
    }
    trixie = {
      "18" = {
        // renovate: suite=trixie-citus-community depName=postgresql-18-citus-14.0
        package = "14.0.0.citus-1"
        // renovate: suite=trixie-citus-community depName=postgresql-18-citus-14.0 extractVersion=^(?<version>\d+\.\d+)
        sql     = "14.0"
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

  args = {
    CITUS_VERSION = "3"
  }
}
