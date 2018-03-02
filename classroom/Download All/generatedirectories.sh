#!/bin/bash
# This code handles the compilation of all classroom sources
# Probably could be handled better but works

###################################
# part 1 generates the tar.gz file
###################################

# store current working directory
CWD=`pwd`
# find absolute path of script
SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")

# move to thhis directory
cd "$BASEDIR"
cd ..

NWD=`pwd`
NWD="$NWD"

CMDARGS="Please input the name of the file: "

while [ -z "$REPLY" ] ; do
    printf "$CMDARGS"; read REPLY
done
while [ -d "$REPLY" ] ; do
    printf "Directory exists, input unique name: "; read REPLY
done

cp -rf "$BASEDIR/TEMPLATE_DIRECTORY" "$NWD/$REPLY"

echo "Created $NWD/$REPLY"
cd "$CWD"
exit 0
