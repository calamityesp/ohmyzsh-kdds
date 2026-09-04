return {
    "willothy/flatten.nvim",
    config = function()
        require("flatten").setup({
            window = { open = "tab", diff = "vsplit", focus = "first" },
        })
    end,
}
