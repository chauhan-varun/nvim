-- Emmet
vim.lsp.config('emmet_ls', {
  filetypes = { 'html', 'css', 'javascriptreact', 'typescriptreact' },
  on_attach = on_attach,
  capabilities = capabilities,
})
