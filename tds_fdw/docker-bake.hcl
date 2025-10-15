variable "REGISTRY" {
  default = "ghcr.io"
}



variable "PG_VERSION" {
  default = "18"
}

variable "TDS_FDW_VERSION" {
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

target "tds_fdw" {
  dockerfile = "Dockerfile"
  tags = [
    "${REGISTRY}/tds_fdw:${PG_VERSION}-${formatdate("YYYYMMDDHHMM", timestamp())}-${DISTRO}",
    "${REGISTRY}/tds_fdw:${PG_VERSION}-${DISTRO}"
  ]
  args = {
    PG_VERSION = PG_VERSION
    DISTRO = DISTRO
  }
}

target "tds_fdw-feature" {
  dockerfile = "Dockerfile"
  tags = [
    "${REGISTRY}/tds_fdw:${PG_VERSION}-${BRANCH_NAME}-${DISTRO}"
  ]
  args = {
    PG_VERSION = PG_VERSION
    DISTRO = DISTRO
  }
}

# Matrix builds for PG 18 with multiple distros
group "tds_fdw-all" {
  targets = [
    "tds_fdw-18-bookworm",
    "tds_fdw-18-trixie"
  ]
}

target "tds_fdw-18-bookworm" {
  inherits = ["tds_fdw"]
  args = {
    PG_VERSION = "18"
    DISTRO = "bookworm"
  }
}

target "tds_fdw-18-trixie" {
  inherits = ["tds_fdw"]
  args = {
    PG_VERSION = "18"
    DISTRO = "trixie"
  }
}
