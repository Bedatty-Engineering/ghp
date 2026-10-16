#!/usr/bin/env bash
# Remove the ghp executable from its installation directory.

set -euo pipefail

install_dir="${GHP_INSTALL_DIR:-${1:-$HOME/.local/bin}}"
target="$install_dir/ghp"

if [[ -f "$target" || -L "$target" ]]; then
  rm -f "$target"
  printf 'Removed %s\n' "$target"
else
  printf 'ghp is not installed at %s\n' "$target"
fi
