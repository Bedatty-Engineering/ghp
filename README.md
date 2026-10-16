<table>
<tr>
<td><img src="https://github.com/Bedatty-Engineering.png" alt="Bedatty Engineering" width="72" /></td>
<td><h1>ghp</h1><p>A GitHub CLI account switcher with interactive selection and SSH signing key setup.</p></td>
</tr>
</table>

`ghp` is a small command line account manager for [GitHub CLI](https://cli.github.com/).
Use it to switch between accounts already authenticated with `gh`, add another
account, or create an SSH signing key for an account.

## Contents

- [Features](#features)
- [Requirements](#requirements)
- [Install](#install)
- [Usage](#usage)
- [GitHub Enterprise](#github-enterprise)
- [SSH signing keys](#ssh-signing-keys)
- [Privacy](#privacy)
- [License](#license)

## Features

- Switch accounts directly or choose one from an interactive `fzf` menu.
- List accounts and inspect the active account's authentication status.
- Start or end a GitHub CLI login session.
- Create or reuse an Ed25519 SSH key for GitHub commit signing.
- Target GitHub Enterprise with `GH_HOST`.
- Install as a single executable; no build step or dotfiles repository required.

## Requirements

| Dependency | Needed for |
| --- | --- |
| Bash 3.2 or later | Running `ghp` (available by default on macOS and Linux) |
| [GitHub CLI](https://cli.github.com/) | Account and authentication commands |
| [fzf](https://github.com/junegunn/fzf) | Interactive account picker |
| `ssh-keygen` | `ghp signing-key` |
| `curl` | Remote install and uninstall scripts |

Authenticate accounts with `gh auth login` before switching between them.

## Install

Install the latest version directly:

```sh
curl -fsSL https://raw.githubusercontent.com/Bedatty-Engineering/ghp/main/scripts/install.sh | bash
```

To choose another installation directory, set `GHP_INSTALL_DIR`:

```sh
curl -fsSL https://raw.githubusercontent.com/Bedatty-Engineering/ghp/main/scripts/install.sh | GHP_INSTALL_DIR="$HOME/bin" bash
```

You can also clone the repository and install from the checkout:

```sh
git clone https://github.com/Bedatty-Engineering/ghp.git
cd ghp
./scripts/install.sh
```

The installer copies `ghp` to `~/.local/bin`. Add that directory to `PATH` if
it is not already there. To install somewhere else, pass a destination:

```sh
./scripts/install.sh "$HOME/bin"
```

Remove the default installation from a checkout with:

```sh
./scripts/uninstall.sh
```

For a custom directory, pass the path or set `GHP_INSTALL_DIR`. The remote
uninstaller is also available:

```sh
curl -fsSL https://raw.githubusercontent.com/Bedatty-Engineering/ghp/main/scripts/uninstall.sh | bash
```

You can also run `./ghp` directly from a checkout without installing it.

## Usage

```sh
ghp                          # Open the interactive menu
ghp use <account>            # Switch to an account
ghp list                     # List authenticated accounts
ghp status                   # Show the active account and auth status
ghp login                    # Authenticate another account
ghp logout [account]         # Log out (defaults to the active account)
ghp signing-key [account]    # Create or reuse an SSH signing key
ghp help                     # Show all commands
```

The interactive menu needs `fzf`. All other commands work without it.

## GitHub Enterprise

Set `GH_HOST` for a single command or export it for the shell session:

```sh
GH_HOST=github.example.com ghp status
export GH_HOST=github.example.com
```

The default host is `github.com`.

## SSH signing keys

`ghp signing-key [account]` creates a new Ed25519 key under `~/.ssh` or updates
the comment on an existing generated key for that host and account. The command
prints the steps to add the public key to GitHub as a **Signing Key**. It does
not upload keys; keep the private key file private. On macOS, use the printed
`pbcopy` command to copy the public key. On Linux, display it with
`cat ~/.ssh/<public-key-file>` and copy the output.

## Privacy

The repository contains no account names, authentication data, or
machine-specific paths. Authentication stays in GitHub CLI. Generated signing
keys stay on the local machine.

## License

MIT. See [LICENSE](LICENSE).
