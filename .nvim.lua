local ctx = require("exrc").init()
ctx:lsp_setup({
	require("lspconfig").clangd.setup({
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--header-insertion=iwyu",
			"--completion-style=detailed",
			"--function-arg-placeholders",
			"--fallback-style=llvm",
			"--query-driver=/opt/toolchain/gcc_*",
		},
	}),
	require("telescope").setup({
		pickers = {
			find_files = {
				search_dirs = { "/AA/BB", "/AA/CC", ".nvim.lua" },
			},
			live_grep = {
				search_dirs = { "/AA/BB", "/AA/CC", ".nvim.lua" },
			},
			grep_string = {
				search_dirs = { "/AA/BB", "/AA/CC", ".nvim.lua" },
			},
			lsp_dynamic_workspace_symbols = {
				search_dirs = { "/AA/BB", "/AA/CC", ".nvim.lua" },
			},
		},
		    extensions = {
		      live_grep_args = {
		        search_dirs = {
		          "/AA/BB","/AA/CC"
		        },
		      }
		    },
		}),
})
require("telescope").load_extension("live_grep_args")
