#!/usr/bin/env bash

function copy_file() {
    rm -rf ./home/.mozilla/firefox/l5l2jvmz.default/$1
    cp -r ~/.mozilla/firefox/l5l2jvmz.default/$1 ./home/.mozilla/firefox/l5l2jvmz.default/$1
}

copy_file addons.json
copy_file addonStartup.json.lz4
copy_file broadcast-listeners.json
copy_file cert9.db
copy_file cert_override.txt
copy_file compatibility.ini
copy_file containers.json
copy_file content-prefs.sqlite
copy_file cookies.sqlite
copy_file datareporting
copy_file enumerate_devices.txt
copy_file extension-preferences.json
copy_file extensions
copy_file extension-settings.json
copy_file extensions.json
copy_file favicons.sqlite
copy_file formhistory.sqlite
copy_file handlers.json
copy_file key4.db
copy_file permissions.sqlite
copy_file pkcs11.txt
copy_file places.sqlite
copy_file prefs.js
copy_file protections.sqlite
copy_file search.json.mozlz4
copy_file sessionCheckpoints.json
copy_file settings
copy_file shield-preference-experiments.json
copy_file storage
copy_file storage.sqlite
copy_file storage-sync-v2.sqlite
copy_file storage-sync-v2.sqlite-shm
copy_file storage-sync-v2.sqlite-wal
copy_file times.json
copy_file webappsstore.sqlite
copy_file xulstore.json

