#!/bin/bash -x

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)
        export PYTHONPATH="/Library/Frameworks/ParallelsVirtualizationSDK.framework/Versions/Current/Libraries/Python/3.7"
    ;;    
esac

echo "Init packer build $BOX_NAME on debian $CURRENT_DEBIAN_VERSION version and $PROVIDER as provider"
cd Packer; packer build -only "builder.$PROVIDER-iso.debian" -var "arch=$HOST_ARCH" -var "debian_version=$CURRENT_DEBIAN_VERSION" -var "box_version=$CURRENT_DEBIAN_VERSION" -var "vm_name=$BOX_NAME" -var "output_directory=$PACKER_DIRECTORY_OUTPUT" packer.pkr.hcl