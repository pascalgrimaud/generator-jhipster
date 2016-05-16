#!/bin/bash
set -ev
#-------------------------------------------------------------------------------
# Force no insight
#-------------------------------------------------------------------------------
mkdir -p "$HOME"/.config/configstore/
mv "$JHIPSTER_TRAVIS"/configstore/*.json "$HOME"/.config/configstore/

#-------------------------------------------------------------------------------
# Generate the project with yo jhipster
#-------------------------------------------------------------------------------
mkdir -p "$HOME"/app
mv -f "$JHIPSTER_SAMPLES"/"$JHIPSTER"/.yo-rc.json "$HOME"/app/
cd "$HOME"/app

rm -Rf "$HOME"/app/node_modules/.bin/*grunt*
rm -Rf "$HOME"/app/node_modules/*grunt*

npm link generator-jhipster
yo jhipster --force --no-insight
ls -al "$HOME"/app
ls -al "$HOME"/app/node_modules/
ls -al "$HOME"/app/node_modules/generator-jhipster/
ls -al "$HOME"/app/node_modules/generator-jhipster/generators/
ls -al "$HOME"/app/node_modules/generator-jhipster/generators/entity/
