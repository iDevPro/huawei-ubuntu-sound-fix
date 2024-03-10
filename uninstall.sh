#!/bin/bash

uninstall_huawei_soundcard_service() {
    echo "Stopping daemon..."
    systemctl stop huawei-soundcard-headphones-monitor.service

    echo "Removing program..."
    rm /usr/local/bin/huawei-soundcard-headphones-monitor.sh

    echo "Removing service..."
    rm /etc/systemd/system/huawei-soundcard-headphones-monitor.service

    echo "Uninstalled. Goodbye 😿"
}

export -f uninstall_huawei_soundcard_service

if grep -q "ID=altlinux" /etc/os-release; then
    su -c "uninstall_huawei_soundcard_service"
else
    sudo uninstall_huawei_soundcard_service
fi