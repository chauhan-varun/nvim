-- =============================================================================
-- Core Autocommands
-- lua/core/autocmds.lua
-- =============================================================================

-- ---------------------------------------------------------------------------
-- Highlight yanked text briefly after copying
-- Try it: yap in normal mode
-- ---------------------------------------------------------------------------
vim.api.nvim_create_autocmd('TextYankPost', {
  desc     = 'Highlight yanked text',
  group    = vim.api.nvim_create_augroup('core-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
