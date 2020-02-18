TARGET_DIR = build

default: build

build: clean
	scripts/build.sh

serve: build
	scripts/serve.sh "build"

serve_watch: build
	scripts/serve_watch.sh "build"

clean:
	scripts/clean.sh
