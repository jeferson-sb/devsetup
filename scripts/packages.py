import os
import subprocess
from os_install import append_line_once, install_package_command, shell_run, is_installed

MISE_BIN = os.path.expanduser('~/.local/bin/mise')


def _warn_if_dotfiles_missing():
    # append_line_once writes through a repo-managed dotfile; if `make
    # dotfiles` hasn't run yet, that's still a plain file and gets replaced
    # (backed up as .old) the first time dotfiles *does* run, silently
    # dropping whatever line we just appended.
    if not os.path.exists(os.path.expanduser('~/.dotfiles')):
        print("⚠️  ~/.dotfiles not found yet — run `make dotfiles` before "
              "(or again after) this, or the line just appended may get "
              "overwritten.")


# --- Languages & runtimes ---

def mise():
    shell_run('curl https://mise.run | sh')
    _warn_if_dotfiles_missing()
    append_line_once('eval "$($HOME/.local/bin/mise activate zsh)"', '~/.zshrc')


def programming_languages():
    if not (is_installed('mise') or os.path.exists(MISE_BIN)):
        raise RuntimeError("mise is not installed")

    # nodejs, python, ruby and rust ship as mise core tools and need no plugin
    shell_run('''
      mise plugin install elixir &&
      mise plugin install erlang &&
      mise plugin install lua
    ''')


def rust_utils():
    shell_run(install_package_command('exa bat xclip'))


# --- Editors ---

def vim():
    shell_run(install_package_command('vim'))


def neovim():
    shell_run(install_package_command('neovim'))


def lazyvim():
    # Clone to a scratch dir and merge without clobbering, since `make dotfiles`
    # may have already symlinked this repo's own files (e.g. the colorscheme
    # plugin) into ~/.config/nvim, which would make a direct `git clone` there fail.
    shell_run('''
      tmp=$(mktemp -d) &&
      git clone https://github.com/LazyVim/starter "$tmp" &&
      rm -rf "$tmp/.git" &&
      mkdir -p ~/.config/nvim &&
      cp -rn "$tmp/." ~/.config/nvim/ &&
      rm -rf "$tmp"
    ''')


# --- Shell tooling ---

def git():
    shell_run(
        'curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash')


def pnpm():
    shell_run("curl -fsSL https://get.pnpm.io/install.sh | sh -")
    _warn_if_dotfiles_missing()
    append_line_once('export PNPM_HOME=$HOME/.local/share/pnpm', '~/.zshenv')


def homebrew():
    shell_run(
        'sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"')
    shell_run(
        '[ -d /home/linuxbrew/.linuxbrew ] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)')


# --- Misc ---

def sqlite():
    shell_run(install_package_command('sqlite'))


def others():
    shell_run(install_package_command('btop earlyoom'))
