-- Override settings of default plugins from LazyVim

return {
  { 'folke/flash.nvim', enabled = false },
  { 'folke/noice.nvim', enabled = false },

  {
    'akinsho/bufferline.nvim',
    opts = {
      options = {
        mode = 'tabs',
      },
    },
  },
}
