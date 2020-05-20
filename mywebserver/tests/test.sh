#!/bin/sh
#/ Usage: test.sh <pkg_ident>
#/
#/ Example: test.sh core/php/7.2.8/20181108151533
#/

set -euo pipefail

if [[ -z "${1:-}" ]]; then
  grep '^#/' < "${0}" | cut -c4-
	exit 1
fi

source "$(dirname "${0}")/../../ci/test_helpers.sh"

TEST_PKG_IDENT="${1}"
export TEST_PKG_IDENT

# Install BATS
hab pkg install core/bats --binlink

# Install dependencies for tests
hab pkg install core/busybox-static
hab pkg binlink core/busybox-static netstat
hab pkg install core/curl --binlink

# Install the package to be tested
hab pkg install "${TEST_PKG_IDENT}"

ci_ensure_supervisor_running
ci_load_service "${TEST_PKG_IDENT}" 10

# Run the tests
bats "$(dirname "${0}")/test.bats"

# Cleanup
hab svc unload "${TEST_PKG_IDENT}" || true
