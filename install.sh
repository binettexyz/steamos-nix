#!/bin/bash

function installServices {
    if [$startNow == "n" ] || [$startNow == "no" ] || [$startNow == "N" ] || [$startNow == "N" ]
    then
        echo "Setting to read/write temporarily and copying systemd files.//"
        sudo steamos-readonly disable
        sudo cp -v systemd/nix-directory.service /etc/systemd/system/nix-directory.service
        sudo cp -v systemd/nix.mount /etc/systemd/system/nix.mount
        sudo cp -v systemd/ensure-symlinked-units-resolve.service /etc/systemd/system/ensure-symlinked-units-resolve.service
        sudo systemctl enable --now ensure-symlinked-units-resolve.service
        
        echo "Installing Nix..."
        sh <(curl -L https://nixos.org/nix/install) --daemon

        sudo systemctl enable --now ensure-symlinked-units-resolve.service
    fi
}

echo "Do you want to install Nix package manager on SteamDeck? [y/n]"
read startNow
