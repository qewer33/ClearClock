  #!/usr/bin/env bash

PACKAGE_NAME="ClearClock"

tar -czvf "${PACKAGE_NAME}.tar.gz" -C "package/" .
git add .
git commit -m "Update package"
git push
