return {
  {
    -- A completion plugin for neovim coded in Lua.
    'hrsh7th/nvim-cmp',
    opts = function(_, opts)
      local cmp = require('cmp')

      return vim.tbl_deep_extend('force', opts, {
        mapping = {
          ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),

          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        },
        sources = cmp.config.sources({
          { name = 'dictionary', keyword_length = 2 },
        }),
      })
    end,
  },
  -- A dictionary completion source for nvim-cmp
  {
    'uga-rosa/cmp-dictionary',
    opts = {
      paths = { vim.fn.stdpath('config') .. '/assets/english.dict' },
      exact_length = 2,
      first_case_insensitive = true,
      document = {
        enable = false,
        command = { 'wn', '${label}', '-over' },
      },
    },
  },
}
