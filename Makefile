.PHONY: about

.DEFAULT_GOAL := help

owner := "Jeferson"
version := "2.0.0"
username := $(USER)

about:
	@echo "Project created by ${owner}"
	@echo "Version ${version}"
install/ubuntu:
	./scripts/ubuntu/setup-ubuntu.sh
install/arch:
	./scripts/arch/setup-arch.sh
install-apps/arch:
	./scripts/arch/install_apps.sh
dotfiles:
	./scripts/install_dotfiles.sh
help: 
	@printf "make dotfiles - configure dotfiles for your user \n"
	@printf "make install/<distro> - updates and install development tools for your system of choice \n"