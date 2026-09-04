-- ***********************************************************************************************
-- *** folke/todo-comments.nvim  --Neovim plugin by Folke that highlights, lists, and manages 
--                                 TODO comments in your code, making it easier to track and 
--                                 organize tasks directly within the editor.
-- ***********************************************************************************************

return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local todo_comments = require("todo-comments")
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "]t", function()
      todo_comments.jump_next()
    end, { desc = "Next todo comment" })

    keymap.set("n", "[t", function()
      todo_comments.jump_prev()
    end, { desc = "Previous todo comment" })

    todo_comments.setup()
  end,
}
