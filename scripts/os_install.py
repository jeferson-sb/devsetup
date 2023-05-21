import platform
import re


def install_package_command(package):
    is_manjaro = re.search(r'manjaro', platform.platform(), re.I)

    if is_manjaro:
        return f'sudo pacman -Sy {package} --noconfirm > /dev/null'

    return f'sudo apt-get install {package} -y > /dev/null'
