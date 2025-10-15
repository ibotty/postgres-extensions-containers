variable "REGISTRY" {
  default = "ghcr.io"
}



variable "PG_VERSION" {
  default = "18"
}

variable "PG_DUCKDB_VERSION" {
  default = ""
}

variable "DISTROS" {
  default = ["bookworm", "trixie"]
}

variable "DISTRO" {
  default = "bookworm"
}

variable "BRANCH_NAME" {
  default = ""
}

target "pg_duckdb" {
  dockerfile = "../Dockerfile"
  tags = [
    "${REGISTRY}/pg_duckdb:${PG_VERSION}-${PG_DUCKDB_VERSION}-${formatdate("YYYYMMDDHHMM", timestamp())}-${DISTRO}",
    "${REGISTRY}/pg_duckdb:${PG_VERSION}-${PG_DUCKDB_VERSION}-${DISTRO}"
  ]
  args = {
    PG_VERSION = PG_VERSION
    DISTRO = DISTRO
  }
}

target "pg_duckdb-feature" {
  dockerfile = "../Dockerfile"
  tags = [
    "${REGISTRY}/pg_duckdb:${PG_VERSION}-${PG_DUCKDB_VERSION}-${BRANCH_NAME}-${DISTRO}"
  ]
  args = {
    PG_VERSION = PG_VERSION
    DISTRO = DISTRO
  }
}

# Matrix builds for PG 18 with multiple distros
group "pg_duckdb-all" {
  targets = [
    "pg_duckdb-18-bookworm",
    "pg_duckdb-18-trixie"
  ]
}

target "pg_duckdb-18-bookworm" {
  inherits = ["pg_duckdb"]
  args = {
    PG_VERSION = "18"
    DISTRO = "bookworm"
  }
}

target "pg_duckdb-18-trixie" {
  inherits = ["pg_duckdb"]
  args = {
    PG_VERSION = "18"
    DISTRO = "trixie"
  }
}
