local wk = require('which-key')
local gitsigns = require('gitsigns')

local options = {
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
}

require('lvim.core.gitsigns').config()
gitsigns.setup(vim.tbl_extend('force', lvim.builtin.gitsigns.opts, options))
