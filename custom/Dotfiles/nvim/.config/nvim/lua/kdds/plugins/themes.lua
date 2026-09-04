--      tokyonight -----------------------------------------
-- return {
--     "folke/tokyonight.nvim",
--     priority = 1000,
--     config = function()
--         ------------------------------------------------------
--         -----------       local bg options -------------------
--         ------------------------------------------------------
--         -- local bg = "#011628"
--         -- local bg = "#ffaf5f"
--         local bg = "#1a1b26" -- Color of the Active Background
--
--         ------------------------------------------------------
--         -----------     local inactive bg  -------------------
--         ------------------------------------------------------
--         -- local bg_dark = "#562e05"
--         -- local bg_dark = "#011423"
--         local bg_dark = "#1a1b26"
--
--         ------------------------------------------------------
--         ------------- line highlight color -------------------
--         ------------------------------------------------------
--         -- local bg_dark = "#000D18" -- Color of the inactivea background
--         -- local bg_highlight = "#143652"
--         -- local bg_highlight = "#512200"
--         local bg_highlight = "#4c341c"
--
--         local bg_search = "#0A64AC"
--
--         --    high light color in visual mode background --------------------
--         -- local bg_search = "#4c341c"
--         -- local bg_visual = "#275378"
--         -- local bg_visual = "#ffc16c"
--         local bg_visual = "#4c341c"
--         -- ------------------------------------------------------------------
--
--         local fg = "#CBE0F0"
--         local fg_dark = "#B4D0E9"
--         local fg_gutter = "#627E97"
--         local border = "#547998"
--
--         require("tokyonight").setup({
--             style = "night",
--             on_colors = function(colors) --modify tokyonight color themes with this function
--                 colors.bg = bg
--                 colors.bg_dark = bg_dark
--                 colors.bg_float = bg_dark
--                 colors.bg_highlight = bg_highlight
--                 colors.bg_popup = bg_dark
--                 colors.bg_search = bg_search
--                 colors.bg_sidebar = bg_dark
--                 colors.bg_statusline = bg_dark
--                 colors.bg_visual = bg_visual
--                 colors.border = border
--                 colors.fg = fg
--                 colors.fg_dark = fg_dark
--                 colors.fg_float = fg
--                 colors.fg_gutter = fg_gutter
--                 colors.fg_sidebar = fg_dark
--             end,
--         })
--
--         vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) -- set the background to none to match terminal emulator color
--         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" }) -- same as above for floating windows
--         vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" }) -- same as above for floating windows
--         -- vim.cmd("colorscheme tokyonight")
--         -- vim.cmd("colorscheme tokyonight-night")
--         vim.cmd("colorscheme tokyonight-storm")
--         -- vim.cmd("colorscheme tokyonight-moon")
--     end,
-- }

-- -------------------------------------------------
-- NEON
-- -------------------------------------------------
-- return {
--     "rafamadriz/neon",
--     priority = 1000,
--     config = function()
--         vim.g.neon_style = "doom"
--         vim.g.neon_italic_keyword = true
--         vim.g.neon_italic_function = true
--         vim.g.neon_transparent = false
--
--         vim.cmd("colorscheme neon")
--     end,
-- }
--

-- -------------------------------------------------
-- Material
-- -------------------------------------------------
-- return {
--     "marko-cerovac/material.nvim",
--     priority = 1000,
--     config = function()
--         require("material").setup({
--             contrast = {
--                 terminal = false, -- Enable contrast for the built-in terminal
--                 sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
--                 floating_windows = false, -- Enable contrast for floating windows
--                 cursor_line = false, -- Enable darker background for the cursor line
--                 lsp_virtual_text = false, -- Enable contrasted background for lsp virtual text
--                 non_current_windows = false, -- Enable contrasted background for non-current windows
--                 filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
--             },
--
--             styles = { -- Give comments style such as bold, italic, underline etc.
--                 comments = { --[[ italic = true ]]
--                 },
--                 strings = { --[[ bold = true ]]
--                 },
--                 keywords = { --[[ underline = true ]]
--                 },
--                 functions = { --[[ bold = true, undercurl = true ]]
--                 },
--                 variables = {},
--                 operators = {},
--                 types = {},
--             },
--
--             plugins = { -- Uncomment the plugins that you use to highlight them
--                 -- Available plugins:
--                 -- "coc",
--                 -- "colorful-winsep",
--                 -- "dap",
--                 -- "dashboard",
--                 -- "eyeliner",
--                 -- "fidget",
--                 -- "flash",
--                 -- "gitsigns",
--                 "harpoon",
--                 -- "hop",
--                 -- "illuminate",
--                 -- "indent-blankline",
--                 -- "lspsaga",
--                 -- "mini",
--                 -- "neogit",
--                 -- "neotest",
--                 -- "neo-tree",
--                 -- "neorg",
--                 -- "noice",
--                 -- "nvim-cmp",
--                 -- "nvim-navic",
--                 "nvim-tree",
--                 -- "nvim-web-devicons",
--                 -- "rainbow-delimiters",
--                 -- "sneak",
--                 "telescope",
--                 "trouble",
--                 "which-key",
--                 -- "nvim-notify",
--             },
--
--             disable = {
--                 colored_cursor = false, -- Disable the colored cursor
--                 borders = false, -- Disable borders between vertically split windows
--                 background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
--                 term_colors = false, -- Prevent the theme from setting terminal colors
--                 eob_lines = false, -- Hide the end-of-buffer lines
--             },
--
--             high_visibility = {
--                 lighter = false, -- Enable higher contrast text for lighter style
--                 darker = false, -- Enable higher contrast text for darker style
--             },
--
--             lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )
--
--             async_loading = true, -- Load parts of the theme asynchronously for faster startup (turned on by default)
--
--             custom_colors = nil, -- If you want to override the default colors, set this to a function
--
--             custom_highlights = {}, -- Overwrite highlights with your own
--         })
--
--         require("material.functions").change_style("darker")
--     end,
-- }

return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
        local cat = require("catppuccin")
        cat.setup({
            flavour = "mocha",
            integrations = {
                gitsigns = true,
                treesitter = true,
                nvimtree = true,
                telescope = {
                    enabled = true,
                },
                markdown = true,
            },
        })

        vim.cmd.colorscheme("catppuccin")
    end,
}
