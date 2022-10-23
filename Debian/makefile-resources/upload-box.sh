export DATETIME=$(date "+%Y-%m-%d %H:%M:%S")

BOXFILE=$(cat $PACKER_DIRECTORY_OUTPUT/packer-build/manifest.json | jq '.builds[].files[].name' | sed 's/"//g' | grep "$PACKER_DIRECTORY_OUTPUT" | grep "$HOST_ARCH"  | grep "$PROVIDER" | grep "$BOX_NAME")

echo "Box $BOXFILE found, uploading..."
vagrant cloud version create $VAGRANT_CLOUD_REPOSITORY_BOX_NAME $CURRENT_VERSION || true
vagrant cloud version update -d "$(cat ./makefile-resources/uploading-box-notification-template.md | envsubst)" $VAGRANT_CLOUD_REPOSITORY_BOX_NAME $CURRENT_VERSION
vagrant cloud provider delete -f $VAGRANT_CLOUD_REPOSITORY_BOX_NAME $PROVIDER $CURRENT_VERSION || true
SHASUM=$(shasum $BOXFILE | awk '{ print $1 }')
vagrant cloud provider create --timestamp --checksum-type sha1 --checksum $SHASUM $VAGRANT_CLOUD_REPOSITORY_BOX_NAME $PROVIDER $CURRENT_VERSION
vagrant cloud provider upload $VAGRANT_CLOUD_REPOSITORY_BOX_NAME $PROVIDER $CURRENT_VERSION $BOXFILE
vagrant cloud version update -d "$(cat ./makefile-resources/box-version-description-template.md | envsubst)" $VAGRANT_CLOUD_REPOSITORY_BOX_NAME $CURRENT_VERSION
vagrant cloud version release -f $VAGRANT_CLOUD_REPOSITORY_BOX_NAME $CURRENT_VERSION || true
