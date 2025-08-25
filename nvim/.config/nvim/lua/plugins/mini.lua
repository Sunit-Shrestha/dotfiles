return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.ai").setup()
		require("mini.icons").setup()
		require("mini.pairs").setup()
		require("mini.surround").setup({
			mappings = {
				add = "ys",
			},
		})
		require("mini.splitjoin").setup()
	end,
}
