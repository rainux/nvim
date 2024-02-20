-- Helper functions  ---------------------------------------------------------------------------------------------- {{{1
--
-- Get the character code under the cursor
local function get_char_code()
  -- Capture the output of :ascii
  local ascii_output = vim.fn.execute('ascii')

  if ascii_output:match('NUL') then
    return 'NUL'
  end

  -- Determine the number format based on encoding
  local nrformat = '0x%02x'
  local encoding = vim.o.fileencoding == '' and vim.o.encoding or vim.o.fileencoding

  if encoding == 'utf-8' then
    nrformat = '0x%04x'
  end

  -- Extract the character and its numeric value from the ascii output
  local char, nr = ascii_output:match('<(.?)>%s*(%d+)')

  -- Format the numeric value
  nr = tonumber(nr)
  if nr then
    nr = string.format(nrformat, nr)
  else
    -- Fallback or error handling if needed
    nr = 'Error'
  end

  return "'" .. char .. "' " .. nr
end
--  --------------------------------------------------------------------------------------------------------------- }}}1

return {
  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
  {
    'nvim-lualine/lualine.nvim',
    opts = function(_, opts)
      local lualine_x = opts['sections']['lualine_x']

      return vim.tbl_deep_extend('force', opts, {
        sections = {
          lualine_x = vim.list_extend({ get_char_code, 'filesize', 'encoding', 'fileformat' }, lualine_x),
        },
        extensions = { 'fugitive', 'lazy', 'mason', 'nvim-tree', 'quickfix', 'symbols-outline', 'trouble' },
      })
    end,
  },
}

-- vim: set fdm=marker fdl=0 textwidth=120:
