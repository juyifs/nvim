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
  vim.lsp.buf.references()
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
  map("", "<D-s>", "<cmd>w<cr><esc>")
else
  map("", "<C-v>", '"+p') -- Paste
  map("", "<C-c>", '"+y') -- Copy
  map("", "<C-x>", '"+x') -- Cut
  map("i", "<C-v>", '<Esc>"+pa')
end

map("v", "d", '"_d', { noremap = true, silent = true })

map("n", "<leader>tt", ":enew | term<CR>", { noremap = true, silent = true })

map("", "<leader>ss", require("telescope.builtin").lsp_document_symbols, { desc = "Goto Symbol" })

map("", "<leader>gb", function ()
  require("telescope.builtin").git_bcommits_range(
    {
      cwd = vim.fn.finddir(".git/..", vim.fn.expand("%:p:h") .. ";"),
    }
  )
end, { desc = "Git Line Log" })

map("", "<leader>gs", function ()
  require("telescope.builtin").git_status(
    {
      cwd = vim.fn.finddir(".git/..", vim.fn.expand("%:p:h") .. ";"),
    }
  )
end , {desc = "Status"})
map("", "<leader>gc", function ()
  require("telescope.builtin").git_commits(
    {
      cwd = vim.fn.finddir(".git/..", vim.fn.expand("%:p:h") .. ";"),
    }
  )
end, {desc = "Commits"} )

-- lazygit
if vim.fn.executable("lazygit") == 1 then
  map("n", "<leader>gg", function() Snacks.lazygit( { cwd = vim.fn.finddir(".git/..", vim.fn.expand("%:p:h") .. ";") }) end, { desc = "Lazygit (Root Dir)" })
  map("n", "<leader>gG", function() Snacks.lazygit({ cwd = vim.fn.expand("%:p:h") }) end, { desc = "Lazygit (cwd)" })
  map("n", "<leader>gf", function() Snacks.picker.git_log_file() end, { desc = "Git Current File History" })
  map("n", "<leader>gl", function() Snacks.picker.git_log( { cwd = vim.fn.finddir(".git/..", vim.fn.expand("%:p:h") .. ";") }) end, { desc = "Git Log" })
  map("n", "<leader>gL", function() Snacks.picker.git_log({ cwd = vim.fn.expand("%:p:h") }) end, { desc = "Git Log (cwd)" })
  map("n", "<leader>gb", function() Snacks.picker.git_log_line() end, { desc = "Git Log Line" })
end

map("n", "<leader>tg", ":Telescope tags<CR>", { silent = true, desc = "Search tags" })
map("n", "<leader>tr", function()
    vim.schedule(function()
      -- 异步生成当前目录 tags
        vim.fn.system("ctags -R --extras=+q .")
    end)
  end, { silent = true, desc = "Rebuild tags" })

map("n", "<leader>sg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", {desc = "Grep (root dir)"})
map("n", "<leader>sw", ":lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<CR>", {desc = "Word (root dir)"})
map("n", "<leader>sf", ":lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor_current_buffer()<CR>", {desc = "Word (current file)"})

map("n", "<leader>cp", function()
  vim.fn.setreg("+", vim.fn.expand("%:p"))
  print("Copied path: " .. vim.fn.expand("%:p"))
end, { noremap = true, silent = true, desc = "Copy File Path" })

map("n", "<leader>wD", function ()
    vim.cmd("bd")
    vim.defer_fn(function ()
        vim.cmd("e!")
    end, 100)
    vim.defer_fn(function ()
        vim.api.nvim_feedkeys("zR", "n", false)
    end, 300)
end, {desc = "close window and buffer"})

map("n", "<leader>tn", function ()
    vim.cmd("tabnew")
end, {desc = "create new tab" })
map("n", "<leader>td", function ()
    vim.cmd("tabclose")
end, {desc = "close tab" })
