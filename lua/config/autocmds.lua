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

vim.api.nvim_set_keymap("n", "<F1>", "", {
  noremap = true,
  callback = function()
    -- 获取相对路径，并将路径中的AAA换成BBB
    local relative_path = vim.api.nvim_buf_get_name(0)
    local prefix = "/home/test1"
    relative_path = string.gsub(relative_path, "^" .. prefix, "")
    relative_path = string.gsub(relative_path, "AAA", "BBB")

    -- 拼接比较文件的路径
    local target_path = "/home/test2" .. relative_path

    vim.cmd("LspStop")
    -- 执行垂直分割差异比较
    vim.cmd("vert diffsplit " .. target_path)

    --展开折叠
    vim.cmd("norm zR")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function(args)
    local actions = require("telescope.actions")
    -- 当前 Telescope 的 prompt 缓冲区号
    local prompt_bufnr = args.buf

    -- 定义一个复合动作：导出到 Quickfix，并打开 Quickfix 窗口
    local function send_and_open()
      actions.smart_send_to_qflist(prompt_bufnr)
      actions.open_qflist(prompt_bufnr)
    end

    -- 在插入态和普通态都绑定 <C-q>
    vim.keymap.set("i", "<C-q>", send_and_open, { buffer = prompt_bufnr, desc = "导出到 Quickfix 并打开" })
    vim.keymap.set("n", "<C-q>", send_and_open, { buffer = prompt_bufnr, desc = "导出到 Quickfix 并打开" })
   end,
})
