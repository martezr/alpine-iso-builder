build:
	docker build -t alpine-iso-builder -f Dockerfile.builder .

iso:
	docker run --rm \
		-v $(PWD):/work \
		-w /work \
		alpine-iso-builder \
		./scripts/build-iso.sh