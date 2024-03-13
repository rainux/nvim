-- Explicitly list plugins for easier disable/enable
--
-- Since LazyVim will load plugins from other .lua file, we have to set `enabled = false`
-- rather than just comment out to disable a plugin.

return {
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
  },
  {
    'ray-x/go.nvim',
    dependencies = { -- optional packages
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup()
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },

  -- A completion plugin for neovim coded in Lua.
  {
    'hrsh7th/nvim-cmp',
    opts = function(_, opts) --  {{{1
      local cmp = require('cmp')

      return vim.tbl_deep_extend('force', opts, {
        mapping = {
          ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),

          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        },
      })
    end, --  }}}1
  },
  -- A dictionary completion source for nvim-cmp
  { 'uga-rosa/cmp-dictionary' },

  -- Lightweight yet powerful formatter plugin for Neovim
  { 'stevearc/conform.nvim' },
  -- An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.
  { 'mfussenegger/nvim-lint' },

  -- -- Tools for better development in rust using neovim's builtin lsp
  -- { 'simrat39/rust-tools.nvim' },
  -- A feature-rich Go development plugin, leveraging gopls, treesitter AST, Dap, and various Go tools to enhance the
  -- dev experience.
  -- { 'ray-x/go.nvim' },
  -- { 'ray-x/guihua.lua' }, -- recommanded if need floating window support

  -- MoonScript support for vim
  { 'leafo/moonscript-vim' },

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },
    },
  },
}

-- vim: set fdm=marker fdl=0 textwidth=120:
