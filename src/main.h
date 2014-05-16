#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"

static void nogc(lua_State *L) {
    lua_gc(L, LUA_GCSTOP, 0);

    lua_getglobal(L, "test");
    lua_pcall(L,0,0,0);

    lua_close(L);
}

static void fullgc(lua_State *L) {
    lua_gc(L, LUA_GCSTOP, 0);

    lua_getglobal(L, "test");
    lua_pcall(L,0,0,0);

    lua_gc(L, LUA_GCCOLLECT, 0);

    lua_close(L);
}

static void incrementalgc(lua_State *L) {
    lua_gc(L, LUA_GCINC, 0);

    lua_getglobal(L, "test");
    lua_pcall(L,0,0,0);

    lua_gc(L, LUA_GCCOLLECT, 0);

    lua_close(L);
}

static void generationalgc(lua_State *L) {
    lua_gc(L, LUA_GCGEN, 0);

    lua_getglobal(L, "test");
    lua_pcall(L,0,0,0);

    lua_gc(L, LUA_GCCOLLECT, 0);

    lua_close(L);
}
