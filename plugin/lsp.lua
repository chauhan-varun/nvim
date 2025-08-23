-- Emmet
require('lspconfig').emmet_ls.setup {
  filetypes = { 'html', 'css', 'javascriptreact', 'typescriptreact' },
  on_attach = on_attach,
  capabilities = capabilities,
}
