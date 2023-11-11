#! /usr/bin/env bash
cd /home/node
git config --global --add safe.directory /home/node
export INTERACTIVE=false 
export CI=true 
export MB_EDITION=oss
bin/build.sh