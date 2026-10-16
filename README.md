# ghp

`ghp` is a standalone command line tool for managing multiple authenticated
accounts in the [GitHub CLI](https://cli.github.com/). It is independent of any
dotfiles repository and does not contain account names, tokens, or machine
specific paths.

## Requirements

- Bash 3.2 or later
- [GitHub CLI](https://cli.github.com/) (`gh`)
- [fzf](https://github.com/junegunn/fzf) for the interactive account picker
- `ssh-keygen` for `ghp signing-key`

## Install

Clone this repository and run:

```sh
./ghp install
```

This installs the command to `~/.local/bin/ghp`. To choose another directory:

```sh
./ghp install "$HOME/bin"
```

Make sure the install directory is on your `PATH`. Alternatively, copy the
single `ghp` executable to any directory on your `PATH`.

## Usage

```text
ghp                         Choose an account with fzf
ghp use <account>           Switch to an account
ghp list                    List authenticated accounts
ghp status                  Show account and authentication status
ghp login                   Authenticate another account
ghp signing-key [account]   Create or reuse an SSH signing key
ghp logout [account]        Log out an account (defaults to active)
ghp help                    Show help
```

For GitHub Enterprise, set the host for the command or your shell session:

```sh
GH_HOST=github.example.com ghp status
export GH_HOST=github.example.com
```

`ghp signing-key` creates an Ed25519 SSH key for the selected account under
`~/.ssh`, then prints instructions for adding the public key to GitHub. It
never uploads the key or prints the private key.

## Security and privacy

The repository contains only the command and generic documentation. `ghp`
delegates authentication and credential storage to `gh`, and reads the active
host from `GH_HOST` (default: `github.com`). Do not commit generated keys,
authentication data, or machine-specific configuration to this repository.

## License

MIT. See [LICENSE](LICENSE).
