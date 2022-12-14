#!/bin/sh

if [ $# -lt 2 ]; then
    echo "Copies all the required files to the given directory, renaming the project to \"project_name\".\nUsage: copy_to_project.sh directory project_name"
elif [ ! -d "$1" ]; then
    echo "Error: the directory $1 does not exists."
else 
    BASEDIR=$(dirname $(readlink -f "$0" || realpath "$0"))

    cp -R "$BASEDIR/.vscode" "$1/"
    cp -R "$BASEDIR/src" "$1/"
    cp -R "$BASEDIR/thirdparty" "$1/"
    cp "$BASEDIR/.gitignore" "$1/"
    cp "$BASEDIR/CMakeLists.txt" "$1/"
    cp "$BASEDIR/LICENSE" "$1/"
    cp "$BASEDIR/README.md" "$1/"

    # portable, non-bash way
    if echo "$OSTYPE" | grep -q "darwin"; then 
        SEDOPT="''" 
    else 
        SEDOPT=
    fi

    SEDCMD="LC_ALL=C sed -i $SEDOPT -e \"s/wx_cmake_template/$2/g\" \$(find \"$1\" -type f -not -path \"$1/.git/*\" -not -path \"$1/build/*\")"
    eval $SEDCMD
fi