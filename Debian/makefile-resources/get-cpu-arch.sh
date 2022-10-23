#!/bin/bash
ARCH=$(uname -m)
if [[ "$ARCH" == "x86_64" ]];
then
        ARCH="amd64"
fi

echo $ARCH
exit 0