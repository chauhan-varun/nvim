-- =============================================================================
-- Navigation Plugins
-- lua/plugins/navigation.lua
-- =============================================================================

return {

  -- ---------------------------------------------------------------------------
  -- Flash: jump anywhere on screen with 1-2 character labels
  --   s         — jump (normal / visual / operator)
  --   S         — Treesitter-aware jump
  --   r         — remote flash (operator-pending)
  --   R         — Treesitter search (operator / visual)
  --   <C-s>     — toggle flash in command mode
  -- ---------------------------------------------------------------------------
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts  = {
      char = { jump_labels = true },
    },
    keys = {
      { 's',     mode = { 'n', 'x', 'o' }, function() require('flash').jump() end,               desc = 'Flash' },
      { 'S',     mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end,         desc = 'Flash Treesitter' },
      { 'r',     mode = 'o',               function() require('flash').remote() end,              desc = 'Remote Flash' },
      { 'R',     mode = { 'o', 'x' },      function() require('flash').treesitter_search() end,  desc = 'Treesitter Search' },
      { '<c-s>', mode = { 'c' },           function() require('flash').toggle() end,              desc = 'Toggle Flash Search' },
    },
  },

  -- ---------------------------------------------------------------------------
  -- Yazi: terminal file manager embedded in Neovim
  --   -           — open yazi at the current file's directory
  --   <leader>cw  — open yazi at the current working directory
  --   <leader>ut  — resume the last yazi session
  -- ---------------------------------------------------------------------------
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    keys  = {
      { '-',          '<cmd>Yazi<cr>',        desc = 'Open yazi at current file' },
      { '<leader>cw', '<cmd>Yazi cwd<cr>',    desc = 'Open yazi at cwd' },
      { '<leader>ut', '<cmd>Yazi toggle<cr>', desc = 'Resume last yazi session' },
    },
    opts = {
      open_for_directories = true,
      keymaps              = { show_help = '<f1>' },
    },
  },
}
