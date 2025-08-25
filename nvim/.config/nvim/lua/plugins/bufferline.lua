return
{
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    vim.opt.termguicolors = true
    vim.api.nvim_set_hl(0, "BufferLineFill", { link = "BufferLineBackground" })
    require("bufferline").setup{
        options = {
          offsets = {
              {
                filetype = "snacks_layout_box",
                separator = true,
                highlight = "Normal",
              },
            },
            always_show_bufferline = false,
        },
    }
  end,
}
