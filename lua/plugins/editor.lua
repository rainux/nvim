return {
  -- A Git wrapper so awesome, it should be illegal.
  { 'tpope/vim-fugitive' },
  -- A Vim plugin that opens a link to the current line on GitHub (and also supports Bitbucket, self-deployed GitHub,
  -- Googlesource and GitLab).
  { 'ruanyl/vim-gh-line' },

  -- Better fold markers
  {
    'dbmrq/vim-chalk',
    config = function()
      vim.g.chalk_char = '.'
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
