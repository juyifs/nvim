return {
  {
    "jedrzejboczar/exrc.nvim",
    dependencies = { "neovim/nvim-lspconfig" }, -- (optional)
    config = true,
    opts = { --[[ your config ]]
    },
  },

  {
    "zbirenbaum/neodim",
    event = "LspAttach",
    lazy = true,
    config = function()
      require("neodim").setup({
        alpha = 0.75,
        blend_color = "#000000",
        hide = {
          underline = true,
          virtual_text = true,
          signs = true,
        },
        regex = {
          "[uU]nused",
          "[nN]ever [rR]ead",
          "[nN]ot [rR]ead",
        },
        priority = 128,
        disable = {},
      })
    end,
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      bigfile = {
        size = 30 * 1024 * 1024,
      },
    },
  },
  {
    "folke/trouble.nvim",
    opts = {
      modes = {
        lsp = {
          win = { position = "bottom" },
        },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
    },
    opts = function()
      local telescope = require("telescope")
      local entry_display = require("telescope.pickers.entry_display")

      -- 辅助函数：获取 Treesitter 层级上下文
      local function get_line_context(bufnr, lnum)
        local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
        if not ok or not parser then
          return ""
        end

        local tree = parser:parse()[1]
        if not tree then
          return ""
        end

        -- TS 行号 0-indexed
        local node = tree:root():named_descendant_for_range(lnum - 1, 0, lnum - 1, -1)
        local breadcrumbs = {}

        -- 【改进点】：定义一个内部函数，深度优先搜索第一个 identifier 节点
        local function find_name_node(n)
          if not n then
            return nil
          end
          -- 优先检查 TS 规定的 name 或 declarator 字段
          local target = n:field("name")[1] or n:field("declarator")[1]
          if target then
            -- 如果找到的是 identifier，直接返回；否则继续深挖
            if target:type():find("identifier") then
              return target
            end
            return find_name_node(target)
          end
          -- 兜底：如果没有字段名，递归找第一个名为 identifier 的子节点
          for i = 0, n:child_count() - 1 do
            local child = n:child(i)
            if child:type():find("identifier") then
              return child
            end
            -- 限制递归深度，避免过度消耗性能
            local deep = find_name_node(child)
            if deep then
              return deep
            end
          end
          return nil
        end

        local current = node
        while current do
          local type = current:type()
          if type:find("function") or type:find("class") or type:find("method") or type:find("struct") then
            local name_node = find_name_node(current)
            if name_node then
              local text = vim.treesitter.get_node_text(name_node, bufnr)
              if text and #text < 50 then
                table.insert(breadcrumbs, 1, text)
              end
            end
          end
          current = current:parent()
        end

        return #breadcrumbs > 0 and (" 󰆧 " .. table.concat(breadcrumbs, " > ")) or ""
      end

      -- 自定义 Entry Maker：保留原始功能并注入 Context
      local function custom_make_entry(entry)
        local make_displayer = require("telescope.pickers.entry_display")
        local make_entry = require("telescope.make_entry")

        -- 1. 处理原始数据提取 (兼容 LSP Table 和 Grep String)
        local filename, lnum, col, text
        if type(entry) == "string" then
          -- 如果是字符串 (live_grep)，使用内置解析器
          local vimgrep_entry = make_entry.gen_from_vimgrep({ path_display = { "filename_first" } })(entry)
          if not vimgrep_entry then
            return nil
          end
          filename, lnum, col, text = vimgrep_entry.filename, vimgrep_entry.lnum, vimgrep_entry.col, vimgrep_entry.text
        else
          -- 如果是 Table (lsp_references)，直接读取
          filename = entry.filename or vim.api.nvim_buf_get_name(entry.bufnr or 0)
          lnum = entry.lnum or 1
          col = entry.col or 1
          text = entry.text or ""
        end

        -- 2. 定义显示布局 (使用 nil 实现紧凑间距)
        local displayer = make_displayer.create({
          separator = " ",
          items = {
            { width = nil }, -- 文件名 (自适应)
            { width = nil }, -- 层级 (自适应)
            { width = nil }, -- 行列号 (自适应)
            { remaining = true }, -- 内容
          },
        })

        -- 3. 返回构造后的 Entry 对象
        return {
          value = entry,
          -- ordinal 用于搜索过滤，必须是字符串
          ordinal = string.format("%s %s", filename, text),
          display = function(et)
            -- 实时获取 Treesitter 上下文
            local bufnr = vim.fn.bufnr(filename)
            if bufnr == -1 then
              bufnr = vim.fn.bufadd(filename)
              vim.fn.bufload(bufnr)
            end
            local context = get_line_context(bufnr, lnum)

            local display_filename = vim.fn.fnamemodify(filename, ":t")

            return displayer({
              { display_filename, "TelescopeResultsFileName" },
              { context, "TelescopeResultsVariable" },
              { string.format("%d:%d", lnum, col), "TelescopeResultsLineNr" },
              { text:gsub("^%s*", ""), "" }, -- 去除内容开头的空格，让布局更紧凑
            })
          end,
          filename = filename,
          lnum = lnum,
          col = col,
        }
      end

      return {
        defaults = {
          theme = "dropdown",
          scroll_strategy = "limit",
          path_display = { "filename_first" },
          layout_strategy = "vertical",
          layout_config = {
            width = 0.9,
            height = 0.9,
            preview_cutoff = 15,
          },
          -- 在全局默认配置中启用自定义渲染（如果你希望 live_grep 等也生效）
          -- entry_maker = custom_make_entry,
        },

        extensions = {
          live_grep_args = {
            auto_quoting = true, -- 保持插件默认功能
            -- 核心：为扩展指定自定义的 entry_maker
            entry_maker = custom_make_entry,
            -- 你原本可能有的 mappings 配置...
          },
        },

        pickers = {
          -- 针对特定搜索开启层级显示
          live_grep = { entry_maker = custom_make_entry },
          grep_string = { entry_maker = custom_make_entry },
          lsp_references = {
            include_declaration = true,
            include_current_line = true,
            entry_maker = custom_make_entry, -- 引用列表里显示层级非常有用
          },
          lsp_document_symbols = {
            fname_width = 50,
            symbol_width = 50,
            symbol_type_width = 30,
          },
          lsp_dynamic_workspace_symbols = {
            fname_width = 50,
            symbol_width = 50,
            symbol_type_width = 30,
          },
        },
      }
    end,
  },
  {
    "Mr-LLLLL/interestingwords.nvim",
    opts = {
      colors = {
        "#aeee00",
        "#ff0000",
        "#0000ff",
        "#b88823",
        "#ffa724",
        "#ff2c4b",
        "#FF5733",
        "#33FF57",
        "#3357FF",
        "#FF33A8",
        "#FFD133",
        "#33FFF5",
        "#A833FF",
        "#FF8C33",
        "#33FF8C",
        "#8C33FF",
        "#FF3333",
        "#33FF33",
        "#3333FF",
        "#FFB733",
        "#33B7FF",
        "#B733FF",
        "#FF33D1",
        "#33FFD1",
        "#D1FF33",
        "#FF6633",
      },
      cancel_color_key = "<leader>a",
    },
  },
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        -- 关闭名称截断
        truncate_names = false,
        -- 设置最大文件名长度（设为足够大的值）
        max_name_length = 50,
        always_show_bufferline = true,
      },
    },
  },
  {
    "http://gitlab.com/itaranto/plantuml.nvim",
    version = "*",
    config = function()
      require("plantuml").setup({
        renderer = {
          type = "image",
          options = {
            prog = "feh",
            dark_mode = false,
            format = nil, -- Allowed values: nil, 'png', 'svg'.
          },
        },
        render_on_write = true,
      })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
  {
    "ZSaberLv0/ZFVimDirDiff",
    dependencies = { "ZSaberLv0/ZFVimJob" },
    cmd = "ZFDirDiff", -- 按需加载
  },
  {
    "tiagovla/scope.nvim",
    config = true,
    opts = function()
      require("telescope").load_extension("scope")
    end,
  },
  {
    "aklt/plantuml-syntax",
    -- ft = { "plantuml", "puml", "pu" },
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("everforest").setup({
        background = "medium",
      })
    end,
  },
  {
    "jmacadie/telescope-hierarchy.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
      },
    },
    keys = {
      { -- lazy style key map
        -- Choose your own keys, this works for me
        "<leader>si",
        "<cmd>Telescope hierarchy incoming_calls<cr>",
        desc = "LSP: [S]earch [I]ncoming Calls",
      },
      {
        "<leader>so",
        "<cmd>Telescope hierarchy outgoing_calls<cr>",
        desc = "LSP: [S]earch [O]utgoing Calls",
      },
    },
    opts = {
      -- don't use `defaults = { }` here, do this in the main telescope spec
      extensions = {
        hierarchy = {
          -- telescope-hierarchy.nvim config, see below
        },
        -- no other extensions here, they can have their own spec too
      },
    },
    config = function(_, opts)
      -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
      -- configs for us. We won't use data, as everything is in it's own namespace (telescope
      -- defaults, as well as each extension).
      require("telescope").setup(opts)
      require("telescope").load_extension("hierarchy")
    end,
  },
  {
    "lionyxml/gitlineage.nvim",
    dependencies = {
      "sindrets/diffview.nvim", -- optional, for open_diff feature
    },
    config = function()
      require("gitlineage").setup()
    end,
  },
}
