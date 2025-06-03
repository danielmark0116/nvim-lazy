return {
  "LazyVim/LazyVim",
  opts = {
    -- Add GDScript filetype detection
    autocmds = {
      gdscript_filetype = {
        {
          "BufRead,BufNewFile",
          "*.gd",
          function()
            vim.bo.filetype = "gdscript"
          end,
        },
      },
    },
  },
}
