EXES = nogc fullgc incrementalgc generationalgc

LUADIR = lib/lua-5.2.3

$(EXES): %: src/%.c src/main.h $(LUADIR)/src/liblua.a
	gcc -g -o $@ $< $(LUADIR)/src/liblua.a -I$(LUADIR)/src -lm -ldl

$(LUADIR)/src/liblua.a: lib/lua-5.2.3.tar.gz
	rm -rf lib/lua-5.2.3 && cd lib && tar zxf lua-5.2.3.tar.gz &&cd lua-5.2.3/src && sed -i /CFLAGS=/s/-O2/-g/ Makefile && make a SYSCFLAGS="-DLUA_USE_LINUX" SYSLIBS="-Wl,-E -ldl"

callgrind: $(EXES:%=result/%.callgrind)

$(EXES:%=result/%.callgrind): result/%.callgrind: %
	valgrind --tool=callgrind --callgrind-out-file=$@ ./$<

annotate: $(EXES:%=result/%.callgrind.annotate)

$(EXES:%=result/%.callgrind.annotate): %.annotate: %
	callgrind_annotate --tree=calling $< >$@.calling
	callgrind_annotate --inclusive=yes $< >$@.inclusive
	callgrind_annotate --inclusive=no $< >$@.exclusive

clean: 
	rm -rf $(LUADIR) result/* $(EXES)
