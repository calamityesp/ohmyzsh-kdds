-- ***********************************************************************************************
-- *** kylechui/nvim-surround  --Great plugin for deleting and modifying surrounding symbols and tags
-- ***********************************************************************************************
return {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end,
}
-- return {
--    "kylechui/nvim-surround",
--    event = { "BufReadPre", "BufNewFile" },
--    version = "*", -- Use for stability; omit to use `main` branch for the latest features
--    config = true,
--    -- Commands
--    -- ys <motion> <char>               = surround with a character
--    -- ds <surrounding char>            = delete the specified surrounding character
--    -- cs <surrounding char> <new char> = replaces the surrounding character with new character
--    -- ys8jt                            = replace with new surrounding tag  [write new tag in console]
--    -- note: to delete tags just do dst , cst changes the tag. etc
-- }
--
--
-- Additional Details from documentation
-- ------------------------------------------------------------------------------------
-- <Up>    Old text                    Command         New text
-- --------------------------------------------------------------------------------
--     surr*ound_words             ysiw)           (surround_words)
--     *make strings               ys$"            "make strings"
--     [delete ar*ound me!]        ds]             delete around me!
--     remove <b>HTML t*ags</b>    dst             remove HTML tags
--     'change quot*es'            cs'"            "change quotes"
--     <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
--     delete(functi*on calls)     dsf             function calls
--     surround with html tag      csbt
--     surround html (visual mode) St               capital S then lowercase t
--
--
--
