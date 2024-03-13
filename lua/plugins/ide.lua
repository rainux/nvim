return {
  -- Lightweight yet powerful formatter plugin for Neovim
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        css = { { 'prettierd', 'prettier' } },
        lua = { 'stylua' },
        -- Conform will run multiple formatters sequentially
        python = { 'black', 'ruff' },
        -- Use a sub-list to run only the first available formatter
        javascript = { { 'prettierd', 'prettier' } },
        ruby = { 'rubyfmt', 'rubocop' },
      },
    },
  },
  -- An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters_by_ft = {
        go = { 'golangcilint' },
        javascript = { 'eslint_d' },
        typescript = { 'eslint_d' },
        python = { 'ruff' },
        ruby = { 'ruby', 'rubocop' },
        markdown = { 'vale' },
      },
    },
  },
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'diagnostic-languageserver',
        'gopls',
        'grammarly-languageserver',
        'graphql-language-service-cli',
        'rust-analyzer',
        'lua-language-server',
        'pyright',
        'tailwindcss-language-server',
        'typescript-language-server',
        'yaml-language-server',
      },
    },
  },

  -- Code outline sidebar powered by LSP. Significantly enhanced & refactored fork of symbols-outline.nvim.
  { 'hedyhli/outline.nvim', config = true },

  -- -- Tools for better development in rust using neovim's builtin lsp
  -- { 'simrat39/rust-tools.nvim' },
  -- -- A feature-rich Go development plugin, leveraging gopls, treesitter AST, Dap, and various Go tools to enhance the
  -- -- dev experience.
  -- { 'ray-x/go.nvim' },
  -- { 'ray-x/guihua.lua' }, -- recommanded if need floating window support

  -- MoonScript support for vim
  { 'leafo/moonscript-vim' },
}
