require('project_nvim').setup({
  patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json' },
  exclude_dirs = {},
  silent_chdir = true,
})
