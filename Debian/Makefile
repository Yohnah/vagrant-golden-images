export HOST_ARCH := $(shell sh ./makefile-resources/get-cpu-arch.sh)
export CURRENT_DEBIAN_VERSION := $(shell HOST_ARCH=$(HOST_ARCH) TYPE=current_debian_version sh ./makefile-resources/get-versions.sh)
export CURRENT_VERSION := $(CURRENT_DEBIAN_VERSION)
export OUTPUT_DIRECTORY := /tmp
export PACKER_DIRECTORY_OUTPUT := $(OUTPUT_DIRECTORY)
export DATETIME := $(shell date "+%Y-%m-%d %H:%M:%S")
export BOX_NAME := Debian-$(HOST_ARCH)
export PROVIDER := virtualbox
export VAGRANT_CLOUD_REPOSITORY_BOX_NAME := Yohnah/$(BOX_NAME)

all: version build add_box del_box clean

versions: 
	@echo "========================="
	@echo Box name: $(BOX_NAME)
	@echo Current Debian Version: $(CURRENT_DEBIAN_VERSION)
	@echo CPU Architecture: $(HOST_ARCH)

requirements:
	mkdir -p $(PACKER_DIRECTORY_OUTPUT)

build: requirements
	sh ./makefile-resources/build-box.sh

add_box:
	sh ./makefile-resources/add_box.sh

del_box:
	sh ./makefile-resources/del_box.sh

upload:
	sh ./makefile-resources/upload-box.sh

clean:
	rm -fr $PACKER_DIRECTORY_OUTPUT/packer-build || true

	
