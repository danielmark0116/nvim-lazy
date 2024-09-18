return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    {
      "<leader>ef",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd(), position = "current" })
      end,
      desc = "Explorer NeoTree (root dir)",
      remap = true,
    },
    {
      "<leader>eg",
      function()
        require("neo-tree.command").execute({ source = "git_status", toggle = true })
      end,
      desc = "Git explorer",
    },
    {
      "<leader>eb",
      function()
        require("neo-tree.command").execute({ source = "buffers", toggle = true })
      end,
      desc = "Buffer explorer",
    },
  },
  opts = {
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      hijack_netrw_behavior = "open_current",
    },
    window = {
      mappings = {
        ["<space>"] = "none",
        ["s"] = "none",
        ["ss"] = "open_vsplit",
        ["sv"] = "open_split",
      },
    },
  },
}
