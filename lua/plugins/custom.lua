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
    opts = {
      defaults = {
        theme = "dropdown",
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
    },
  },
  {
    "Mr-LLLLL/interestingwords.nvim",
    opts = {},
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
      colorscheme = "lunaperche",
    },
  },
}
