-- ============================================================
--  Custom Plugins
--  lua/custom/plugins/init.lua
-- ============================================================

return {

  -- ──────────────────────────────────────────────────────────
  --  UI & AESTHETICS
  -- ──────────────────────────────────────────────────────────

  -- Replaces default cmdline, messages, notifications, and LSP
  -- progress with floating windows. Makes Neovim feel modern.
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {},
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify', -- optional: styled notification popups
    },
  },

  -- Animates cursor movement across buffers, windows, and lines.
  {
    'sphamba/smear-cursor.nvim',
    opts = {
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
      legacy_computing_symbols_support = false,
      smear_insert_mode = true,
    },
  },

  -- VS Code-like buffer tabs at the top of the screen.
  -- Tab / S-Tab to cycle. <leader>1-9 to jump to a specific buffer.
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'VeryLazy',
    opts = {
      options = {
        mode = 'buffers',
        separator_style = 'slant',
        show_buffer_close_icons = true,
        show_close_icon = false,
        diagnostics = 'nvim_lsp',
        always_show_bufferline = true,
      },
    },
    keys = {
      { '<Tab>',      '<cmd>BufferLineCycleNext<cr>',    desc = 'Next buffer' },
      { '<S-Tab>',    '<cmd>BufferLineCyclePrev<cr>',    desc = 'Prev buffer' },
      { '<leader>bp', '<cmd>BufferLineTogglePin<cr>',    desc = 'Pin buffer' },
      { '<leader>bc', '<cmd>BufferLinePickClose<cr>',    desc = 'Pick buffer to close' },
      { '<leader>bb', '<cmd>BufferLinePick<cr>',         desc = 'Pick buffer' },
      { '<leader>1',  '<cmd>BufferLineGoToBuffer 1<cr>' },
      { '<leader>2',  '<cmd>BufferLineGoToBuffer 2<cr>' },
      { '<leader>3',  '<cmd>BufferLineGoToBuffer 3<cr>' },
      { '<leader>4',  '<cmd>BufferLineGoToBuffer 4<cr>' },
      { '<leader>5',  '<cmd>BufferLineGoToBuffer 5<cr>' },
      { '<leader>6',  '<cmd>BufferLineGoToBuffer 6<cr>' },
      { '<leader>7',  '<cmd>BufferLineGoToBuffer 7<cr>' },
      { '<leader>8',  '<cmd>BufferLineGoToBuffer 8<cr>' },
      { '<leader>9',  '<cmd>BufferLineGoToBuffer 9<cr>' },
    },
  },

  -- ──────────────────────────────────────────────────────────
  --  NAVIGATION
  -- ──────────────────────────────────────────────────────────

  -- Jump anywhere on screen instantly with a 1-2 char label.
  -- s = flash jump | S = treesitter jump | r = remote (operator-pending)
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      char = { jump_labels = true },
    },
    keys = {
      { 's',     mode = { 'n', 'x', 'o' }, function() require('flash').jump() end,              desc = 'Flash' },
      { 'S',     mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end,        desc = 'Flash Treesitter' },
      { 'r',     mode = 'o',               function() require('flash').remote() end,             desc = 'Remote Flash' },
      { 'R',     mode = { 'o', 'x' },      function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
      { '<c-s>', mode = { 'c' },           function() require('flash').toggle() end,             desc = 'Toggle Flash Search' },
    },
  },

  -- Yazi file manager inside Neovim.
  -- <leader>-  = open at current file
  -- <leader>cw = open at cwd
  -- <leader>ut = resume last session
  {
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    keys = {
      { '<leader>-',  '<cmd>Yazi<cr>',        desc = 'Open yazi at current file' },
      { '<leader>cw', '<cmd>Yazi cwd<cr>',    desc = 'Open yazi at cwd' },
      { '<leader>ut', '<cmd>Yazi toggle<cr>', desc = 'Resume last yazi session' },
    },
    opts = {
      open_for_directories = true,
      keymaps = { show_help = '<f1>' },
    },
  },

  -- ──────────────────────────────────────────────────────────
  --  EDITING
  -- ──────────────────────────────────────────────────────────

  -- Multi-cursor support (like VS Code Ctrl+D).
  -- C-n = select next match | \\A = select all matches
  {
    'mg979/vim-visual-multi',
    branch = 'master',
  },

  -- Escape from insert mode with jk or jj — no plugin needed.
  vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Escape insert mode' }),
  vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Escape insert mode' }),

  -- Auto-save on InsertLeave and TextChanged. Silent (no message shown).
  -- Using okuuva's fork — the original Pocco81 repo is abandoned.
  {
    'okuuva/auto-save.nvim',
    config = function()
      require('auto-save').setup {
        enabled = true,
        execution_message = {
          enabled = true,
          message = function() return '' end,
          dim = 0,
          cleaning_interval = 0,
        },
        trigger_events = { 'InsertLeave', 'TextChanged' },
      }
    end,
  },

  -- Auto close and rename HTML/JSX tags using Treesitter.
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },

  -- ──────────────────────────────────────────────────────────
  --  AI / COPILOT
  -- ──────────────────────────────────────────────────────────

  -- GitHub Copilot inline suggestions.
  -- C-n = accept | C-j = accept word | C-l = accept line | C-e = dismiss
  -- <leader>ct = toggle Copilot on/off
  -- NOTE: C-n conflicts with vim-visual-multi's next-match — pick one.
  {
    'zbirenbaum/copilot.lua',
    event = { 'InsertEnter' },
    build = ':Copilot auth',
    config = function()
      local copilot = require 'copilot'
      local copilot_command = require 'copilot.command'

      copilot.setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept      = '<C-n>',
            accept_word = '<C-j>',
            accept_line = '<C-l>',
            next        = '<C-]>',
            prev        = '<C-[>',
            dismiss     = '<C-e>',
          },
        },
        panel = { enabled = true },
      }

      local enabled = true
      vim.keymap.set('n', '<leader>ct', function()
        enabled = not enabled
        copilot_command[enabled and 'enable' or 'disable']()
        print(enabled and 'Copilot ON' or 'Copilot OFF')
      end, { desc = 'Toggle Copilot' })
    end,
  },

  -- Chat with Copilot directly inside Neovim.
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'zbirenbaum/copilot.lua',
    },
    config = function()
      require('CopilotChat').setup()
    end,
  },

  -- ──────────────────────────────────────────────────────────
  --  GIT
  -- ──────────────────────────────────────────────────────────

  -- Full LazyGit UI inside Neovim. <leader>gg to open.
  {
    'kdheepak/lazygit.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'Open LazyGit' })
    end,
  },
  
  -- Solve LeetCode problems without leaving Neovim.
  {
    'kawre/leetcode.nvim',
    opts = {},
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
  },
}
