-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map({ "n", "v" }, "<C-LeftMouse>", function()
  vim.cmd.exec('"normal! \\<LeftMouse>"')
  vim.lsp.buf.definition()
end, { desc = "go to definition" })

map({ "n", "v" }, "<A-LeftMouse>", function()
  vim.cmd.exec('"normal! \\<LeftMouse>"')
  require('telescope.builtin').lsp_references()
end, { desc = "find references" })

map({ "n", "v" }, "<A-RightMouse>", function()
  vim.cmd.exec('"normal! \\<LeftMouse>"')
  vim.lsp.buf.implementation()
end, { desc = "find implementation" })

local uname = vim.loop.os_uname()

if uname.sysname == "Darwin" then
  --macos--
  map("", "<D-v>", '"+p') -- Paste
  map("", "<D-c>", '"+y') -- Copy
  map("", "<D-x>", '"+x') -- Cut
  map("i", "<D-v>", '<Esc>"+pa')
else
  map("", "<C-v>", '"+p') -- Paste
  map("", "<C-c>", '"+y') -- Copy
  map("", "<C-x>", '"+x') -- Cut
  map("i", "<C-v>", '<Esc>"+pa')
end

map('v', 'd', '"_d', { noremap = true, silent = true })
