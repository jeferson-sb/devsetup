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

    failed = []
    for package in packages_chosen:
        call_install = getattr(packages, package)
        try:
            call_install()
            console.print(f"[green]✔ {package} installed[/green]")
        except Exception as e:
            console.print(f"[red]✘ {package} failed: {e}[/red]")
            failed.append(package)

    if failed:
        console.print(
            f"\n[yellow]Finished with failures:[/yellow] {', '.join(failed)}")
    else:
        console.print("\n[green]All selected packages installed successfully.[/green]")


if __name__ == '__main__':
    init()
