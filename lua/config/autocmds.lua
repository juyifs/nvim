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
      local build_sh_dir = vim.fn.findfile("build.sh", vim.fn.expand("%:p:h") .. ";")
      if build_sh_dir ~= "" then
        local root = vim.fn.fnamemodify(build_sh_dir, ":h")
        vim.notify("Executed make.sh in " .. root, vim.log.levels.INFO)
        local output = vim.cmd("enew | term bash " .. root .. "/build.sh")
        vim.notify(output, vim.log.levels.WARN)
      else
        vim.notify("Could not find project root", vim.log.levels.ERROR)
      end
    end, { buffer = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "cpp", "c", "h", "hpp" },
  callback = function()
    vim.keymap.set("", "<F8>", function()
      local build_sh_dir = vim.fn.findfile("build.sh", vim.fn.expand("%:p:h") .. ";")
      if build_sh_dir ~= "" then
        local root = vim.fn.fnamemodify(build_sh_dir, ":h")
        vim.notify("Executed make.sh in " .. root, vim.log.levels.INFO)
        local output = vim.cmd("enew | term bash " .. root .. "/build.sh c")
        vim.notify(output, vim.log.levels.WARN)
      else
        vim.notify("Could not find project root", vim.log.levels.ERROR)
      end
    end, { buffer = true })
  end,
})

