# NixOS Configuration for Capybara (Proxmox VM)

## Structure

- `flake.nix`: Entry point
- `hosts/capybara/`: Host-specific config
- `modules/`: Modular system settings

## Key Features

- **Filesystem**: Btrfs with `zstd` compression, subvolumes (`@`, `@home`, `@nix`, `@log`).
- **Network**: `systemd-networkd` with DHCP on `eth0` (update if Proxmox uses `ens18`).
- **Access**: `advik` user with SSH key, `sudo`, and `docker` permissions. No root password.
- **Security**: Fail2ban, SSH password auth disabled, Tailscale firewall rules.
- **Auto-Updates**: Monthly update cycle (simulating a 1-month threshold).
- **Tooling**: Nushell, Starship, Zoxide, Docker, Kind, etc.

## Deployment Steps

1. **Prepare VM**: Create a Proxmox VM with EFI and a single disk.
2. **Boot NixOS ISO**: Boot from the latest NixOS minimal ISO.
3. **Partition Disk**:

   ```bash
   # Example for /dev/vda
   parted /dev/vda -- mklabel gpt
   parted /dev/vda -- mkpart ESP fat32 1MB 512MB
   parted /dev/vda -- set 1 esp on
   parted /dev/vda -- mkpart primary btrfs 512MB 100%

   mkfs.vfat -n boot /dev/vda1
   mkfs.btrfs -L nixos /dev/vda2

   # Create subvolumes
   mount /dev/vda2 /mnt
   btrfs subvolume create /mnt/@
   btrfs subvolume create /mnt/@home
   btrfs subvolume create /mnt/@nix
   btrfs subvolume create /mnt/@log
   umount /mnt

   # Mount subvolumes
   mount -o subvol=@,compress=zstd,noatime /dev/vda2 /mnt
   mkdir -p /mnt/{boot,home,nix,var/log}
   mount /dev/vda1 /mnt/boot
   mount -o subvol=@home,compress=zstd,noatime /dev/vda2 /mnt/home
   mount -o subvol=@nix,compress=zstd,noatime /dev/vda2 /mnt/nix
   mount -o subvol=@log,compress=zstd,noatime /dev/vda2 /mnt/var/log
   ```

4. **Install**:
   ```bash
   nixos-install --flake github:your-username/your-repo#capybara
   ```

## Assumptions

- Primary network interface is `eth0`.
- Partitions are labeled `boot` and `nixos`.
- You will update the `flake` URL in `modules/updates.nix` once hosted.
- age-encrypted secrets are managed externally or manually for now.
