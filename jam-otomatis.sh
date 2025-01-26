#!/bin/bash

# Fungsi untuk memeriksa koneksi internet
check_internet() {
    ping -c 1 8.8.8.8 > /dev/null 2>&1
    return $?
}

# Fungsi untuk menyinkronkan waktu menggunakan date dan server NTP
set_time_jakarta() {
    # Mendapatkan waktu dari server NTP menggunakan `ntpdate`
    ntpdate -s time.google.com

    # Mengatur zona waktu Jakarta (UTC+7)
    ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
    echo "Waktu berhasil disinkronkan dengan Jakarta"
}

# Main loop untuk menunggu koneksi internet
while true; do
    if check_internet; then
        echo "Koneksi internet terdeteksi, menyinkronkan waktu Jakarta..."
        set_time_jakarta
        break
    else
        echo "Menunggu koneksi internet..."
        sleep 5
    fi
done
