
all: .traefik.yml plugin.wasm

plugin.wasm:  plugin.go go.mod go.sum
	tinygo build -o plugin.wasm -scheduler=none --no-debug -target=wasi plugin.go

go.sum: 
	go get github.com/http-wasm/http-wasm-guest-tinygo/handler
	go get github.com/http-wasm/http-wasm-guest-tinygo/handler/api

.traefik.yml:
	@echo "displayName: TODO" > $@  
	@echo "type: middleware" >> $@
	@echo "runtime: wasm" >> $@
	@echo "summary: TODO" >> $@
	@echo "testData:" >> $@
	@echo "  Headers:" >> $@
	@echo "    Foo: Bar" >> $@

clean:
	rm -v -f *.wasm