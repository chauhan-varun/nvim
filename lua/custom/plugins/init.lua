-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- lazy.nvim
  {
    -- Noice
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
  },
  {
    -- Better escape
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup()
    end,
  },
  {
    -- Lazy git
    'kdheepak/lazygit.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'Open LazyGit' })
    end,
  },

  {
    -- Auto save
    'Pocco81/auto-save.nvim',
    config = function()
      require('auto-save').setup {
        enabled = true,
        execution_message = {
          enabled = true,
          message = function()
            return ''
          end, -- show nothing
          dim = 0, -- no dimming
          cleaning_interval = 0, -- no fade-out
        },
        trigger_events = { 'InsertLeave', 'TextChanged' },
      }
    end,
  },
  -- GitHub Copilot
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
            accept = '<C-n>',
            accept_word = '<C-j>',
            accept_line = '<C-l>',
            next = '<C-]>',
            prev = '<C-[>',
            dismiss = '<C-e>',
          },
        },
        panel = { enabled = true },
      }

      -- Keep Copilot enabled by default.
      local enabled = true
      vim.keymap.set('n', '<leader>ct', function()
        enabled = not enabled
        copilot_command[enabled and 'enable' or 'disable']()
        print(enabled and 'Copilot ON' or 'Copilot OFF')
      end, { desc = 'Toggle Copilot' })
    end,
  },
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
  {
    -- Multi cursor
    'mg979/vim-visual-multi',
    branch = 'master',
  },
  {
    -- Smear cursor
    'sphamba/smear-cursor.nvim',
    opts = {
      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = true,

      -- Smear cursor when moving within line or to neighbor lines.
      -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
      smear_between_neighbor_lines = true,

      -- Draw the smear in buffer space instead of screen space when scrolling
      scroll_buffer_space = true,

      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears and particles will look a lot less blocky.
      legacy_computing_symbols_support = false,

      -- Smear cursor in insert mode.
      -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
      smear_insert_mode = true,
    },
  },
  {
    ---@type 'mikavilpas/yazi.nvim'
    'mikavilpas/yazi.nvim',
    event = 'VeryLazy',
    keys = {
      -- 👇 in this section, choose your own keybindings!
      {
        '<leader>-',
        '<cmd>Yazi<cr>',
        desc = 'Open yazi at the current file',
      },
      {
        -- Open in the current working directory
        '<leader>cw',
        '<cmd>Yazi cwd<cr>',
        desc = "Open the file manager in nvim's working directory",
      },
      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 (not yet released)
        '<leader>ut',
        '<cmd>Yazi toggle<cr>',
        desc = 'Resume the last yazi session',
      },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },

  -- Flash: Jump anywhere instantly
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      char = {
        jump_labels = true,
      },
    },
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },

  -- Auto close/rename HTML tags
  {
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },

  -- Bufferline: VS Code-like buffer tabs
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
      { '<Tab>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
      { '<S-Tab>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
      { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = 'Pin buffer' },
      { '<leader>bc', '<cmd>BufferLinePickClose<cr>', desc = 'Pick buffer to close' },
      { '<leader>bb', '<cmd>BufferLinePick<cr>', desc = 'Pick buffer' },
      { '<leader>1', '<cmd>BufferLineGoToBuffer 1<cr>' },
      { '<leader>2', '<cmd>BufferLineGoToBuffer 2<cr>' },
      { '<leader>3', '<cmd>BufferLineGoToBuffer 3<cr>' },
      { '<leader>4', '<cmd>BufferLineGoToBuffer 4<cr>' },
      { '<leader>5', '<cmd>BufferLineGoToBuffer 5<cr>' },
      { '<leader>6', '<cmd>BufferLineGoToBuffer 6<cr>' },
      { '<leader>7', '<cmd>BufferLineGoToBuffer 7<cr>' },
      { '<leader>8', '<cmd>BufferLineGoToBuffer 8<cr>' },
      { '<leader>9', '<cmd>BufferLineGoToBuffer 9<cr>' },
    },
  },
  {
    'ThePrimeagen/vim-be-good',
    cmd = 'VimBeGood',
    keys = {
      { '<leader>tg', '<cmd>VimBeGood<cr>', desc = 'Practice: VimBeGood' },
    },
  },
  {
    'kawre/leetcode.nvim',
    opts = {},
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
  },
}
