-- =============================================================================
-- AI / Autocomplete Plugins
-- lua/plugins/ai.lua
-- =============================================================================

return {

  -- ---------------------------------------------------------------------------
  -- Supermaven: ultra-fast, lightweight AI code completion
  --   <C-n>  — accept full suggestion
  --   <C-j>  — accept next word
  --   <C-l>  — accept next line
  --   <C-e>  — clear/dismiss suggestion
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
    end,
  },
}
