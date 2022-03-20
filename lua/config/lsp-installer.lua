local lsp_installer = require('nvim-lsp-installer')

-- Include the servers you want to have installed by default below
local servers = {
  'sumneko_lua',
  'vimls',
  'yamlls',
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print('Installing ' .. name)
    server:install()
  end
end

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

  if client.resolved_capabilities.document_formatting then
    vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
  end
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Register a handler that will be called for each installed server when it's ready (i.e. when installation is finished
-- or if the server is already installed).
lsp_installer.on_server_ready(function(server)
  local opts = { on_attach = on_attach, capabilities = capabilities }

  if server.name == 'sumneko_lua' then
    opts = vim.tbl_extend('force', opts, require('lsp/sumneko_lua'))
  end

  if server.name == 'rust_analyzer' then
    opts = vim.tbl_extend('force', opts, require('lsp/rust_analyzer'))
    -- Initialize the LSP via rust-tools instead
    require('rust-tools').setup({
      -- The "server" property provided in rust-tools setup function are the
      -- settings rust-tools will provide to lspconfig during init.
      -- We merge the necessary settings from nvim-lsp-installer (server:get_default_options())
      -- with the user's own settings (opts).
      server = vim.tbl_deep_extend('force', server:get_default_options(), opts),
    })
    server:attach_buffers()
    -- Only if standalone support is needed
    require('rust-tools').start_standalone_if_required()
  else
    -- This setup() function will take the provided server configuration and decorate it with the necessary properties
    -- before passing it onwards to lspconfig.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
  end
end)
