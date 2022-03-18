local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  local command = { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
  packer_bootstrap = fn.system(command)
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

function require_config(name)
  return string.format('require("config/%s")', name)
end

return require('packer').startup(function()
  -- Packer can manage itself
  use('wbthomason/packer.nvim')

  -- Neovim core feature extension  ............................................................................... {{{1
  --
  -- Better fold markers
  use({ 'dbmrq/vim-chalk', config = require_config('chalk') })
  -- Easy foldtext customization for [neo]vim.
  use({
    'scr1pt0r/crease.vim',
    config = function()
      vim.g.crease_foldtext = { default = ' %t %= %l lines  ' }
    end,
  })
  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = require_config('lualine'),
  })
  -- A file explorer tree for neovim written in lua
  use({
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = require_config('nvim-tree'),
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
  })
  -- Intelligently reopen files at your last edit position in Vim.
  use('farmergreg/vim-lastplace')
  -- Color schemes
  use('rainux/base16-vim')
  -- .............................................................................................................. }}}1

  -- Searchers  ................................................................................................... {{{1
  --
  -- Find, Filter, Preview, Pick. All lua, all the time.
  use({
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = require_config('telescope'),
  })
  -- A command-line fuzzy finder
  use({ 'junegunn/fzf.vim', requires = { 'junegunn/fzf' }, config = require_config('fzf') })
  -- .............................................................................................................. }}}1

  -- General text editing  ........................................................................................ {{{1
  --
  -- A Vim alignment plugin
  use('junegunn/vim-easy-align')
  -- Delete/change/add parentheses/quotes/XML-tags/much more with ease
  use('tpope/vim-surround')
  -- .............................................................................................................. }}}1

  -- Git support  ................................................................................................. {{{1
  --
  -- A Git wrapper so awesome, it should be illegal.
  use('tpope/vim-fugitive')
  -- Git integration for buffers
  use({
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = require_config('gitsigns'),
  })
  -- A Vim plugin that opens a link to the current line on GitHub (and also supports Bitbucket, self-deployed GitHub,
  -- Googlesource and GitLab).
  use('ruanyl/vim-gh-line')
  -- .............................................................................................................. }}}1

  -- IDE like experience  ......................................................................................... {{{1
  --
  -- Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
  use({ 'dense-analysis/ale', config = require_config('ale') })
  -- Vim plugin that displays tags in a window, ordered by scope.
  use('preservim/tagbar')
  -- Asynchronous build and test dispatcher
  use({ 'tpope/vim-dispatch', cmd = { 'Dispatch', 'Make', 'Focus', 'Start' } })
  -- The fancy start screen for Vim.
  use({ 'mhinz/vim-startify', config = require_config('startify') })
  -- .............................................................................................................. }}}1

  -- LSP support  ................................................................................................. {{{1
  --
  -- Nvim Treesitter configurations and abstraction layer
  use({ 'nvim-treesitter/nvim-treesitter', config = require_config('treesitter'), run = ':TSUpdate' })
  -- A tree like view for symbols in Neovim using the Language Server Protocol.
  use('simrat39/symbols-outline.nvim')
  -- .............................................................................................................. }}}1

  -- General programming support  ................................................................................. {{{1
  --
  -- GitHub Copilot
  use('github/copilot.vim')
  -- Even better % navigate and highlight matching words, modern matchit and matchparen
  use({ 'andymass/vim-matchup', event = 'VimEnter' })
  -- Closes brackets. Perfect companion to vim-endwise. Basically, a more conservative version of auto-pairs that only
  -- works when you press Enter.
  use('rstacruz/vim-closer')
  -- Wisely add "end" in ruby, endfunction/endif/more in vim script, etc
  use('tpope/vim-endwise')
  -- Indent guides for Neovim
  use({
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup({
        show_current_context = true,
        show_current_context_start = true,
      })
    end,
  })
  -- Vim plugin for intensely nerdy commenting powers
  use({
    'preservim/nerdcommenter',
    config = function()
      vim.g.NERDDefaultNesting = 1
      vim.g.NERDSpaceDelims = 1
    end,
  })
  -- A Vim plugin making it more convenient to compile or run a single source file.
  use({ 'xuhdev/SingleCompile', cmd = { 'SCCompile', 'SCCompileRun' } })
  -- Switch between single-line and multiline forms of code
  use('AndrewRadev/splitjoin.vim')
  -- .............................................................................................................. }}}1

  -- Productivity tools  .......................................................................................... {{{1
  --
  -- Comprehensive taskpaper support for vim (based on davidoc/taskpaper.vim and related repos)
  use('cweagans/vim-taskpaper')
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

-- vim: fdm=marker fdl=0 tw=120:
