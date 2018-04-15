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

# make sure temporary directory is not made (ensures no recursion)
if [[ -d "$NWD/allprojects" && ! -L "$NWD/allprojects" ]]; then
    echo "Please migrate or remove $NWD/allprojects"
    exit 0
fi
if [[ -f "$BASEDIR/allprojects.tar.gz" ]]; then
    mv -f "$BASEDIR/allprojects.tar.gz" "$BASEDIR/allprojects.tar.gz.bak"
    echo "Created backup: $BASEDIR/allprojects.tar.gz.bak"
fi

# create directory and tmp json file
mkdir "$NWD/allprojects"
json="$BASEDIR/../../classroom.json"
if [ -f "$json" ]; then
    rm -f "$json"
fi

touch "$json"
echo "{" >> "$json"
echo "  \"modules\": [" >> "$json"

# copy files to this new directory for archiving: prevents recursion
for f in *; do
    if [ -d "$f" ] && [ ! -L "$f" ] && [ "$f" != "allprojects" ] && [ "$f" != "Download All" ] && [ "$f" != "Manuals" ] && [ "$f" != "Codes" ] && [ "$f" != "Slides" ]; then
        # handles json file
        echo "    {" >> "$json"
        DESC=`head -n 20 "$f/README.md" | grep "DESC"`
        DESC="${DESC:5}"
        echo "      \"desc\": \"$DESC\"," >> "$json"
        echo "      \"name\": \"$f\"," >> "$json"
        echo "      \"data\": \"./classroom/$f/exampledata.tar.gz\"," >> "$json"
        echo "      \"instructor\": \"./classroom/$f/instructor.tar.gz\"," >> "$json"
        echo "      \"directions\": \"./classroom/$f/README.md\"," >> "$json"
        echo "      \"bkgnd\": \"./classroom/$f/bkgnd.jpg\"" >> "$json"
        echo "    }," >> "$json"
        # copies all files to allprojects
        cp -r "$f" "$NWD/allprojects/"
        temp="`pwd`"
        cd "$f"
        for k in *; do
            if [ -d "$k" ] && [ ! -L "$k" ]; then
                tar -czf "$k.tar.gz" "$k"
            fi
        done
        cd "$temp"
    fi
    if [ -d "$f" ] && [ ! -L "$f" ] && [ "$f" == "Download All" ]; then
        # handles json file
        echo "    {" >> "$json"
        DESC=`head -n 20 "$f/README.md" | grep "DESC"`
        DESC="${DESC:5}"
        echo "      \"desc\": \"$DESC\"," >> "$json"
        echo "      \"name\": \"$f\"," >> "$json"
        echo "      \"data\": \"./classroom/$f/allprojects.tar.gz\"," >> "$json"
        echo "      \"instructor\": \"\"," >> "$json"
        echo "      \"directions\": \"./classroom/$f/README.md\"," >> "$json"
        echo "      \"bkgnd\": \"./classroom/$f/bkgnd.jpg\"" >> "$json"
        echo "    }," >> "$json"
    fi
    if [ -d "$f" ] && [ ! -L "$f" ] && [ "$f" == "Manuals" ]; then
        # handles json file
        echo "    {" >> "$json"
        DESC=`head -n 20 "$f/README.md" | grep "DESC"`
        DESC="${DESC:5}"
        echo "      \"desc\": \"$DESC\"," >> "$json"
        echo "      \"name\": \"$f\"," >> "$json"
        echo "      \"manuals\": \"https://github.com/OUsrt/SRTmanuals/archive/master.zip\"," >> "$json"
        echo "      \"directions\": \"./classroom/$f/README.md\"," >> "$json"
        echo "      \"bkgnd\": \"./classroom/$f/bkgnd.jpg\"" >> "$json"
        echo "    }," >> "$json"
        # copies all files to allprojects
        cp -r "$f" "$NWD/allprojects/"
        temp="`pwd`"
        cd "$f"
        for k in *; do
            if [ -d "$k" ] && [ ! -L "$k" ]; then
                tar -czf "$k.tar.gz" "$k"
            fi
        done
        cd "$temp"
    fi
    if [ -d "$f" ] && [ ! -L "$f" ] && [ "$f" == "Codes" ]; then
        # handles json file
        echo "    {" >> "$json"
        DESC=`head -n 20 "$f/README.md" | grep "DESC"`
        DESC="${DESC:5}"
        echo "      \"desc\": \"$DESC\"," >> "$json"
        echo "      \"name\": \"$f\"," >> "$json"
        echo "      \"codes\": \"https://github.com/OUsrt/SRTscripts/archive/master.zip\"," >> "$json"
        echo "      \"directions\": \"./classroom/$f/README.md\"," >> "$json"
        echo "      \"bkgnd\": \"./classroom/$f/bkgnd.jpg\"" >> "$json"
        echo "    }," >> "$json"
        # copies all files to allprojects
        cp -r "$f" "$NWD/allprojects/"
        temp="`pwd`"
        cd "$f"
        for k in *; do
            if [ -d "$k" ] && [ ! -L "$k" ]; then
                tar -czf "$k.tar.gz" "$k"
            fi
        done
        cd "$temp"
    fi
    if [ -d "$f" ] && [ ! -L "$f" ] && [ "$f" == "Slides" ]; then
        # handles json file
        echo "    {" >> "$json"
        DESC=`head -n 20 "$f/README.md" | grep "DESC"`
        DESC="${DESC:5}"
        echo "      \"desc\": \"$DESC\"," >> "$json"
        echo "      \"name\": \"$f\"," >> "$json"
        echo "      \"srtintroou\": \"./classroom/$f/GeneralPresentation.pdf\"," >> "$json"
        echo "      \"srtintro\": \"./classroom/$f/OUPresentation.pdf\"," >> "$json"
        echo "      \"srtcontrol\": \"./classroom/$f/ControlPresentation.pdf\"," >> "$json"
        echo "      \"srtreduc\": \"./classroom/$f/ReductionPresentation.pdf\"," >> "$json"
        echo "      \"directions\": \"./classroom/$f/README.md\"," >> "$json"
        echo "      \"bkgnd\": \"./classroom/$f/bkgnd.jpg\"" >> "$json"
        echo "    }," >> "$json"
        # copies all files to allprojects
        cp -r "$f" "$NWD/allprojects/"
        temp="`pwd`"
        cd "$f"
        for k in *; do
            if [ -d "$k" ] && [ ! -L "$k" ]; then
                tar -czf "$k.tar.gz" "$k"
            fi
        done
        cd "$temp"
    fi
done
sed -i "$ s/},/}/g" "$json"
echo "  ]" >> "$json"
echo "}" >> "$json"

# archiving
tar -czf "allprojects.tar.gz" "allprojects"

mv "$NWD/allprojects.tar.gz" "$BASEDIR/"

# cleaning up
rm -rf "$NWD/allprojects"

echo "Successfully made $NWD/allprojects.tar.gz"
echo "Successfully made $json"

cd "$CWD"
exit 0
