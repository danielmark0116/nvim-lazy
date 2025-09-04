-- Put this somewhere above your lualine.setup
local excluded_ft = {
  "neo-tree",
  "NvimTree",
  "help",
  "qf",
  "Trouble",
  "toggleterm",
  "terminal",
  "TelescopePrompt",
  "TelescopeResults",
  "alpha",
  "dashboard",
  "lazy",
  "mason",
  "Outline",
  "spectre_panel",
  "oil",
  "man",
  "checkhealth",
  -- DAP UI panes
  "dapui_scopes",
  "dapui_breakpoints",
  "dapui_stacks",
  "dapui_watches",
  "dap-repl",
}

local function is_real_file()
  local buf = vim.api.nvim_get_current_buf()
  -- Only normal file buffers
  if vim.bo[buf].buftype ~= "" then
    return false
  end
  -- Skip special filetypes (sidebars, pickers, dashboards, etc.)
  if vim.tbl_contains(excluded_ft, vim.bo[buf].filetype) then
    return false
  end
  -- Hide on unnamed/empty buffers
  if vim.api.nvim_buf_get_name(buf) == "" then
    return false
  end
  -- Only listed buffers
  if vim.fn.buflisted(buf) == 0 then
    return false
  end
  return true
end

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      -- theme = "iceberg_dark",
      -- theme = "base16",
      -- theme = "palenight",
      theme = "auto",
      icons_enabled = true,
      component_separators = { "", "" },
      section_separators = { "", "" },
      -- disabled_filetypes = {},
      disabled_filetypes = { winbar = excluded_ft }, -- don't draw winbar at all in these
    },
    -- Shows files names in each opened buffer
    -- winbar = {
    --   lualine_c = {
    --     { "filename", file_status = true, path = 1, shorting_target = 40 },
    --   },
    -- },
    -- inactive_winbar = {
    --   lualine_c = { { "filename", path = 1 } },
    -- },

    winbar = {
      -- lualine_c for left aligned title
      lualine_z = {
        {
          "filename",
          path = 1, -- 0=name, 1=relative, 2=absolute
          file_status = true,
          newfile_status = false, -- hide [New] to avoid noise
          shorting_target = 40,
          symbols = { modified = "● ✏️", readonly = "", unnamed = "" },
          cond = is_real_file, -- 👈 key filter
          fmt = function(name)
            return "🌭 " .. name -- 👈 pick any emoji you like
          end,
        },
      },
    },
    inactive_winbar = {
      -- lualine_c for left aligned title
      lualine_z = {
        {
          "filename",
          path = 1,
          cond = is_real_file,
          fmt = function(name)
            return "🌭 " .. name -- 👈 pick any emoji you like
          end,
        },
      },
    },
  },
}
