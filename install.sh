#!/usr/bin/env bash

export DISK=$1

nix-channel --add https://nixos.org/channels/nixos-unstable nixos
nix-channel --update

parted "${DISK}" -sf -- mklabel gpt
parted "${DISK}" -- mkpart ESP fat32 1MB 1GB
parted "${DISK}" -- set 1 esp on
parted "${DISK}" -- mkpart primary linux-swap 1GB 17GB
parted "${DISK}" -- mkpart primary 17GB 49GB
parted "${DISK}" -- mkpart primary 49GB 100%

mkfs.fat -F32 -n boot "${DISK}1"
mkswap -L swap "${DISK}2"
mkfs.ext4 -F -L root "${DISK}3"
mkfs.ext4 -F -L nixstore "${DISK}4"

mount /dev/disk/by-label/root /mnt
mkdir -p /mnt/boot /mnt/nix /mnt/etc
mount /dev/disk/by-label/boot /mnt/boot
mount /dev/disk/by-label/nixstore /mnt/nix
swapon "${DISK}2"

nix-shell -p git --run 'git clone --depth=1 https://github.com/FabLab-Altmuehlfranken/NixOS-Workstation.git /mnt/etc/nixos'

nixos-install --no-root-passwd
reboot
