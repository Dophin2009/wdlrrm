TARGET_DIR = build

default: build

build: clean
	scripts/build.sh

serve: build
	scripts/serve.sh

clean:
	scripts/clean.sh
