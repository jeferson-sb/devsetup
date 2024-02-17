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
    code = subprocess.run(
        f"command -v {pckg} &> /dev/null", shell=True).returncode

    return bool(code)
