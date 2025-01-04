-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map({ "n", "v" }, "<C-LeftMouse>", vim.lsp.buf.definition, { desc = "go to definition" })

map({ "n", "v" }, "<A-LeftMouse>", vim.lsp.buf.references, { desc = "find references" })

map({ "n", "v" }, "<A-RightMouse>", vim.lsp.buf.implementation, { desc = "find implementation" })

map("", "<D-v>", '"+p') -- Paste
map("", "<D-c>", '"+y') -- Copy
map("", "<D-x>", '"+x') -- Cut
map("i","<D-v>", '<Esc>"+pa')
