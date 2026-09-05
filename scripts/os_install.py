import os
import platform
import re
import subprocess


def install_package_command(package):
    is_arch = re.search(r'manjaro|arch', platform.platform(), re.I)
    is_fedora = re.search(r'fc39', platform.platform(), re.I)

    if is_arch:
        return f'sudo pacman -Sy {package} --noconfirm > /dev/null'
    if is_fedora:
        return f'dnf install {package} -y > /dev/null'

    return f'sudo apt-get install {package} -y > /dev/null'


def shell_run(command):
    subprocess.run(command, shell=True, check=True)


def is_installed(pckg):
    # `> /dev/null 2>&1` (not bash-only `&>`) since shell=True runs /bin/sh,
    # which is dash (not bash) on Debian/Ubuntu.
    code = subprocess.run(
        f"command -v {pckg} > /dev/null 2>&1", shell=True).returncode

    return code == 0


def append_line_once(line, path):
    """Append `line` to the file at `path` unless it's already there."""
    path = os.path.expanduser(path)

    if os.path.exists(path):
        with open(path) as f:
            if line in f.read():
                return

    with open(path, 'a') as f:
        f.write(line + '\n')
