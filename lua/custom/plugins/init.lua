-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- lazy.nvim
  {
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
    'max397574/better-escape.nvim',
    config = function()
      require('better_escape').setup()
    end,
  },
  {
    'kdheepak/lazygit.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<cr>', { desc = 'Open LazyGit' })
    end,
  },

  {
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

      copilot.setup {
        suggestion = {
          enabled = true, -- must be explicitly true
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

      -- Toggle Copilot suggestions with <leader>ct
      local enabled = true
      vim.keymap.set('n', '<leader>ct', function()
        enabled = not enabled
        copilot.setup {
          suggestion = {
            enabled = enabled,
            auto_trigger = enabled,
            keymap = {
              accept = '<C-l>',
              accept_word = '<C-j>',
              accept_line = '<C-k>',
              next = '<C-]>',
              prev = '<C-[>',
              dismiss = '<C-e>',
            },
          },
          panel = { enabled = true },
        }
        print(enabled and 'ﮧ Copilot ON' or ' Copilot OFF')
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
    'mg979/vim-visual-multi',
    branch = 'master',
  },
  {
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
    'stevearc/oil.nvim',
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      skip_confirm_for_simple_edits = true,
      delete_to_trash = false,
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional (icons)
    },
  },
}
