
all: .traefik.yml plugin.wasm 

plugin.wasm: plugin.wat 
	wat2wasm $^

include ../Makefile.meta

clean:
	rm -v -f *.wasm