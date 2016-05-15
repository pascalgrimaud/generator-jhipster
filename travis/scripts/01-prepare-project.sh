#!/bin/bash

#-------------------------------------------------------------------------------
# Force no insight
#-------------------------------------------------------------------------------
mkdir -p "$HOME"/.config/configstore/
mv "$JHIPSTER_TRAVIS"/configstore/*.json "$HOME"/.config/configstore/

#-------------------------------------------------------------------------------
# Prepare project by copying configuration and entities
#-------------------------------------------------------------------------------
mv -f "$JHIPSTER_SAMPLES"/"$JHIPSTER" "$HOME"/
cd "$HOME"/"$JHIPSTER"

rm -Rf "$HOME"/"$JHIPSTER"/node_modules/.bin/*grunt*
rm -Rf "$HOME"/"$JHIPSTER"/node_modules/*grunt*

npm link generator-jhipster
ls -al "$HOME"/"$JHIPSTER"/
