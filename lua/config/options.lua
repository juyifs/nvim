-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.g.autoformat = false

vim.opt.relativenumber = false

vim.o.guifont = "JetBrainsMono Nerd Font:h18"
if vim.g.neovide then
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
  vim.g.neovide_detach_on_quit = 'always_quit'
end

-- 设置 tab 键占用 4 个字符空间
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop=4

vim.opt.wrap = true

-- 自动搜索当前及父级目录的 tags 文件
vim.opt.tags = "./tags;,tags;"

vim.o.background = 'light'

vim.g.root_spec = { { ".git", ".nvim.lua", "lua" }, "lsp", "cwd" }
