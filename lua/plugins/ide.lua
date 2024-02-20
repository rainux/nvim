return {
  -- Lightweight yet powerful formatter plugin for Neovim
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform will run multiple formatters sequentially
        python = { 'isort', 'black', 'ruff' },
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

  -- MoonScript support for vim
  { 'leafo/moonscript-vim' },
}
