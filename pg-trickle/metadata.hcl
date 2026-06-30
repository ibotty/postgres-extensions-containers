# SPDX-FileCopyrightText: Copyright © contributors to CloudNativePG, established as CloudNativePG a Series of LF Projects, LLC.
# SPDX-License-Identifier: Apache-2.0
metadata = {
  name                     = "pg-trickle"
  sql_name                 = "pg_trickle"
  image_name               = "pg-trickle-extension"
  licenses                 = ["Apache-2.0"]
  shared_preload_libraries = ["pg_trickle"]
  postgresql_parameters    = {}
  extension_control_path   = []
  dynamic_library_path     = []
  ld_library_path          = []
  bin_path                 = []
  env = {}
  auto_update_os_libs      = false
  required_extensions      = []
  create_extension         = true

  versions = {
    bookworm = {
      "18" = {
        # // renovate: suite=bookworm-pgdg depName=postgresql-18-postgis-3
        package = "0.81.0"
        // renovate: suite=bookworm-pgdg depName=postgresql-18-postgis-3 extractVersion=^(?<version>\d+\.\d+\.\d+)
        sql     = "0.81.0"
      }
    }
    trixie = {
      "18" = {
        // renovate: suite=trixie-pgdg depName=postgresql-18-postgis-3
        package = "0.81.0"
        // renovate: suite=trixie-pgdg depName=postgresql-18-postgis-3 extractVersion=^(?<version>\d+\.\d+\.\d+)
        sql     = "0.81.0"
      }
    }
  }
}
