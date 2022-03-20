require('nvim-lightbulb').setup({
  -- LSP client names to ignore
  -- Example: {"sumneko_lua", "null-ls"}
  ignore = {},
})

vim.cmd([[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]])
