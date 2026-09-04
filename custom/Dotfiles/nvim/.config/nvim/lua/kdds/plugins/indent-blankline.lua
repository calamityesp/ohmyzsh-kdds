-- ***********************************************************************************************
-- *** lukas-reineke/indent-blankline.nvim  -- Plugin that adds indentation lines so you can see
--                                             what you are doing
-- ***********************************************************************************************

return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    opts = {
        indent = { char = "┊" },
    },
}
