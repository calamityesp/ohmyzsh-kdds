return {
    cmd = { "lua_ls" },
    root_markers = { "init.lua", "compile_commands.json" },
    filetypes = { "c", "cpp" },
    diagnostics = {
        globals = { "vim" },
    },
}
