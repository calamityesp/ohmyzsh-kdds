-- tab/indent options
vim.opt.tabstop = 3 -- Number of spaces that a tab character represents.
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 3 -- Number of spaces to use for each step of (auto)indent.
vim.opt.smarttab = true -- Use shiftwidth for tab and backspace functionality.
vim.opt.smartindent = true -- Automatically indent new lines.

-- highlight options
vim.opt.hlsearch = true -- Highlight all search results.
vim.opt.incsearch = true -- Highlight matches as you type the search.

-- display text options
vim.opt.wrap = false -- Display long lines as one line (no wrapping)
vim.opt.colorcolumn = "80" -- Mark column 120 for line length management
vim.opt.scrolloff = 10 -- Minimum number of lines above and below the cursor
vim.opt.inccommand = "split" -- Show effects of substitutions incrementally

-- line number options
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.scrolloff = 20 -- Minimum number of lines above and below the cursor

--file options
vim.opt.swapfile = false -- Disable swapfile creation
vim.opt.backup = false -- Disable backup file creation
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Directory for undo files
vim.opt.undofile = true -- Enable persistent undo
vim.opt.updatetime = 50 -- Time in milliseconds to write to swap file

-- vim terminal visual options
vim.opt.termguicolors = true -- Enable true color support
vim.opt.signcolumn = "yes" -- Always display the sign column to show markers like breakpoints and linter warnings
vim.opt.background = "dark" -- make color scheme dark that can be light or dark

-- vim editor options
vim.opt.mouse = "a" -- Enable mouse in all modes
vim.opt.mousemodel = "extend" -- Set mouse behavior to extend
vim.opt.cursorline = true -- Highlight the line of the cursor

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true -- Search case insensitively
vim.opt.smartcase = true -- Search case sensitively if the search pattern contains uppercase characters

-- Configure how new splits should be opened
vim.opt.splitright = true -- New vertical splits open to the right
vim.opt.splitbelow = true -- New horizontal splits open below

vim.opt.conceallevel = 2 -- Replace hidden text with a single character
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true -- Show whitespace characters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } -- Customise the representation of whitespace characters

vim.diagnostic.config({ virtual_text = true })
vim.g.python3_host_prog = vim.fn.exepath("python3")

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
-- vim.api.nvim_create_autocmd('TextYankPost', {
--  desc = 'Highlight when yanking (copying) text',
--  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
--  ca llback = function()
--    vim.highlight.on_yank()
-- end,
--})

-- if vim.fn.has("wsl") == 1 then
--     vim.g.clipboard = { -- Use global clip board when using wsl
--         name = "win32yank",
--         copy = {
--             ["+"] = "clip.exe",
--             ["*"] = "clip.exe",
--         },
--         paste = {
--             ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))',
--             ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))',
--         },
--         cache_enabled = 0,
--     }
-- else
vim.opt.clipboard:append("unnamedplus") -- use system clipboard
-- end

-- #-- Check if running under WSL and wl-copy is available
-- # if vim.fn.has("wsl") == 1 then
-- #     if not vim.fn.executable("wl-copy") then
-- #         print("wl-clipboard not found, clipboard integration won't work")
-- #     else
-- #         vim.g.clipboard = {
-- #             name = "wl-clipboard (wsl)",
-- #             copy = {
-- #                 ["+"] = 'wl-copy --foreground --type text/plain',
-- #                 ["*"] = 'wl-copy --foreground --primary --type text/plain',
-- #             },
-- #             paste = {
-- #                 ["+"] = function()
-- #                     return vim.fn.systemlist('wl-paste --no-newline | sed -e "s/\r$//"')
-- #                 end,
-- #                 ["*"] = function()
-- #                     return vim.fn.systemlist('wl-paste --primary --no-newline | sed -e "s/\r$//"')
-- #                 end,
-- #             },
-- #             cache_enabled = true
-- #         }
-- #     end
-- # end
