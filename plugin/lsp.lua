-- Emmet LSP configuration
vim.lsp.config('emmet_ls', {
  filetypes = { 'html', 'css', 'javascriptreact', 'typescriptreact' },
})

-- Enable the emmet_ls server
vim.lsp.enable('emmet_ls')
