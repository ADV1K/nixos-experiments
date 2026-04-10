.PHONY: build-iso clean help

# Default target
help:
	@echo "NixOS ISO Builder for Capybara"
	@echo "------------------------------"
	@echo "make build-iso  - Build the automated installer ISO"
	@echo "make clean      - Remove build artifacts"

build-iso:
	nix build .#nixosConfigurations.installer.config.system.build.isoImage --extra-experimental-features flakes --extra-experimental-features nix-command
	@echo "------------------------------"
	@echo "ISO Build Complete!"
	@echo "Path: $$(readlink -f result/iso/*.iso)"
	@echo "------------------------------"
	@echo "Instructions: Upload this ISO to Proxmox, boot a VM with a /dev/vda disk, and it will auto-install."

clean:
	rm -rf result
