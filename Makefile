.DEFAULT_GOAL := help

DOCKER_IMAGE := "lerenn/ffmpeg:latest"

.PHONY: install
install: dependencies ## Build the ffmpeg binary and install it
	@sudo bash ./ffmpeg.sh

.PHONY: dependencies
dependencies: ## Build ffmpeg dependencies
	@sudo bash ./dependencies/dnf.sh
	@sudo bash ./dependencies/libaom-av1.sh 
	@sudo bash ./dependencies/libfdk_aac.sh
	@sudo bash ./dependencies/libmp3lame.sh
	@sudo bash ./dependencies/libx264.sh
	@sudo bash ./dependencies/libx265.sh
	@sudo bash ./dependencies/vidstab.sh
	@sudo bash ./dependencies/gcc.13.sh
	@sudo bash ./dependencies/ffnvcodec.sh

.PHONY: clean
clean: ## Clean the build 
	@sudo rm -rf ./build

.PHONY: help
help: ## Display this help message
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_\/-]+:.*?## / {printf "\033[34m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | \
		sort | \
		grep -v '#'
