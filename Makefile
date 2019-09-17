.PHONY: build

IMAGE := roundrect/dbt:latest

build:
	@echo "Building image..."
	@docker build -t ${IMAGE} .
	@echo "Pushing to Docker Hub..."
	@docker push ${IMAGE}

run:
	@echo "Building image and opening shell..."
	@docker run -i -t ${IMAGE} /bin/bash
