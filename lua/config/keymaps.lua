local buffers = require("utils.buffers")

local keymap = vim.keymap.set
local defaults = { noremap = true, silent = true }

local defs = function(opts)
  local new_opts = {}
  for k,v in pairs(defaults) do new_opts[k] = v end
  for k,v in pairs(opts) do new_opts[k] = v end
  return new_opts
end

-- move up/down .5 page and center cursor
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<C-d>", "<C-d>zz")

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>", defaults)
keymap("i", "jj", "<ESC>", defaults)
keymap("i", "WW", "<ESC>:w<CR>", defaults)

-- While in terminal mode
keymap("t", "jk", "<C-\\><C-n>")
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h")
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j")
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k")
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- Navigate vim panes better
keymap("n", "<c-k>", ":wincmd k<CR>", { noremap = false, silent = true })
keymap("n", "<c-j>", ":wincmd j<CR>", { noremap = false, silent = true })
keymap("n", "<c-h>", ":wincmd h<CR>", { noremap = false, silent = true })
keymap("n", "<c-l>", ":wincmd l<CR>", { noremap = false, silent = true })

-- UI
-- search highlight
keymap("n", "<leader>uh", ":noh<CR>", defs({ desc = "Clear search highlight" }))
-- keymap("n", "<leader>uh", ":set hlsearch! hlsearch?<CR>", defs({ desc = "Toggle search highlight" }))

-- TODO are there other mappings for toggle relative line numbers?
-- toggle line numbers
keymap("n", "<leader>un", "<cmd>set number! number?<cr>", defs({ desc = "line numbers" }))

-- Copy/Paste
keymap("n", "yp", ':let @*=expand("%")<CR>', defaults)
keymap("n", "yP", ':let @*=expand("%:p")<CR>', defaults)

-- Yank entire file content
keymap("n", "yY", ":%y+<CR>", defaults)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', defaults)

-- quit
keymap("n", "<leader>q", "<cmd>qa<cr>", defs({ desc = "quit" }))

-- don't do this, it creates issues for typing
-- vim.keymap.set('i', 'mw', '<ESC>:w<CR>', { desc = 'Write buffer' })

-- TODO remove any mappings below that wouldn't be part of a base install
--      they shouldn't require installing anything but Neovim

-- set appfolio test_launcher
-- keymap("n", "mtl", ":let test#ruby#rails#executable = 'test_launcher'<CR>", defaults)

-- additional telescope mappings
-- see init.lua for mappings setup as part of kickstarter
-- keymap("n", "<leader>sb", require("telescope.builtin").buffers, { desc = "[S]earch [B]uffers" })

-- Rails.vim Alt file
keymap("n", "mA", ":A<CR>", defaults)

-- run a neovim plugin test file
-- keymap("n", "<leader>Tp", "<Plug>PlenaryTestFile<CR>", { desc = "Test Plugin" })

-- ruby: insert pry debug below cursor
-- keymap("n", "<leader>rP", 'orequire "pry";binding.pry<ESC>', { desc = "Insert Pry" })

-- use tab to cycle through buffers
keymap("n", "<TAB>", buffers.goto_next_buffer, defaults)
-- vim.keymap.set('n', '<TAB>', ':bn<CR>', defaults)

-- use tshift+tab to cycle through tabs
keymap("n", "<S-TAB>", buffers.goto_previous_buffer, defaults)
-- vim.keymap.set('n', '<S-TAB>', ':bp<CR>', defaults)

-- source the current file
keymap("n", "<leader>x", ":source %<CR>")

-- close the current buffer
keymap("n", "<M-w>", ":bd<CR>", defaults)

-- close all other buffers
keymap("n", "<M-W>", buffers.only_buffer, { desc = "Yank qualified class name" })

-- TODO NS is a custom function in for treesitter
keymap("n", "<Leader>cy", NS, { noremap = true, silent = true, desc = "Yank FQ class" })

-- goto tab #
keymap("n", "<M-1>", ":tabnext 1<CR>", defaults)
keymap("n", "<M-2>", ":tabnext 2<CR>", defaults)
keymap("n", "<M-3>", ":tabnext 3<CR>", defaults)
keymap("n", "<M-4>", ":tabnext 4<CR>", defaults)
keymap("n", "<M-5>", ":tabnext 5<CR>", defaults)

-- format sql
-- requires `brew install pgformatter`
keymap("n", "<Leader>fs", ":%!pg_format<CR>", defaults)
keymap("v", "<Leader>fs", ":'<,'>!pg_format<CR>", defaults)

-- Move Lines
keymap("n", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap("n", "<A-k>", ":m .-2<CR>==")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv")
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +2<CR>", defaults)
keymap("n", "<Right>", ":vertical resize -2<CR>", defaults)
keymap("n", "<Up>", ":resize -2<CR>", defaults)
keymap("n", "<Down>", ":resize +2<CR>", defaults)

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Better viewing
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "g,", "g,zvzz")
keymap("n", "g;", "g;zvzz")

-- Add undo break-points
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")

-- Better indent
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Navigate the quickfix list
keymap("n", "<C-:>", "<cmd>cnext<CR>zz", { desc = "Forward qfixlist" })
keymap("n", [[<C-">]], "<cmd>cprev<CR>zz", { desc = "Backward qfixlist" })
