require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'gopls',
    'rust_analyzer',
    'sumneko_lua',
    'vimls',
    'yamlls',
  }
})

local buf_map = function(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
    silent = true,
  })
end

local on_attach = function(client, bufnr)
  vim.cmd('command! LspDef lua vim.lsp.buf.definition()')
  vim.cmd('command! LspFormatting lua vim.lsp.buf.formatting()')
  vim.cmd('command! LspCodeAction lua vim.lsp.buf.code_action()')
  vim.cmd('command! LspHover lua vim.lsp.buf.hover()')
  vim.cmd('command! LspRename lua vim.lsp.buf.rename()')
  vim.cmd('command! LspRefs lua vim.lsp.buf.references()')
  vim.cmd('command! LspTypeDef lua vim.lsp.buf.type_definition()')
  vim.cmd('command! LspImplementation lua vim.lsp.buf.implementation()')
  vim.cmd('command! LspDiagPrev lua vim.diagnostic.goto_prev()')
  vim.cmd('command! LspDiagNext lua vim.diagnostic.goto_next()')
  vim.cmd('command! LspDiagLine lua vim.diagnostic.open_float()')
  vim.cmd('command! LspSignatureHelp lua vim.lsp.buf.signature_help()')

  buf_map(bufnr, 'n', 'gd', '<cmd>LspDef<CR>')
  buf_map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  buf_map(bufnr, 'n', 'gi', '<cmd>LspImplementation<CR>')
  buf_map(bufnr, 'n', 'gr', '<cmd>LspRefs<CR>')
  buf_map(bufnr, 'n', ',rn', '<cmd>lua require("renamer").rename()<CR>')
  buf_map(bufnr, 'n', 'gy', '<cmd>LspTypeDef<CR>')
  buf_map(bufnr, 'n', 'K', '<cmd>LspHover<CR>')
  buf_map(bufnr, 'n', '[d', '<cmd>LspDiagPrev<CR>')
  buf_map(bufnr, 'n', ']d', '<cmd>LspDiagNext<CR>')
  buf_map(bufnr, 'n', 'ga', '<cmd>LspCodeAction<CR>')
  buf_map(bufnr, 'n', ',ca', '<cmd>CodeActionMenu<CR>')
  buf_map(bufnr, 'n', '<Leader>a', '<cmd>LspDiagLine<CR>')
  buf_map(bufnr, 'i', '<C-k>', '<cmd>LspSignatureHelp<CR>')
  buf_map(bufnr, 'n', '<Leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>')

  buf_map(bufnr, 'n', ',rr', '<cmd>RustRunnable<CR>')

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('Format', { clear = true }),
      buffer = bufnr,
      callback = function() vim.lsp.buf.formatting_seq_sync() end
    })
  end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local options = { on_attach = on_attach, capabilities = capabilities }

require('mason-lspconfig').setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require('lspconfig')[server_name].setup(options)
  end,

  ['sumneko_lua'] = function()
    options = vim.tbl_extend('force', options, require('lsp/sumneko_lua'))

    require('lspconfig').sumneko_lua.setup(options)
  end,

  ['rust_analyzer'] = function()
    -- TODO: Broken after migrate to mason
    options = vim.tbl_extend('force', options, require('lsp/rust_analyzer'))
    local server = require('lspconfig').rust_analyzer
    -- Initialize the LSP via rust-tools instead
    require('rust-tools').setup({
      -- The "server" property provided in rust-tools setup function are the
      -- settings rust-tools will provide to lspconfig during init.
      -- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
      -- with the user's own settings (opts).
      -- server = vim.tbl_deep_extend('force', server:get_default_options(), options),
    })
    -- server:attach_buffers()
    -- Only if standalone support is needed
    -- require('rust-tools').start_standalone_if_required()
  end
}
