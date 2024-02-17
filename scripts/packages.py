import subprocess
from os_install import install_package_command, shell_run, is_installed


def git():
    shell_run(
        'curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash')


def zsh():
    shell_run(
        'git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k')
    shell_run("echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc")


def vim():
    shell_run(install_package_command('vim'))


def neovim():
    shell_run(install_package_command('neovim'))


def lunarvim():
    shell_run("LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/fc6873809934917b470bff1b072171879899a36b/utils/installer/install.sh)")


def pnpm():
    shell_run("curl -fsSL https://get.pnpm.io/install.sh | sh -")
    shell_run('echo "export PNPM_HOME=$HOME/.local/share/pnpm" | sudo tee -a ~/.zshenv')


def rust_utils():
    shell_run(install_package_command('exa bat xclip'))


def sqlite():
    shell_run(install_package_command('sqlite'))


def asdf_git():
    shell_run(
        'git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.11.3')
    shell_run('echo ". $HOME/.asdf/asdf.sh" | sudo tee -a ~/.zshrc')


def asdf_pacman():
    shell_run(
        'git clone https://aur.archlinux.org/asdf-vm.git && cd asdf-vm && makepkg -si')
    shell_run('echo ". /opt/asdf-vm/asdf.sh" | sudo tee -a ~/.zshrc')


def programming_languages():
    if is_installed('asdf'):
        shell_run('''
          asdf plugin-add elixir
          && asdf plugin-add erlang
          && asdf plugin-add lua
          && asdf plugin-add nodejs
          && asdf plugin-add python
          && asdf plugin-add ruby
          && asdf plugin-add rust
        ''')
    else:
        print("❌ asdf is not installed!")


def homebrew():
    shell_run(
        'sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"')
    shell_run(
        '[ -d /home/linuxbrew/.linuxbrew ] && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)')


def others():
    shell_run(install_package_command('btop earlyoom'))
