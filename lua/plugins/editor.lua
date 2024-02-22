return {
  -- A Git wrapper so awesome, it should be illegal.
  { 'tpope/vim-fugitive' },
  -- An interactive and powerful Git interface for Neovim, inspired by Magit
  { 'NeogitOrg/neogit', dependencies = { 'sindrets/diffview.nvim' }, config = true },
  -- A Vim plugin that opens a link to the current line on GitHub (and also supports Bitbucket, self-deployed GitHub,
  -- Googlesource and GitLab).
  { 'ruanyl/vim-gh-line' },

  -- Use the w, e, b motions like a spider. Move by subwords and skip insignificant punctuation.
  { 'chrisgrieser/nvim-spider', lazy = true },
  -- Bundle of more than 30 new text objects for Neovim.
  { 'chrisgrieser/nvim-various-textobjs', lazy = false, opts = { useDefaultKeymaps = false } },

  -- Better fold markers
  {
    'dbmrq/vim-chalk',
    config = function()
      vim.g.chalk_char = '-'
      vim.g.chalk_edit = 0

      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = { '*.vim', '*.lua', '*.ts' },
        callback = function(autocmd)
          vim.api.nvim_buf_set_var(autocmd.buf, 'chalk_space_before', 1)
        end,
      })
    end,
  },
}
