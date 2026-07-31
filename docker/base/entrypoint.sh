#!/bin/sh
set -e
set -x

if [ -f /run/secrets/postgresql_password ]; then
    export PGPASSWORD=$(cat /run/secrets/postgresql_password)
else
    echo "Error: El secreto postgresql_password no existe."
    exit 1
fi

# Asegurar permisos del filestore
chown -R odoo:odoo /var/lib/odoo/.local/share/Odoo/filestore
chmod -R 770 /var/lib/odoo/.local/share/Odoo/filestore

echo "========================================="
echo "Installing Python dependencies..."
echo "========================================="

find /mnt/extra-addons -name requirements.txt | while read req; do
    echo "Installing from: $req"

    pip3 install \
        --no-cache-dir \
        --break-system-packages \
        -r "$req"

    echo "Done."
done

echo "Cleaning Odoo assets..."
rm -rf /var/lib/odoo/.local/share/Odoo/web/assets/*

exec "$@"