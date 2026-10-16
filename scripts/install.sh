#!/usr/bin/env bash
# Install ghp from this checkout or download the latest main version.

set -euo pipefail

readonly raw_base='https://raw.githubusercontent.com/Bedatty-Engineering/ghp/main'
install_dir="${GHP_INSTALL_DIR:-${1:-$HOME/.local/bin}}"
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]:-}")" 2>/dev/null && pwd || true)
source_file="$script_dir/../ghp"
temporary_file=$(mktemp)
trap 'rm -f "$temporary_file"' EXIT

if [[ -f "$source_file" ]]; then
  cp "$source_file" "$temporary_file"
else
  command -v curl >/dev/null 2>&1 || {
    printf 'ghp installer: curl is required to download ghp.\n' >&2
    exit 1
  }
  curl -fsSL "$raw_base/ghp" -o "$temporary_file"
fi

if [[ ! -s "$temporary_file" ]] || ! head -n 1 "$temporary_file" | grep -q '^#!/usr/bin/env bash$'; then
  printf 'ghp installer: downloaded file is not a valid ghp executable.\n' >&2
  exit 1
fi

mkdir -p "$install_dir"
cp "$temporary_file" "$install_dir/ghp"
chmod 755 "$install_dir/ghp"
printf 'Installed ghp to %s/ghp\n' "$install_dir"
case ":${PATH}:" in
  *":${install_dir}:"*) ;;
  *) printf 'Add this directory to PATH: %s\n' "$install_dir" ;;
esac
