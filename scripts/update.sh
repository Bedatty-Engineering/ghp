#!/usr/bin/env bash
# Download the latest ghp and replace the installed executable atomically.

set -euo pipefail

readonly raw_url='https://raw.githubusercontent.com/Bedatty-Engineering/ghp/main/ghp'
install_dir="${GHP_INSTALL_DIR:-${1:-$HOME/.local/bin}}"
target="$install_dir/ghp"

if [[ ! -x "$target" ]]; then
  printf 'ghp updater: no executable found at %s\n' "$target" >&2
  printf 'Install ghp first with scripts/install.sh.\n' >&2
  exit 1
fi

command -v curl >/dev/null 2>&1 || {
  printf 'ghp updater: curl is required to download the latest version.\n' >&2
  exit 1
}

temporary_file=$(mktemp "$install_dir/.ghp-update.XXXXXX")
trap 'rm -f "$temporary_file"' EXIT
curl -fsSL "$raw_url" -o "$temporary_file"

if [[ ! -s "$temporary_file" ]] || ! head -n 1 "$temporary_file" | grep -q '^#!/usr/bin/env bash$'; then
  printf 'ghp updater: downloaded file is not a valid ghp executable.\n' >&2
  exit 1
fi

bash -n "$temporary_file" || {
  printf 'ghp updater: downloaded ghp failed the Bash syntax check.\n' >&2
  exit 1
}

if cmp -s "$target" "$temporary_file"; then
  printf 'ghp is already up to date.\n'
  exit 0
fi

chmod 755 "$temporary_file"
mv -f "$temporary_file" "$target"
printf 'Updated ghp at %s\n' "$target"
