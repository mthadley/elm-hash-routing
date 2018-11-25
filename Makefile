ELM_FILES = $(shell find src -iname "*.elm")

.PHONY: all
all: build test documentation.json

.PHONY: clean
clean:
	rm -fr node_modules elm-stuff

.PHONY: build
build: node_modules elm.json $(ELM_FILES)
	npx elm make src/Browser/Hash.elm

.PHONY: test
test:
	npx elm-test

node_modules: package-lock.json
	npm install

documentation.json: $(ELM_Files)
	npx elm make --docs=$@
