#!/bin/bash

installService() {
    echo "Copying files..."
    cp huawei-soundcard-headphones-monitor.sh /usr/local/bin/
    cp huawei-soundcard-headphones-monitor.service /etc/systemd/system/

    echo "Setting rights..."
    chmod +x /usr/local/bin/huawei-soundcard-headphones-monitor.sh
    chmod +x /etc/systemd/system/huawei-soundcard-headphones-monitor.service

    echo "Setting up daemon..."
    systemctl daemon-reload
    systemctl enable huawei-soundcard-headphones-monitor
    systemctl restart huawei-soundcard-headphones-monitor

    echo "Complete!"
}

if command -v apt &>/dev/null; then
    echo "Using apt to install dependencies..."
    sudo apt update
    sudo apt install -y alsa-tools alsa-utils
    sudo installService
elif 
    command -v pacman &>/dev/null; then
    echo "Using pacman to install dependencies..."
    sudo pacman -Sy alsa-tools alsa-utils --noconfirm
    sudo installService
elif
    command -v eopkg &>/dev/null; then
    echo "Using eopkg to install dependencies..."
    sudo eopkg up
    sudo eopkg it alsa-tools alsa-utils -y
    sudo installService
elif 
    command -v dnf &>/dev/null; then
    echo "Using dnf to install dependencies..."
    sudo dnf install -y alsa-tools alsa-utils
    sudo installService
elif
    command -v apt-get &>/dev/null && grep -q "ID=altlinux" /etc/os-release; then
    echo "Using apt-get in AltLinux to install dependencies..."
    su -l -c "apt-get update && apt-get dist-upgrade && apt-get install alsa-tools alsa-utils && installService"
else
    echo "Neither apt, pacman, eopkg, nor dnf found. Cannot install dependencies."
    exit 1
fi
