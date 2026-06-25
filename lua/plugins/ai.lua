-- =============================================================================
-- AI / Autocomplete Plugins
-- lua/plugins/ai.lua
-- =============================================================================

return {

  -- ---------------------------------------------------------------------------
  -- Supermaven: ultra-fast, lightweight AI code completion
  --   <C-n>        — accept full suggestion
  --   <C-j>        — accept next word
  --   <C-l>        — accept next line
  --   <C-e>        — clear/dismiss suggestion
  --   <leader>ts   — toggle Supermaven on/off
  -- ---------------------------------------------------------------------------
  {
    'supermaven-inc/supermaven-nvim',
    event = 'VeryLazy',
    config = function()
      require('supermaven-nvim').setup {
        keymaps = {
          accept_suggestion = '<C-n>',
          clear_suggestion  = '<C-e>',
          accept_word       = '<C-j>',
        },
      }

      -- Toggle Supermaven on or off with user-friendly notifications
      vim.keymap.set('n', '<leader>ts', function()
        local api = require 'supermaven-nvim.api'
        if api.is_running() then
          api.stop()
          vim.notify('Supermaven stopped', vim.log.levels.INFO, { title = 'Supermaven' })
        else
          api.start()
          vim.notify('Supermaven started', vim.log.levels.INFO, { title = 'Supermaven' })
        end
      end, { desc = '[T]oggle [S]upermaven' })
    end,
  },
}
