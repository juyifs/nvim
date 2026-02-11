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
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    },
    opts = function()
      local telescope = require("telescope")
      telescope.load_extension("live_grep_args")
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
        },
        pickers = {
          lsp_references = {
            include_declaration = true,
            include_current_line = true,
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
            '#aeee00', 
            '#ff0000', 
            '#0000ff', 
            '#b88823', 
            '#ffa724', 
            '#ff2c4b', 
            '#FF5733',
            '#33FF57',
            '#3357FF',
            '#FF33A8',
            '#FFD133',
            '#33FFF5',
            '#A833FF',
            '#FF8C33',
            '#33FF8C',
            '#8C33FF',
            '#FF3333',
            '#33FF33',
            '#3333FF',
            '#FFB733',
            '#33B7FF',
            '#B733FF',
            '#FF33D1',
            '#33FFD1',
            '#D1FF33',
            '#FF6633',
          },
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
      colorscheme = "starry",
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
    "ray-x/starry.nvim",
    lazy = false, -- 立即加载
    priority = 1000, -- 确保在其他插件之前加载
    config = {
      style = {
        name = "dracula",
      },
      custom_highlights = {
        CursorLine = { bg = '#c0c0c0' , underline = true },
        Visual = { 
            bg = '#c0c0c0', -- 设置你想要的选中背景颜色（十六进制）
            fg = 'NONE',    -- 设置选中文本的前景颜色（NONE 表示保持原样）
            bold = true     -- 可选：是否加粗
        },
      },
    },
  },
}
