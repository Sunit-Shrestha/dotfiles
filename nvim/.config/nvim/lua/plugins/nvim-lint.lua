return {
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				python = { "pylint" },
			}
			vim.keymap.set("n", "<leader>l", lint.try_lint, { desc = "Try linting" })
		end,
	},
}
