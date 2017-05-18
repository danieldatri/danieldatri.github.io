#!/bin/bash

if [ $TRAVIS_PULL_REQUEST == "true" ]; then
  echo "this is a pull request. No need to deploy site"
  exit 0
fi

set -e 

# build my site made with `jekyll'  to `_site' folder
jekyll build

SITE_PATH="danieldatri.github.io.master"

# cleanup my site online
rm -rf ../${SITE_PATH}

#clone `master' branch of the repository using encrypted GH_TOKEN for authentification
git clone https://${MY_TOKEN}@github.com/danieldatri/danieldatri.github.io ../${SITE_PATH}

# copy the site into _site folder to master
cp -R _site/* ../${SITE_PATH}

#Push changes to master 
cd ../${SITE_PATH}
git config user.email "daniel.datri@gmail.com"
git config user.name "Daniel Datri"
git add -A .
git commit -a -m "Commit from travis #$TRAVIS_BUILD_NUMBER"
git push --quiet origin master > /dev/null 2>&1