return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "<leader><leader>s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "<leader><leader>w", mode = { "n", "x", "o" }, function() require("flash").jump({
      search = { forward = true, wrap = false, multi_window = false },
    }) end, desc = "Flash Forward Only" },
    { "<leader><leader>b", mode = { "n", "x", "o" }, function() require("flash").jump({
      search = { forward = false, wrap = false, multi_window = false },
    }) end, desc = "Flash Backwards Only" },
    { "<leader><leader>S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "<leader><leader>r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "<leader><leader>R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
