 #!/usr/bin/env bash

PROJECT_ID="org.kde.plasma.clearclock"
INSTALL_LOCATION="~/.local/share/plasma/plasmoids/"

mkdir "${INSTALL_LOCATION}${PROJECT_ID}"
cp -R "package/." "${INSTALL_LOCATION}${PROJECT_ID}/"
