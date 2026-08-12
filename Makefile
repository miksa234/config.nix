HOSTNAME := $(shell hostname)
USER     := $(shell whoami)

.PHONY: gc clean hm os os_rollback vm darwin darwin_rollback

gc:
	sudo nix-collect-garbage --delete-older-than 1d
	nix-collect-garbage --delete-older-than 7d

clean:
	rm -rf ./result
	rm -f *.qcow2

hm:
	home-manager switch -b backup --flake ./#$(USER) --show-trace

os:
	sudo nixos-rebuild switch --flake ./#$(HOSTNAME) --show-trace

os_rollback:
	sudo nixos-rebuild switch --flake --rollback

vm:
	sudo nixos-build build-vm --flake .#$(HOST) --show-trace

darwin:
	sudo darwin-rebuild switch --flake ./#$(HOSTNAME) --show-trace

darwin_rollback:
	sudo darwin-rebuild switch --flake --rollback
