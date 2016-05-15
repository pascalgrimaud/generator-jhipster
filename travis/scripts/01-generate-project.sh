#!/bin/bash

#-------------------------------------------------------------------------------
# Force no insight
#-------------------------------------------------------------------------------
mkdir -p "$HOME"/.config/configstore/
mv "$JHIPSTER_TRAVIS"/configstore/*.json "$HOME"/.config/configstore/

#-------------------------------------------------------------------------------
# Generate the project with yo jhipster
#-------------------------------------------------------------------------------
mv -f "$JHIPSTER_SAMPLES"/"$JHIPSTER" "$HOME"/
cd "$HOME"/"$JHIPSTER"

rm -Rf "$HOME"/"$JHIPSTER"/node_modules/.bin/*grunt*
rm -Rf "$HOME"/"$JHIPSTER"/node_modules/*grunt*

npm link generator-jhipster
yo jhipster --force --no-insight
ls -al "$HOME"/"$JHIPSTER"
