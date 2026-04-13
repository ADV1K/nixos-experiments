## Setup SSH

```bash
mkdir -p ~/.ssh
curl https://github.com/adv1k.keys >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```

## Installation

```bash
export NIX_CONFIG="experimental-features = nix-command flakes"

git clone https://github.com/adv1k/nixos-experiments
cd nixos-experiments

# apply disk layout
nix run github:nix-community/disko -- \
  --flake .#capybara \
  --mode disko

# install system
nixos-install --flake .#capybara
```
