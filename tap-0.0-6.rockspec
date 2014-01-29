package = "tap"
version = "0.0-6"
source = {
    url = "https://github.com/telemachus/lua-tap"
}
description = {
    summary = "A very simple tap testing module for Lua",
    detailed = [[
        LuaTap is tap testing for Lua.
        It's very minimal, arguably too minimal.
    ]],
    license = "MIT"
}
dependencies = {
    "lua >= 5.1"
}
build = {
    type = "builtin",
    modules = {
        tap = "src/tap.lua"
    }
}
