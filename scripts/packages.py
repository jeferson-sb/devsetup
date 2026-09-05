import subprocess
from os_install import append_line_once, install_package_command, shell_run, is_installed


# --- Languages & runtimes ---

def mise():
    shell_run('curl https://mise.run | sh')
    append_line_once('eval "$($HOME/.local/bin/mise activate zsh)"', '~/.zshrc')


def programming_languages():
    if is_installed('mise'):
        # nodejs, python, ruby and rust ship as mise core tools and need no plugin
        shell_run('''
          mise plugin install elixir &&
          mise plugin install erlang &&
          mise plugin install lua
        ''')
    else:
        print("❌ mise is not installed!")


def rust_utils():
    shell_run(install_package_command('exa bat xclip'))


# --- Editors ---

def vim():
    shell_run(install_package_command('vim'))


def neovim():
    shell_run(install_package_command('neovim'))


def lunarvim():
    shell_run("LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/fc6873809934917b470bff1b072171879899a36b/utils/installer/install.sh)")


# --- Shell tooling ---

def git():
    shell_run(
        'curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash')


def pnpm():
    shell_run("curl -fsSL https://get.pnpm.io/install.sh | sh -")
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
