import platform
import re
import subprocess


def install_package_command(package):
    is_manjaro = re.search(r'manjaro', platform.platform(), re.I)

    if is_manjaro:
        return f'sudo pacman -Sy {package} --noconfirm > /dev/null'

    return f'sudo apt-get install {package} -y > /dev/null'


def shell_run(command):
    subprocess.run(command, shell=True, check=True)


def is_installed(pckg):
    code = subprocess.run(
        f"command -v {pckg} &> /dev/null", shell=True).returncode

    return bool(code)
