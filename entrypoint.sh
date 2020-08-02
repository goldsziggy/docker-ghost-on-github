#!/bin/sh

echo "Starting script."
# git stuffz
echo "configuring the git profile."
git config --global user.email "${GIT_EMAIL}"
git config --global user.name "${GIT_NAME}" 

# Reset the ghost dir
echo "Reseting the GHOST_PATH: $GHOST_PATH directory"
rm -rf $GHOST_PATH
mkdir $GHOST_PATH
cd $GHOST_PATH

# Clone into the new dir
echo "Cloning into the GHOST_PATH"
git clone https://${GH_PAT}:x-oauth-basic@${GH_REPO} $GHOST_PATH

# Clean cloned directory
git rm -rf .
git clean -fxd

# Place our CNAME file back
echo $REMOTE_URL >> CNAME

# Run the command to make the static page
echo "Starting the static page crawler"
gssg --domain $GHOST_SERVER_URL --url $REMOTE_URL --dest $GHOST_PATH

# push it up!
echo "Push the change up"
git add . 
# git commit -am "updated site"
# https://stackoverflow.com/a/35027514
LANG=C git -c color.status=false status \
| sed -n -r -e '1,/Changes to be committed:/ d' \
            -e '1,1 d' \
            -e '/^Untracked files:/,$ d' \
            -e 's/^\s*//' \
            -e '/./p' \
| git commit -F -

# I am a monster i know... but I want to auto remove the files 
git push # -f origin master
