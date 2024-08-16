return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      eslint = {},
      -- kotlin_language_server = {},
      sourcekit = {
        cmd = {
          "/Applications/Xcode-15.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
        },
      },
    },
    setup = {
      -- kotlin_language_server = function()
      --   return true -- avoid duplicate servers
      -- end,
      eslint = function()
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
    },
  },
}
