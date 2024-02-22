return {
  {
    'neovim/nvim-lspconfig',
    init = function()
      local keys = require('lazyvim.plugins.lsp.keymaps').get()
      -- Disable <C-k> for nvim-cmp
      keys['<c-k>'] = { false }
    end,
  },
}
