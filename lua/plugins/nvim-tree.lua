return {
  -- A file explorer tree for neovim written in lua
  {
    'nvim-tree/nvim-tree.lua',
    opts = {
      tab = {
        sync = {
          open = true,
          close = true,
        },
      },
    },
  },
}
