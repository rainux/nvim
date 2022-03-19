local wk = require('which-key')

require('gitsigns').setup({
  signs = {
    add = { hl = 'GitSignsAdd', text = '+', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
    change = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    delete = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },

  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    -- Actions
    wk.register({
      h = {
        name = 'Gitsigns Hunk Actions',
        s = { '<cmd>Gitsigns stage_hunk<CR>', 'Stage Hunk' },
        r = { '<cmd>Gitsigns reset_hunk<CR>', 'Reset Hunk' },
        u = { gs.undo_stage_hunk, 'Undo Stage Hunk' },
        S = { gs.stage_buffer, 'Stage Buffer' },
        R = { gs.reset_buffer, 'Reset Buffer' },
        p = { gs.preview_hunk, 'Preview Hunk' },
        b = {
          function()
            gs.blame_line({ full = true })
          end,
          'Blame Line',
        },
        d = { gs.diffthis, 'Diff This with HEAD' },
        D = {
          function()
            gs.diffthis('~')
          end,
          'Diff This with Previous Commit',
        },
      },
      tb = { gs.toggle_current_line_blame, 'Gitsigns Current Line Blame' },
      td = { gs.toggle_deleted, 'Gitsigns Deleted' },
    }, { mode = 'n', prefix = ',', buffer = bufnr })

    wk.register({
      hs = { '<cmd>Gitsigns stage_hunk<CR>', 'Gitsigns Stage Hunk' },
      hr = { '<cmd>Gitsigns reset_hunk<CR>', 'Gitsigns Reset Hunk' },
    }, { mode = 'v', prefix = ',', buffer = bufnr })

    -- Text object
    wk.register({
      ih = { ':<C-U>Gitsigns select_hunk<CR>', 'Gitsigns Select Hunk' },
    }, { mode = 'o', buffer = bufnr })
    wk.register({
      ih = { ':<C-U>Gitsigns select_hunk<CR>', 'Gitsigns Select Hunk' },
    }, { mode = 'x', buffer = bufnr })
  end,
})
