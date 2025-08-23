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
    'mg979/vim-visual-multi',
    branch = 'master',
  },
}
