-- Helper functions  ---------------------------------------------------------------------------------------------- {{{1
--
-- Get the character code under the cursor
local function get_char_code()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()

  -- Adjust column index to be 1-based
  col = col + 1

  -- Check if the cursor is at the end of the line
  if col > #line then
    return 'NUL'
  end

  local char = line:sub(col, col)

  if char == '' then
    return 'NUL'
  end

  local char_code = vim.fn.char2nr(char)
  if char_code == 0 then
    return 'NUL'
  end

  local char_code_str = string.format('0x%04x', char_code)

  -- Escape '%' character to avoid lualine crash
  if char == '%' then
    char = '%%'
  end

  return "'" .. char .. "' " .. char_code_str
end

local function get_mixed_wordcount()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
  local chinese_char_count = 0
  local english_word_count = 0

  for _, line in ipairs(lines) do
    -- 统计中文字符（包括所有 CJK 统一汉字）
    for _ in line:gmatch('[%z\1-\127\194-\244][\128-\191]*') do
      local char = line:match('[%z\1-\127\194-\244][\128-\191]*')
      local code = char:byte(1, -1)
      if code >= 0xE4 and code <= 0xE9 then
        chinese_char_count = chinese_char_count + 1
      end
    end

    -- 统计英文单词（支持撇号、连字符、数字）
    for _ in line:gmatch("[A-Za-z0-9]+[A-Za-z0-9'%-]*") do
      english_word_count = english_word_count + 1
    end
  end

  return string.format('%d 字, %d words', chinese_char_count, english_word_count)
end
--  --------------------------------------------------------------------------------------------------------------- }}}1

return {
  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
  {
    'nvim-lualine/lualine.nvim',
    opts = function(_, opts)
      local lualine_x = opts['sections']['lualine_x']
      local lualine_y = opts['sections']['lualine_y']

      return vim.tbl_deep_extend('force', opts, {
        sections = {
          lualine_x = { get_mixed_wordcount, get_char_code, 'filesize', 'encoding', 'fileformat' },
          lualine_y = lualine_x,
          lualine_z = lualine_y,
        },
        extensions = { 'fugitive', 'lazy', 'mason', 'nvim-tree', 'quickfix', 'symbols-outline', 'trouble' },
      })
    end,
  },
  -- Color schemes
  { 'rainux/base16-vim' },
  { 'LunarVim/onedarker.nvim' },
  { 'lunarvim/darkplus.nvim' },
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('cyberdream').setup({
        -- Recommended - see "Configuring" below for more config options
        transparent = true,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = true,
        terminal_colors = true,
      })
      -- vim.cmd('colorscheme cyberdream') -- set the colorscheme
    end,
  },
}

-- vim: set fdm=marker fdl=0 textwidth=120:
