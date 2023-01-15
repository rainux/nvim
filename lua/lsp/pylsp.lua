local M = {}

-- Disable autopep8 and yapf to use black
M.settings = {
  pylsp = {
    plugins = {
      autopep8 = {
        enabled = false,
      },
      yapf = {
        enabled = false,
      },
    },
  },
}

return M
