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
-- which key for file search, live grep, search current word
-- replace in work / selection etc
-- surround
-- lsp, saga, previews
-- copilot
-- chatgtp
-- tmux plugin - to, say, open terminal pane temporarily next to nvim window
-- test runner
-- window maximizer (leader m)
-- git blame

-- Deleting keymaps I do not like
keymap.del("n", "<leader>ww")
keymap.del("n", "<leader>wd")
keymap.del("n", "<leader>w-")
keymap.del("n", "<leader>w|")
keymap.del("n", "<leader>ge")
keymap.del("n", "s")
keymap.del("n", "<leader>gG")

-- Undo / write
keymap.set("n", "<leader>u", ":undo<CR>", opts)
keymap.set("n", "<leader>w", ":w<CR>", opts)

-- Escape insert mode
keymap.set("i", "jk", "<ESC>", opts)

-- Goto line
keymap.set({ "n", "v" }, "<leader>l", "$", opts)
keymap.set({ "n", "v" }, "<leader>h", "^", opts)

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G", opts)

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

-- " Tabs
--
-- " Open current directory
-- nmap te :tabedit
-- nmap <S-Tab> :tabprev<Return>
-- nmap <Tab> :tabnext<Return>
--
-- " Run command promt with Vimux in a small horizontal split
-- nmap <leader>C :VimuxPromptCommand<CR>
--
-- " Lspsaga finder
-- nnoremap gh :Lspsaga lsp_finder<CR>
-- nnoremap gp :Lspsaga peek_definition<CR>
--
--
-- " Search for selected text, forwards or backwards.
-- vnoremap <silent> * :<C-U>
--   \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
--   \gvy/<C-R><C-R>=substitute(
--   \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
--   \gV:call setreg('"', old_reg, old_regtype)<CR>
-- vnoremap <silent> # :<C-U>
--   \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
--   \gvy?<C-R><C-R>=substitute(
--   \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
--   \gV:call setreg('"', old_reg, old_regtype)<CR>
--
-- "-----------------------------
