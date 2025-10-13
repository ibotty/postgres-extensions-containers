variable "REGISTRY" {
  default = "ghcr.io"
}



variable "PG_VERSION" {
  default = "18"
}

variable "FIRST_LAST_AGG_VERSION" {
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

target "first_last_agg" {
  dockerfile = "../Dockerfile"
  tags = [
    "${REGISTRY}/first_last_agg:${PG_VERSION}-${FIRST_LAST_AGG_VERSION}-${formatdate("YYYYMMDDHHMM", timestamp())}-${DISTRO}",
    "${REGISTRY}/first_last_agg:${PG_VERSION}-${FIRST_LAST_AGG_VERSION}-${DISTRO}"
  ]
  args = {
    PG_VERSION = PG_VERSION
    DISTRO = DISTRO
  }
}

target "first_last_agg-feature" {
  dockerfile = "../Dockerfile"
  tags = [
    "${REGISTRY}/first_last_agg:${PG_VERSION}-${FIRST_LAST_AGG_VERSION}-${BRANCH_NAME}-${DISTRO}"
  ]
  args = {
    PG_VERSION = PG_VERSION
    DISTRO = DISTRO
  }
}

# Matrix builds for PG 18 with multiple distros
group "first_last_agg-all" {
  targets = [
    "first_last_agg-18-bookworm",
    "first_last_agg-18-trixie"
  ]
}

target "first_last_agg-18-bookworm" {
  inherits = ["first_last_agg"]
  args = {
    PG_VERSION = "18"
    DISTRO = "bookworm"
  }
}

target "first_last_agg-18-trixie" {
  inherits = ["first_last_agg"]
  args = {
    PG_VERSION = "18"
    DISTRO = "trixie"
  }
}
