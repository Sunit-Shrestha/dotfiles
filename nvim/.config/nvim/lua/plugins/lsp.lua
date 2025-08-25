return {
	{ "mason-org/mason.nvim", opts = {} },
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		opts = {
			servers = {
				lua_ls = {},
				clangd = {},
				pyright = {},
				ts_ls = {},
			},
		},
		config = function(_, opts)
			local lspconfig = require("lspconfig")
			for server, config in pairs(opts.servers) do
				-- passing config.capabilities to blink.cmp merges with the capabilities in your
				-- `opts[server].capabilities, if you've defined it
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "clangd", "pyright", "lua_ls", "ts_ls" },
		},
		dependencies = {
			"mason-org/mason.nvim",
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"eslint_d",
				"pylint",
				"stylua",
				"isort",
				"black",
				"prettierd",
				"prettier",
				"clang-format",
			},
		},
	},
}
