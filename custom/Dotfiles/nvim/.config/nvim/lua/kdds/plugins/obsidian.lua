return {
    "calamityesp/obsidian.nvim",
    event = { "BufReadPre", "BufNewFile" },
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = false,
    ft = "markdown",
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",

        -- see below for full list of optional dependencies 👇
    },
    config = function()
        local obsidian = require("obsidian")

        obsidian.setup({
            workspaces = {
                {
                    name = "Coding References",
                    path = "/home/calamityesp/OneDrive/Obsidian/Calamity_Notes",
                },
                {
                    name = "Handwritten Notes",
                    path = "~/.oh-my-bash/Obsidian/Calamity_Draw/",
                },
            },
            mappings = {
                ["<leader>och"] = {
                    action = function()
                        return require("obsidian").util.toggle_checkbox()
                    end,
                    opts = { buffer = true, desc = "toggle checkboxes" },
                },
            },
            templates = {
                folder = "TEMPLATES",
                date_format = "%Y-%m-%d-%a",
                time_format = "%H:%M",
            },
        })

        --        Obsidian related keymaps  -------------------
        -- Open notes in new tab
        vim.keymap.set("n", "<leader>oot", function()
            vim.cmd("tabnew")
            vim.cmd("ObsidianSearch")
        end, { desc = "Open note in new tab" })

        -- Open notes in new split
        vim.keymap.set("n", "<leader>oos", function()
            vim.cmd("vsplit")
            vim.cmd("ObsidianSearch")
        end, { desc = "open note in new split" })

        vim.keymap.set("n", "<leader>ooo", function()
            vim.cmd("ObsidianSearch")
        end, { desc = "open new note in current buffer" })

        -- Template command
        vim.keymap.set("n", "<leader>ot", function()
            vim.cmd("ObsidianTemplate")
        end)

        -- New Obsidian Note Insert
        vim.keymap.set("n", "<leader>oon", function()
            vim.cmd("ObsidianNew")
        end, { desc = "Create a new obsidian note" })

        -- Search for buffer by tag id
        vim.keymap.set("n", "<leader>ott", function()
            vim.cmd("ObsidianTags")
        end, { desc = "search by tag" })

        -- Create a new template file
        vim.keymap.set("n", "<leader>otn", function()
            local templateName = vim.fn.input("TemplateName : ")
            vim.cmd("ObsidianNew TEMPLATES/" .. templateName .. " template.md")
        end, { desc = "create a new template " })

        -- Open Obsidian editor
        vim.keymap.set("n", "<leader>oop", function()
            vim.cmd("ObsidianOpen")
        end, { desc = "Open the obsidian editor" })
    end,
}
