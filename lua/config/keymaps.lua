-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Options
local keymap = vim.keymap
local opts = { noremap = true, silent = true }
local Util = require("lazyvim.util")

-- TODO:
-- DONE: colorscheme - catpuccino try it out
-- DONE: which key for github
-- DONE: which key for file search, live grep, search current word
-- DONE: replace in work / selection etc
-- DONE: surround
-- DONE: easymotion - replaced with flash
-- DONE: copilot
-- DONE: suggestions change on tab!
-- DONE: lsp, saga, previews
-- DONE: chatgtp
-- DONE: test runner
-- DONE: window maximizer (leader m)
-- tmux plugin - to, say, open terminal pane temporarily next to nvim window
-- git blame

-- Deleting keymaps I do not like
keymap.del("n", "<leader>ww")
keymap.del("n", "<leader>wd")
keymap.del("n", "<leader>w-")
keymap.del("n", "<leader>w|")
keymap.del("n", "<leader>ge")
keymap.del({ "n", "v" }, "s")
keymap.del({ "n", "v" }, "S")
keymap.del("n", "<leader>gG")

-- Undo / write
keymap.set("n", "<leader>u", ":undo<CR>", opts)
keymap.set("n", "<leader>w", ":w<CR>", opts)

-- Escape insert mode
keymap.set("i", "jk", "<ESC>", opts)

-- Goto line
keymap.set({ "n", "v" }, "<leader>l", "$", opts)
keymap.set({ "n", "v" }, "<leader>h", "^", opts)
keymap.set("n", "gh", "<cmd>Telescope lsp_references<cr>", opts)

-- Select all
keymap.set("n", "<C-a>a", "gg<S-v>G", opts)

-- Window/splits management
keymap.set("n", "ss", ":split<Return><C-w>j", opts)
keymap.set("n", "sv", ":vsplit<Return><C-w>l", opts)
keymap.set("n", "sh", "<C-w>h", opts)
keymap.set("n", "sl", "<C-w>l", opts)
keymap.set("n", "sk", "<C-w>k", opts)
keymap.set("n", "sj", "<C-w>j", opts)
keymap.set("n", "sj", "<C-w>j", opts)
keymap.set("n", "<C-w><left>", "<C-w><", opts)
keymap.set("n", "<C-w><right>", "<C-w>>", opts)
keymap.set("n", "<C-w><up>", "<C-w>+", opts)
keymap.set("n", "<C-w><down>", "<C-w>-", opts)

-- TAB
keymap.set("n", "<S-tab>", ":tabprev<Return>", opts)
keymap.set("n", "<Tab>", ":tabnext<Return>", opts)

-- Moving inbetween open buffers / closing
-- S+h|l
keymap.set("n", "<leader>bl", ":bnext<Return>", opts)
keymap.set("n", "<leader>bh", ":bprev<Return>", opts)
keymap.set("n", "<leader>bc", ":bdelete<Return>", opts)

-- LazyGIT
keymap.set("n", "<leader>g", function()
  Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false })
end, opts)

-- Replace with register
keymap.set("n", "<leader>r", "<Plug>ReplaceWithRegisterOperator", opts)

-- Missing vim-surround keymap
keymap.set("x", "S", "<Plug>VSurround", opts)

-- " Run command promt with Vimux in a small horizontal split
-- nmap <leader>C :VimuxPromptCommand<CR>
