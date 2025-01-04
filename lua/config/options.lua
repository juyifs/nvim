-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.g.autoformat = false

vim.opt.relativenumber = false

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font:h18"
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
  vim.g.neovide_detach_on_quit = 'always_quit'
end

-- 设置 tab 键占用 4 个字符空间
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
