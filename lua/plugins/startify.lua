-- Define the functions to get git modified and untracked files
local function gitModified()
  local handle = io.popen('git ls-files -m 2>/dev/null')
  if not handle then
    return {}
  end

  local result = handle:read('*a')
  handle:close()
  local files = {}
  for line in result:gmatch('[^\r\n]+') do
    table.insert(files, { line = line, path = line })
  end
  return files
end

local function gitUntracked()
  local handle = io.popen('git ls-files -o --exclude-standard 2>/dev/null')
  if not handle then
    return {}
  end

  local result = handle:read('*a')
  handle:close()
  local files = {}
  for line in result:gmatch('[^\r\n]+') do
    table.insert(files, { line = line, path = line })
  end
  return files
end

return {
  -- The fancy start screen for Vim.
  {
    'mhinz/vim-startify',
    config = function()
      vim.g.startify_lists = {
        { type = 'files', header = { '   MRU' } },
        { type = 'dir', header = { '   MRU ' .. vim.fn.getcwd() } },
        { type = 'sessions', header = { '   Sessions' } },
        { type = 'bookmarks', header = { '   Bookmarks' } },
        { type = gitModified, header = { '   git modified' } },
        { type = gitUntracked, header = { '   git untracked' } },
        { type = 'commands', header = { '   Commands' } },
      }
    end,
  },
}
