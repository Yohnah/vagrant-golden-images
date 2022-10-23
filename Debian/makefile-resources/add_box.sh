#!/bin/bash -x

BOXFILE=$(cat $PACKER_DIRECTORY_OUTPUT/packer-build/manifest.json | jq '.builds[].files[].name' | sed 's/"//g' | grep "$PACKER_DIRECTORY_OUTPUT" | grep "$HOST_ARCH"  | grep "$PROVIDER" | grep "$BOX_NAME")
vagrant box add --provider $PROVIDER -f --name $VAGRANT_CLOUD_REPOSITORY_BOX_NAME-test $BOXFILE