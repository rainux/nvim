local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  local command = { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  packer_bootstrap = fn.system(command)
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost ~/.config/nvim/lua/plugins.lua source <afile> | PackerCompile
  augroup end
]])

local function require_config(name)
  return string.format('require("config/%s")', name)
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  -- Searchers  ................................................................................................... {{{1
  --
  -- .............................................................................................................. }}}1

  -- General text editing  ........................................................................................ {{{1
  --
  -- A Vim alignment plugin
  use('junegunn/vim-easy-align')
  -- Delete/change/add parentheses/quotes/XML-tags/much more with ease
  use('tpope/vim-surround')
  -- .............................................................................................................. }}}1

  -- IDE like experience  ......................................................................................... {{{1
  --
  -- Vim plugin that displays tags in a window, ordered by scope.
  use('preservim/tagbar')
  -- Asynchronous build and test dispatcher
  use({ 'tpope/vim-dispatch', cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } })
  -- .............................................................................................................. }}}1

  -- LSP support  ................................................................................................. {{{1
  --
  -- Portable package manager for Neovim that runs everywhere Neovim runs.
  -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
  use({
    'williamboman/mason.nvim',
    requires = {
      'neovim/nvim-lspconfig',
    },
  })
  use({
    'williamboman/mason-lspconfig.nvim',
    config = require_config('mason-lspconfig'),
  })
  -- LSP Progress lualine componenet
  use('arkav/lualine-lsp-progress')
  -- Pop-up menu for code actions to show meta-information and diff preview
  use({ 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' })
  -- VSCode 💡 for neovim's built-in LSP.
  use({ 'kosayoda/nvim-lightbulb', config = require_config('lightbulb') })
  -- VS Code-like renaming UI for Neovim, writen in Lua.
  use({ 'abzcoding/renamer.nvim', branch = 'develop', config = require_config('renamer') })
  -- A completion plugin for neovim coded in Lua.
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',

      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'rafamadriz/friendly-snippets',
    },
    config = require_config('cmp'),
  })
  use({ 'uga-rosa/cmp-dictionary', config = require_config('cmp-dictionary') })
  -- Nvim Treesitter configurations and abstraction layer
  use({ 'nvim-treesitter/nvim-treesitter', config = require_config('treesitter'), run = ':TSUpdate' })
  use({ 'nvim-treesitter/nvim-treesitter-textobjects' })
  -- Treesitter playground integrated into Neovim
  use({ 'nvim-treesitter/playground' })
  -- A tree like view for symbols in Neovim using the Language Server Protocol.
  use('simrat39/symbols-outline.nvim')
  -- Highlight arguments' definitions and usages, using Treesitter
  use({
    'm-demare/hlargs.nvim',
    requires = { 'nvim-treesitter/nvim-treesitter' },
    config = require_config('hlargs'),
  })
  -- .............................................................................................................. }}}1

  -- Programming Language Support  ................................................................................ {{{1
  --
  -- Tools for better development in rust using neovim's builtin lsp
  use('simrat39/rust-tools.nvim')
  -- Modern Go plugin for Neovim, based on gopls, treesitter AST, Dap and a variety of go tools.
  use({ 'ray-x/go.nvim', config = require_config('go') })
  use('ray-x/guihua.lua') -- recommanded if need floating window support
  -- JSON manipulation and pretty printing
  -- use('tpope/vim-jdaddy')
  -- .............................................................................................................. }}}1

  -- General programming support  ................................................................................. {{{1
  --
  -- GitHub Copilot
  use({ 'github/copilot.vim', config = require_config('copilot') })
  -- Even better % navigate and highlight matching words, modern matchit and matchparen
  use({ 'andymass/vim-matchup' })
  -- A super powerful autopair plugin for Neovim that supports multiple characters.
  use({ 'windwp/nvim-autopairs', config = require_config('autopairs') })
  -- Use treesitter to autoclose and autorename html tag
  use({ 'windwp/nvim-ts-autotag', config = require_config('ts-autotag') })
  -- Wisely add "end" in Ruby, Vimscript, Lua, etc. Tree-sitter aware alternative to tpope's vim-endwise
  use({ 'RRethy/nvim-treesitter-endwise', config = require_config('endwise') })
  -- Indent guides for Neovim
  use({ 'lukas-reineke/indent-blankline.nvim', config = require_config('indent-blankline') })
  -- Vim plugin for intensely nerdy commenting powers
  use({ 'preservim/nerdcommenter', config = require_config('nerdcommenter') })
  -- Smart and Powerful commenting plugin for neovim
  use({ 'numToStr/Comment.nvim', config = require_config('comment') })
  -- A Vim plugin making it more convenient to compile or run a single source file.
  use({ 'xuhdev/SingleCompile', cmd = { 'SCCompile', 'SCCompileRun' } })
  -- Switch between single-line and multiline forms of code
  use('AndrewRadev/splitjoin.vim')
  -- .............................................................................................................. }}}1

  -- Productivity tools  .......................................................................................... {{{1
  --
  -- Comprehensive taskpaper support for vim (based on davidoc/taskpaper.vim and related repos)
  use('cweagans/vim-taskpaper')
  -- Easily interact with tmux from vim
  use({ 'preservim/vimux', requires = { 'jtdowney/vimux-cargo' }, config = require_config('vimux') })
  -- .............................................................................................................. }}}1

  -- Toys  ........................................................................................................ {{{1
  --
  -- Ascii drawing plugin: lines, ellipses, arrows, fills, and more!
  use({ 'vim-scripts/DrawIt', keys = { '\\di' } })
  -- Matrix screensaver for VIM
  use({ 'vim-scripts/matrix.vim--Yang', cmd = { 'Matrix' } })
  -- .............................................................................................................. }}}1

  -- Automatically set up configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- vim: set fdm=marker fdl=1 tw=120:
