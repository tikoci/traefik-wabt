
all: .traefik.yml plugin.wasm 

plugin.wasm: plugin.wat 
	wat2wasm $^

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