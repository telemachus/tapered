package = "LuaTap"
version = "0.0-3"
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
        luatap = "src/luatap.lua"
    }
}
