-- ***********************************************************************************************
-- *** szw/vim-maximizer  --plugin that activates when you want to maximize one of the split 
--                          windows of a window split. Return by reusing the key
-- ***********************************************************************************************

return {
  "szw/vim-maximizer",
  keys = {
    {"<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split"},
  },
}
