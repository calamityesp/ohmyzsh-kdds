-- create a global variable to hold the whichkey switch
vim.g.whichKeyOn = false

function ToggleWhichkey()
   if vim.g.whichKeyOn == false then
      vim.g.whichKeyOn = true
   else
      vim.g.whichKeyOn = false
      vim.cmd("edit!")
   end
end

vim.api.nvim_set_keymap("n", "<leader>wk", ":lua ToggleWhichkey()<cr>", { noremap = true })
