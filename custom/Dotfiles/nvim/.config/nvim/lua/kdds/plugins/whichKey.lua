-- ***********************************************************************************************
-- ***Which-Key     -- Shows pending Keybinds
-- ***********************************************************************************************
return { -- Useful plugin to show you pending keybinds.
    "folke/which-key.nvim",
    event = "VeryLazy", -- Sets the loading event to 'VimEnter'
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    config = function() -- This is the function that runs, AFTER loading
        require("which-key").setup()
        -- Document existing key chains
        require("which-key").add({
            { "<leader>c", group = "[C]ode" },
            { "<leader>c_", hidden = true },
            { "<leader>d", group = "[D]ocument" },
            { "<leader>d_", desc = "whch_key_ignore" },
            { "<leader>r", group = "[R]ename" },
            { "<leader>r_", hidden = true },
            { "<leader>s", group = "[S]earch" },
            { "<leader>s_", hidden = true },
            { "<leader>w", group = "[W]orkspace" },
            { "<leader>w_", hidden = true },
        })
    end,
    opts = {
        -- configuration comes here
        -- or leave it empty to sue default settings
        -- refer to teh configuration section
    },
}
