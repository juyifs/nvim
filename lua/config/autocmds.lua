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

vim.api.nvim_set_keymap('n', '<F1>', '', {
    noremap = true,
    callback = function()
        -- 获取相对路径，并将路径中的AAA换成BBB
        local relative_path = vim.fn.expand('%:p:~:.')
        relative_path = string.gsub(relative_path, "AAA", "BBB")
BBB
        -- 拼接比较文件的路径
        local target_path = '/home/test/'..relative_path

        -- 执行垂直分割差异比较
        vim.cmd('vert diffsplit '..target_path)

        --展开折叠
        vim.cmd("norm zR")
    end
})
