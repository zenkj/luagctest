#include "main.h"

int main(void) {
    lua_State *L = luaL_newstate();

    luaL_openlibs(L);

    luaL_dofile(L, "src/main.lua");

    incrementalgc(L);

    return 0;
}
