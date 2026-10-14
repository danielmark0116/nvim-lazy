-- TypeScript 7 (native) ships no tsserver.js, so typescript-language-server
-- falls back to its own bundled (older) TypeScript. In those projects use
-- the project's `tsc --lsp` instead.
local function uses_tsgo(root_dir)
  if not root_dir then
    return false
  end
  local exists = function(p)
    return vim.loop.fs_stat(root_dir .. p) ~= nil
  end
  return exists("/node_modules/.bin/tsc") and not exists("/node_modules/typescript/lib/tsserver.js")
end

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      eslint = {},
      biome = {},
      tsgo = { mason = false },
      -- kotlin_language_server = {},
      sourcekit = {
        mason = false,
        cmd = { "xcrun", "sourcekit-lsp" },
        filetypes = { "swift" },
      },
      gdscript = {
        cmd = { "nc", "localhost", "6008" },
        filetypes = { "gd", "gdscript", "gdscript3" },
        flags = {
          debounce_text_changes = 150,
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
          elseif client.name == "tsserver" or client.name == "tsgo" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
      -- new: keep tsserver off in TypeScript 7 projects
      tsserver = function(server, server_opts)
        require("lspconfig")[server].setup(server_opts)
        require("lazyvim.util").lsp.disable("tsserver", uses_tsgo)
        return true
      end,
      -- new: register the TypeScript 7 language server (your nvim-lspconfig is too old to include it)
      tsgo = function()
        local configs = require("lspconfig.configs")
        local util = require("lspconfig.util")
        if not configs.tsgo then
          configs.tsgo = {
            default_config = {
              cmd = { "tsc", "--lsp", "--stdio" },
              filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
              root_dir = function(fname)
                local root = util.root_pattern("package.json")(fname)
                return uses_tsgo(root) and root or nil
              end,
              single_file_support = false,
              on_new_config = function(config, root_dir)
                config.cmd = { root_dir .. "/node_modules/.bin/tsc", "--lsp", "--stdio" }
              end,
            },
          }
        end
      end,
    },
  },
}
