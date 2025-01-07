-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp", "c", "h", "hpp" },
  callback = function()
    vim.keymap.set("", "<F7>", function()
      local root = vim.fn.finddir(".git/..", vim.fn.expand("%:p:h") .. ";")
      if root ~= "" then
        print("Executed make.sh in " .. root)
        vim.fn.system("sh " .. root .. "/make.sh")
      else
        print("Could not find project root")
      end
    end, { buffer = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp", "c", "h", "hpp" },
  callback = function()
    vim.keymap.set("", "<F8>", function()
      local root = vim.fn.finddir(".git/..", vim.fn.expand("%:p:h") .. ";")
      if root ~= "" then
        print("Executed clean.sh in " .. root)
        vim.fn.system("sh " .. root .. "/clean.sh")
      else
        print("Could not find project root")
      end
    end, { buffer = true })
  end,
})
