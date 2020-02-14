TARGET_DIR = build

default: build

build: clean
	scripts/build.sh

http: build
	scripts/http.sh

serve: clean
	scripts/serve.sh

clean:
	scripts/clean.sh
