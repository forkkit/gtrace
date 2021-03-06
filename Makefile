.PHONY: gtrace
gtrace:
	go build -o gtrace ./cmd/gtrace

.PHONY: examples
examples: gtrace
	PATH=$(PWD):$(PATH)	go generate ./examples/...
	go build -o pinger ./examples/pinger

.PHONY: test
test: gtrace
	find ./test -name '*_gtrace*' -delete
	for os in linux darwin; do \
		for arch in amd64 arm64; do \
			PATH=$(PWD):$(PATH)	GOOS=$$os GOARCH=$$arch go generate ./test; \
		done; \
	done
	go test -v ./test

clean:
	rm -f gtrace
	rm -f pinger
