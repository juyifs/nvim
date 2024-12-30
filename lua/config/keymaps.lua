-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

map("n", "<C-LeftMouse>", function()
  vim.cmd.exec('"normal! \\<LeftMouse>"')

  vim.lsp.buf.definition()
end, { desc = "go to definition" })

map("n", "<A-LeftMouse>", function()
  vim.cmd.exec('"normal! \\<LeftMouse>"')

  vim.lsp.buf.references()
end, { desc = "go to references" })

map("n", "<C-A-LeftMouse>", function()
  vim.cmd.exec('"normal! \\<LeftMouse>"')

  vim.lsp.buf.implementation()
end, { desc = "go to implementation" })

map("n", "<C-Esc>", "<C-o>", { desc = "go back" })
