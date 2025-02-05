.DEFAULT_GOAL := help

DOCKER_IMAGE := "lerenn/ffmpeg:latest"

.PHONY: all
all: dependencies build install ## Build and install ffmpeg

.PHONY: build
build: ## Build ffmpeg
	@bash ./build.sh

.PHONY: install
install: ## Install ffmpeg
	@bash ./install.sh

.PHONY: dependencies
dependencies: ## Build ffmpeg dependencies
	@bash ./dependencies/dnf.sh
	@bash ./dependencies/cuda.sh
	@bash ./dependencies/ffnvcodec.sh
	@bash ./dependencies/gcc.13.sh
	@bash ./dependencies/libaom-av1.sh 
	@bash ./dependencies/libfdk_aac.sh
	@bash ./dependencies/libmp3lame.sh
	@bash ./dependencies/libx264.sh
	@bash ./dependencies/libx265.sh
	@bash ./dependencies/vidstab.sh

.PHONY: clean
clean: ## Clean the build
	@rm -rf ./build

.PHONY: help
help: ## Display this help message
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_\/-]+:.*?## / {printf "\033[34m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | \
		sort | \
		grep -v '#'
