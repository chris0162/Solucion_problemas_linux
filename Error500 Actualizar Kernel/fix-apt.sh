#!/bin/bash
# Script para limpiar y actualizar apt cuando hay errores 500 en security.ubuntu.com

echo "=== Limpiando caché de apt ==="
sudo apt clean
sudo rm -rf /var/lib/apt/lists/*

echo "=== Forzando IPv4 y actualizando listas ==="
sudo apt -o Acquire::ForceIPv4=true -o Acquire::Retries=5 update

echo "=== Corrigiendo fuentes (https en lugar de http) ==="
sudo sed -i 's|http://security.ubuntu.com|https://security.ubuntu.com|g' /etc/apt/sources.list /etc/apt/sources.list.d/*.list 2>/dev/null

echo "=== Actualizando de nuevo ==="
sudo apt -o Acquire::ForceIPv4=true -o Acquire::Retries=5 update

echo "=== Reinstalando firmware si es necesario ==="
sudo apt install --reinstall -y linux-firmware

echo "=== Listo 🚀 ==="
