---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
  local conform = require('conform')
  for i = 1, select('#', ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

local function expandFormatters(formatters)
  return function(bufnr)
    local result = {}
    for i = 1, #formatters do
      local formatter = formatters[i]
      if type(formatter) == 'table' then
        result[i] = first(bufnr, unpack(formatter))
      else
        result[i] = formatter
      end
    end
    return result
  end
end

return {
  -- Lightweight yet powerful formatter plugin for Neovim
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        html = expandFormatters({ { 'prettier' }, lsp_format = 'fallback' }),
        css = expandFormatters({ { 'prettierd', 'prettier' }, lsp_format = 'fallback' }),
        lua = { 'stylua' },
        -- Conform will run multiple formatters sequentially
        python = { 'isort', 'black', 'ruff' },
        -- Use a sub-list with expandFormatters() to run only the first available formatter
        javascript = expandFormatters({ { 'prettierd', 'prettier' }, lsp_format = 'fallback' }),
        typescript = expandFormatters({ { 'prettierd', 'prettier' }, lsp_format = 'fallback' }),
        svelte = expandFormatters({ { 'prettierd', 'prettier' }, lsp_format = 'fallback' }),
        json = expandFormatters({ { 'prettierd', 'prettier' }, lsp_format = 'fallback' }),
        ruby = { 'rubyfmt', 'rubocop' },
        -- Use the "*" filetype to run formatters on all filetypes.
        -- ['*'] = { 'codespell' },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ['_'] = { 'trim_whitespace' },
      },
    },
  },
  -- An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.
  {
    'mfussenegger/nvim-lint',
    opts = {
      linters = {
        ['markdownlint-cli2'] = {
          args = { '--config', '~/.markdownlint-cli2.yaml', '--' },
        },
      },
      linters_by_ft = {
        go = { 'golangcilint' },
        javascript = { 'eslint_d' },
        python = { 'ruff' },
        ruby = { 'ruby', 'rubocop' },
        typescript = { 'eslint_d' },
      },
    },
  },
  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        'diagnostic-languageserver',
        'gopls',
        'graphql-language-service-cli',
        'rust-analyzer',
        'lua-language-server',
        'basedpyright',
        'tailwindcss-language-server',
        'svelte-language-server',
        'typescript-language-server',
        'yaml-language-server',
      },
    },
  },

  -- Comprehensive taskpaper support for vim (based on davidoc/taskpaper.vim and related repos)
  { 'cweagans/vim-taskpaper' },

  -- Code outline sidebar powered by LSP. Significantly enhanced & refactored fork of symbols-outline.nvim.
  { 'hedyhli/outline.nvim', config = true },

  -- A simple wrapper around :mksession.
  {
    'Shatur/neovim-session-manager',
    opts = function()
      local config = require('session_manager.config')

      return {
        autoload_mode = config.AutoloadMode.CurrentDir,
        autosave_ignore_dirs = { '~' },
      }
    end,
  },

  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function() require('refactoring').setup() end,
  },

  { 'leafOfTree/vim-svelte-plugin' },

  {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    opts = {
      window = {
        mappings = {
          ['w'] = false, -- Remap Vim core motion is a crime
          ['<c-f>'] = false,
          ['<c-b>'] = false,
          ['o'] = 'open', -- Keep the convention from NERDtree
          ['oc'] = false,
          ['od'] = false,
          ['og'] = false,
          ['om'] = false,
          ['on'] = false,
          ['os'] = false,
          ['ot'] = false,
          ['l'] = { 'show_help', nowait = false, config = { title = 'Order by', prefix_key = 'l' } },
          ['lc'] = { 'order_by_created', nowait = false },
          ['ld'] = { 'order_by_diagnostics', nowait = false },
          ['lg'] = { 'order_by_git_status', nowait = false },
          ['lm'] = { 'order_by_modified', nowait = false },
          ['ln'] = { 'order_by_name', nowait = false },
          ['ls'] = { 'order_by_size', nowait = false },
          ['lt'] = { 'order_by_type', nowait = false },
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },

  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },

  -- MoonScript support for vim
  { 'leafo/moonscript-vim' },

  { 'mbbill/undotree' },

  {
    'martineausimon/nvim-lilypond-suite',
    config = function()
      require('nvls').setup({
        -- edit config here (see "Customize default settings" in wiki)
      })
    end,
  },

  { 'rebelot/kanagawa.nvim' },
}
