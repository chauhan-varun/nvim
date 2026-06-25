-- =============================================================================
-- Miscellaneous Plugins
-- lua/plugins/misc.lua
-- =============================================================================

return {

  -- ---------------------------------------------------------------------------
  -- Trouble: beautiful diagnostics, LSP references, TODOs panel
  --   <leader>xx  — all project diagnostics
  --   <leader>xX  — current buffer diagnostics only
  --   <leader>cs  — document symbols sidebar
  --   <leader>cl  — LSP definitions + references in one panel
  --   <leader>xQ  — quickfix list (replaces plain :copen)
  -- ---------------------------------------------------------------------------
  {
    'folke/trouble.nvim',
    cmd  = 'Trouble',
    opts = { focus = true }, -- auto-focus the trouble window when opened
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>',               desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',  desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>cs', '<cmd>Trouble symbols toggle<cr>',                   desc = '[C]ode [S]ymbols (Trouble)' },
      { '<leader>cl', '<cmd>Trouble lsp toggle<cr>',                       desc = '[C]ode LSP refs/defs (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>',                    desc = 'Quickfix List (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>',                   desc = 'Location List (Trouble)' },
    },
  },


  -- ---------------------------------------------------------------------------
  -- which-key: show pending keymap completions in a popup
  -- ---------------------------------------------------------------------------
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts  = {
      delay = 0, -- Show immediately (independent of timeoutlen)
      icons = {
        mappings = vim.g.have_nerd_font,
        -- Only provide text fallbacks when there is no Nerd Font available
        keys = vim.g.have_nerd_font and {} or {
          Up    = '<Up> ',   Down  = '<Down> ',
          Left  = '<Left> ', Right = '<Right> ',
          C     = '<C-…> ',  M     = '<M-…> ',
          D     = '<D-…> ',  S     = '<S-…> ',
          CR    = '<CR> ',   Esc   = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp   = '<ScrollWheelUp> ',
          NL    = '<NL> ',   BS    = '<BS> ',
          Space = '<Space> ', Tab  = '<Tab> ',
          F1  = '<F1>',  F2  = '<F2>',  F3  = '<F3>',  F4  = '<F4>',
          F5  = '<F5>',  F6  = '<F6>',  F7  = '<F7>',  F8  = '<F8>',
          F9  = '<F9>',  F10 = '<F10>', F11 = '<F11>', F12 = '<F12>',
        },
      },
      -- Named groups shown in the which-key popup
      spec = {
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>f', group = 'Find' },
        { '<leader>b', group = '[B]uffer' },
        { '<leader>c', group = '[C]ode' },
      },
    },
  },

  -- ---------------------------------------------------------------------------
  -- LeetCode: solve LeetCode problems without leaving Neovim
  -- ---------------------------------------------------------------------------
  {
    'kawre/leetcode.nvim',
    opts         = {},
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
  },
}
