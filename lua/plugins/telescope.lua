return {
  -- Find, Filter, Preview, Pick. All lua, all the time.
  {
    'nvim-telescope/telescope.nvim',
    opts = function(_, opts)
      local actions = require('telescope.actions')

      local open_with_trouble = function(...)
        return require('trouble.providers.telescope').open_with_trouble(...)
      end

      return vim.tbl_deep_extend('force', opts, {
        defaults = {
          mappings = {
            i = {
              ['<C-h>'] = actions.which_key,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-t>'] = actions.select_tab,
              ['<c-t>'] = actions.select_tab,
              ['<C-S-t>'] = open_with_trouble,
            },
          },
        },
      })
    end,
  },
}
