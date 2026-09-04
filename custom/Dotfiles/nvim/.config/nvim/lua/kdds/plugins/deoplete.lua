-- return {}
return {
    "Shougo/deoplete.nvim",
    event = { "BufReadPre", "BufNewFile" },
    build = ":UpdateRemotePlugins",
}
