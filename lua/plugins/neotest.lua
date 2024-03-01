return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/neotest-jest",
  },
  opts = {
    discovery = {
      enabled = false,
    },
    adapters = {
      ["neotest-jest"] = {
        jestCommand = "npm run jest --",
        jest_test_discovery = true,
        env = { CI = true },
        cwd = function(_path)
          return vim.fn.getcwd()
        end,
      },
    },
  },
  keys = {
    {
      "<leader>jf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run File",
    },
    {
      "<leader>jF",
      function()
        require("neotest").run.run(vim.loop.cwd())
      end,
      desc = "Run All Test Files",
    },
    {
      "<leader>jj",
      function()
        require("neotest").run.run()
      end,
      desc = "Run Nearest",
    },
    {
      "<leader>jl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Run Last",
    },
    {
      "<leader>js",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle Summary",
    },
    {
      "<leader>jo",
      function()
        require("neotest").output.open({ enter = true, auto_close = true })
      end,
      desc = "Show Output",
    },
    {
      "<leader>jO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle Output Panel",
    },
    {
      "<leader>jS",
      function()
        require("neotest").run.stop()
      end,
      desc = "Stop",
    },
  },
}
