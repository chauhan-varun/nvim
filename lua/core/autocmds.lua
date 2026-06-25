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

-- ---------------------------------------------------------------------------
-- Fix: Restore blink.cmp autocomplete <CR> mapping after exiting visual-multi
-- ---------------------------------------------------------------------------
vim.api.nvim_create_autocmd('User', {
  pattern  = 'visual_multi_exit',
  desc     = 'Restore blink.cmp keymaps after visual-multi exits',
  group    = vim.api.nvim_create_augroup('visual-multi-blink-fix', { clear = true }),
  callback = function()
    local ok, cmp = pcall(require, 'blink.cmp')
    if ok then
      vim.keymap.set('i', '<CR>', function()
        if cmp.is_visible() then
          return cmp.accept()
        else
          return '<CR>'
        end
      end, { expr = true, replace_keycodes = true })
    end
  end,
})
