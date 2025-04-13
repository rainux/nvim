-- Override settings of default plugins from LazyVim

return {
  { 'folke/flash.nvim', enabled = false },
  { 'folke/noice.nvim', enabled = false },
  { 'echasnovski/mini.ai', enabled = false },
  { 'echasnovski/mini.pairs', enabled = false },
  { 'sindrets/diffview.nvim', enabled = false },
  { 'echasnovski/mini.animate', enabled = false },
  { 'karb94/neoscroll.nvim', enabled = false },

  {
    'akinsho/bufferline.nvim',
    opts = {
      options = {
        mode = 'tabs',
      },
    },
  },

  {
    'echasnovski/mini.comment',
    opts = {
      mappings = {
        comment = ',c',
        comment_line = ',cc',
        comment_visual = ',c',
        textobject = ',c',
      },
    },
  },
}
