#!/usr/bin/env sh

cd "${GITHUB_WORKSPACE}"

# Python Dependencies
pip --no-cache-dir install git+https://github.com/linkchecker/linkchecker@v10.2.1#egg=linkchecker
# NodeJS Dependencies
npm ci

chmod +x build.sh

npm run build
