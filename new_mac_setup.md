# New Mac Setup

Setup checklist for a new Apple Silicon Mac.


## 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

- [x] Homebrew installed

## 2. Create the work directory and clone the bin repository

Clone via HTTPS:

```bash
mkdir -p ~/work
git clone https://github.com/cgl/bin.git ~/work/bin
```

If SSH authentication is already configured, this also works:

```bash
git clone git@github.com:cgl/bin.git ~/work/bin
```

- [x] `~/work` created
- [x] `bin` repository cloned

## 3. Configure Bash

Start Bash for the current terminal:

```bash
bash
```

Link the Bash configuration:

```bash
ln -s ~/work/bin/.bash_profile ~/.bash_profile
ln -s ~/work/bin/.bashrc ~/.bashrc
```

If a destination already exists, inspect it before replacing it:

```bash
ls -la ~/.bash_profile ~/.bashrc
```

Change the default login shell:

```bash
chsh -s /bin/bash
```

Fully sign out and back in, or restart Terminal, then verify:

```bash
echo "$SHELL"
ps -p $$ -o comm=
```

Expected login shell:

```text
/bin/bash
```

- [x] Bash configuration linked
- [x] `chsh -s /bin/bash` run
- [ ] Sign out and back in
- [ ] Verify that the default login shell is Bash

### Bash history

The repository configuration appends and synchronizes history between open
shells. Verify that history is being saved:

```bash
echo "$HISTFILE"
history -a
ls -la ~/.bash_history
```

Recommended settings:

```bash
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTCONTROL=ignoreboth
shopt -s histappend
```

- [ ] Confirm that `~/.bash_history` is writable
- [ ] Align `HISTFILESIZE` with `HISTSIZE`

### Optional: install a newer Bash

macOS includes an older Bash release. To use Homebrew Bash:

```bash
brew install bash
```

Add `/opt/homebrew/bin/bash` to `/etc/shells`, then select it:

```bash
echo /opt/homebrew/bin/bash | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/bash
```

After signing out and back in:

```bash
bash --version
echo "$SHELL"
```

- [ ] Decide whether to use macOS Bash or Homebrew Bash

## 4. Install Codex

```bash
brew install --cask codex
```

Verify and sign in:

```bash
codex --version
codex
```

- [x] Codex installed
- [x] Codex launched

## 5. Install core tools

```bash
brew install git git-delta ripgrep
brew install --cask iterm2 maccy emacs
```

Verify:

```bash
git --version
delta --version
rg --version
emacs --version
```

- [x] Maccy installed
- [x] ripgrep installed
- [ ] Git Delta installed
- [ ] iTerm2 installed
- [ ] Emacs installed

## 6. Link personal configuration

```bash
ln -s ~/work/bin/.emacs ~/.emacs
ln -s ~/work/bin/.gitconfig ~/.gitconfig
ln -s ~/work/bin/ec /usr/local/ec
```

Verify:

```bash
ls -la ~/.emacs ~/.gitconfig
command -v ec
git config --list --show-origin
```

- [x] Emacs configuration linked
- [x] Git configuration linked
- [ ] `ec` linked and available on `PATH`

The `ec` wrapper opens a GUI Emacs frame and waits for the edit to finish,
which allows Git commands such as `git add --patch` to work. Use `ec -t` for a
terminal frame.

## 7. Fix migrated paths

Before relying on the existing configuration, review it for paths copied from
the previous Mac:

```bash
rg '/usr/local|cagilsonmez|node@8|python@3\.8|openssl@1\.1' \
  ~/work/bin/.bash_profile ~/work/bin/.bashrc ~/work/bin/.gitconfig
```

Items currently requiring attention:

- `/usr/local/...` paths are Intel Homebrew paths; Apple Silicon Homebrew uses
  `/opt/homebrew/...`.
- Git signing and template paths refer to `/Users/cagilsonmez/...`.
- The shell configuration refers to old versions of Node, Python and OpenSSL.
- `PATH="~/.npm-global/bin:$PATH"` should use
  `PATH="$HOME/.npm-global/bin:$PATH"`.

- [ ] Replace obsolete `/usr/local` Homebrew paths
- [ ] Update old home-directory paths in `.gitconfig`
- [ ] Remove or update version-specific Node, Python and OpenSSL paths
- [ ] Correct the quoted npm-global path

## 8. Configure Git and SSH

Confirm identity:

```bash
git config --global user.name
git config --global user.email
```

Create a new SSH key if required:

```bash
ssh-keygen -t ed25519 -C "your-email@example.com"
eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519
```

Test GitHub authentication after adding the public key to GitHub:

```bash
ssh -T git@github.com
```

If commit signing is enabled, update the signing key and allowed-signers paths
in `~/.gitconfig`.

- [ ] Verify Git name and email
- [ ] Configure GitHub SSH authentication
- [ ] Update and test commit signing
- [ ] Confirm that `git delta` works as the configured pager

## 9. Install Python with pyenv

```bash
brew install pyenv
```

Restart Bash, then install the desired Python release:

```bash
pyenv install --list
pyenv install <version>
pyenv global <version>
```

Verify:

```bash
pyenv --version
python --version
which python
```

- [ ] pyenv installed
- [ ] Python installed through pyenv
- [ ] Default Python verified

## 10. Verify the final setup

```bash
echo "$SHELL"
uname -m
brew --prefix
brew doctor
git --version
codex --version
emacs --version
python --version
```

- [ ] Bash is the default login shell
- [ ] Bash history persists after closing and reopening Terminal
- [ ] Homebrew reports no critical issues
- [ ] Git and SSH authentication work
- [ ] Codex launches and is authenticated
- [ ] Emacs launches with the linked configuration
- [ ] Python resolves to the pyenv-managed version

## Setup discovered from shell history

The initial setup history recorded these actions:

```bash
mkdir work
cd work
git clone git@github.com:cgl/bin.git
brew install --cask codex
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
codex
bash
```

The Bash history file was empty when this document was created. The commands
above came from the Zsh history and were reconciled with the current installed
tools and configuration links.
