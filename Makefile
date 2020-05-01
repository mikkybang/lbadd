.PHONY: watch
watch: ## Start a file watcher to run tests on change. (requires: watchexec)
	watchexec -c "go test -failfast ./..."

.PHONY: all
all: lint test build ## test -> lint -> build

.PHONY: test
test: ## Runs the unit test suite
	go test -race ./...

.PHONY: lint
lint: ## Runs the linters (including internal ones)
	# internal analysis tools
	go run ./internal/tool/analysis ./...;
	# external analysis tools
	golint ./...;
	errcheck ./...;
	gosec -quiet ./...;
	staticcheck ./...;

.PHONY: build
build: ## Build an lbadd binary that is ready for prod
	go build -o lbadd -ldflags="-w -X 'main.Version=$(shell date +%Y%m%d)'" ./cmd/lbadd

.PHONY: fuzzy-parser
fuzzy-parser: ## Starts fuzzing the parser
	go-fuzz-build -o parser-fuzz.zip ./internal/parser
	go-fuzz -bin parser-fuzz.zip -workdir internal/parser/test/fuzz

## Help display.
## Pulls comments from beside commands and prints a nicely formatted
## display with the commands and their usage information.

.DEFAULT_GOAL := help

help: ## Prints this help
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

