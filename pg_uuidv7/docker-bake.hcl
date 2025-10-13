variable "REGISTRY" {
  default = "ghcr.io"
}



variable "PG_VERSION" {
  default = "18"
}

variable "PG_UUIDV7_VERSION" {
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

target "pg_uuidv7" {
  dockerfile = "../Dockerfile"
  tags = [
    "${REGISTRY}/pg_uuidv7:${PG_VERSION}-${PG_UUIDV7_VERSION}-${formatdate("YYYYMMDDHHMM", timestamp())}-${DISTRO}",
    "${REGISTRY}/pg_uuidv7:${PG_VERSION}-${PG_UUIDV7_VERSION}-${DISTRO}"
  ]
  args = {
    PG_VERSION = PG_VERSION
    DISTRO = DISTRO
  }
}

target "pg_uuidv7-feature" {
  dockerfile = "../Dockerfile"
  tags = [
    "${REGISTRY}/pg_uuidv7:${PG_VERSION}-${PG_UUIDV7_VERSION}-${BRANCH_NAME}-${DISTRO}"
  ]
  args = {
    PG_VERSION = PG_VERSION
    DISTRO = DISTRO
  }
}

# Matrix builds for PG 18 with multiple distros
group "pg_uuidv7-all" {
  targets = [
    "pg_uuidv7-18-bookworm",
    "pg_uuidv7-18-trixie"
  ]
}

target "pg_uuidv7-18-bookworm" {
  inherits = ["pg_uuidv7"]
  args = {
    PG_VERSION = "18"
    DISTRO = "bookworm"
  }
}

target "pg_uuidv7-18-trixie" {
  inherits = ["pg_uuidv7"]
  args = {
    PG_VERSION = "18"
    DISTRO = "trixie"
  }
}
