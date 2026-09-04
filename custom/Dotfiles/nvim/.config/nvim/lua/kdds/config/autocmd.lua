-- local autocmd = vim.api.nvim_create_autocmd
-- local root_name = {".git", "Makefile", }
--
-- autocmd("BufEnter", {
--    pattern = "*",
--    callback = function()
--       local dir = vim.fn.expand("%:p")
--       vim.cmd("silent! lcd " .. dir)
--    end,
-- })

-- Enable automatic indentation
vim.cmd("filetype plugin indent on")

-- Set the indentation for HTML files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "html",
    command = "setlocal shiftwidth=2 tabstop=2 expandtab",
})
