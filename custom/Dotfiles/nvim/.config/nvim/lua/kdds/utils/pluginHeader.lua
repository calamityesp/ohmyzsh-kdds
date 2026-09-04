function pluginHeader(name, desc)
   name = name or vim.fn.input("Enter Plugin Name: ")
   desc = desc or vim.fn.input("Enter Plugin Description: ")

   --  local row = vim.api.nvim_win_get_cursor(0)[1]
   local text_block = [[
-- ***********************************************************************************************
-- *** ]] .. name .. [[  --]] .. desc .. "\n" .. [[
-- ***********************************************************************************************
]]

   vim.api.nvim_buf_set_lines(0, 0, 0, false, vim.split(text_block, "\n", true))
end
