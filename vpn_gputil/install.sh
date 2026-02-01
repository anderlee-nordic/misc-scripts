#!/usr/bin/env bash
set -euo pipefail

# --------------- CONFIG --------------
PY_SCRIPT="vpn_gptray"
BASH_SCRIPT="vpn_gp"
INSTALL_DIR="/opt/vpn_gputil"
PY_LINK="/usr/local/bin/${PY_SCRIPT}"
BASH_LINK="/usr/local/bin/${BASH_SCRIPT}"
# --------------------------------------

# Check GlobalProtect CLI exists in PATH
if ! which globalprotect >/dev/null 2>&1; then
  echo "Error: globalprotect not found in PATH. Install GlobalProtect CLI first." >&2
  exit 1
fi

if [[ $EUID -ne 0 ]]; then
  echo "Please run as root: sudo $0"
  exit 1
fi

mkdir -p "${INSTALL_DIR}"

# Copy and preserve permissions/timestamps
install -p "${PY_SCRIPT}" "${INSTALL_DIR}/"
install -p "${BASH_SCRIPT}" "${INSTALL_DIR}/"
ln -sfn "${INSTALL_DIR}/${PY_SCRIPT}" "${PY_LINK}"
ln -sfn "${INSTALL_DIR}/${BASH_SCRIPT}" "${BASH_LINK}"
echo "${BASH_SCRIPT} and ${PY_SCRIPT} have been installed to: ${INSTALL_DIR}"
