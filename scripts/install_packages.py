from typing import List
from beaupy import select_multiple
from rich.console import Console


import os
import packages
from inspect import getmembers, isfunction

console = Console()


def list_functions(module):
    function_names = []
    for name, item in getmembers(module):
        if isfunction(item) and not name.startswith('_'):
            function_names.append(name)
    return function_names


def prompt_options(packages) -> List[str]:
    console.print("Please select which packages you would like to install:")
    return select_multiple(packages, tick_character='✔', ticked_indices=[0])


def init() -> any:
    working_dir = os.getcwd()
    packages_list = list_functions(packages)

    packages_chosen = prompt_options(packages_list)

    for package in packages_chosen:
        call_install = getattr(packages, package)
        call_install()


if __name__ == '__main__':
    init()
