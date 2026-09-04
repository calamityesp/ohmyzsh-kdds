return {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
        require("toggleterm").setup({
            size = 40,
            open_mapping = [[<leader>\\]],
            -- terminal_mappings = true,
            direction = "float",
        })

        -------------------------------------------------------------------------------------------
        ----------------------------       Lazygit ------------------------------------------------
        -------------------------------------------------------------------------------------------
        local terminal = require("toggleterm.terminal").Terminal
        local lazy = terminal:new({
            cmd = "lazygit",
            hidden = true,
            direction = "float",
            float_opts = {
                border = "double",
            },
            -- commands that are ran when opening and closing the terminal
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
            end,
            on_close = function(term)
                vim.cmd("startinsert!")
            end,
        })

        function _lazygit_toggle()
            lazy:toggle()
        end

        vim.api.nvim_set_keymap("n", "<leader>lgg", "<cmd>lua _lazygit_toggle()<cr>", { noremap = true, silent = true })
        -------------------------------------------------------------------------------------------
        --                               Lazygit end
        -------------------------------------------------------------------------------------------
    end,
}
