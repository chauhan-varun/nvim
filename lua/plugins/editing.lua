-- =============================================================================
-- Editing Plugins
-- lua/plugins/editing.lua
-- =============================================================================

return {

  -- ---------------------------------------------------------------------------
  -- vim-sleuth: automatically detect indentation (tabstop / shiftwidth)
  -- ---------------------------------------------------------------------------
  'tpope/vim-sleuth',

  -- ---------------------------------------------------------------------------
  -- vim-visual-multi: multi-cursor editing (like VS Code Ctrl+D)
  --   <C-n>   — select word under cursor / next match
  --   \\A      — select all matches
  -- ---------------------------------------------------------------------------
  {
    'mg979/vim-visual-multi',
    branch = 'master',
  },

  -- ---------------------------------------------------------------------------
  -- auto-save: silently save on InsertLeave and TextChanged
  -- Using okuuva/auto-save (the original Pocco81 repo is abandoned)
  -- ---------------------------------------------------------------------------
  {
    'okuuva/auto-save.nvim',
    config = function()
      require('auto-save').setup {
        enabled = true,
        execution_message = {
          enabled          = true,
          message          = function() return '' end, -- No message shown
          dim              = 0,
          cleaning_interval = 0,
        },
        trigger_events = { 'InsertLeave', 'TextChanged' },
      }
    end,
  },

  -- ---------------------------------------------------------------------------
  -- nvim-ts-autotag: auto-close and auto-rename HTML / JSX tags
  -- ---------------------------------------------------------------------------
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
    opts  = {},
  },

}
