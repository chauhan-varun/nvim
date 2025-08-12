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
  {
    'Exafunction/codeium.vim',
    event = 'BufEnter',
    config = function()
      -- Disable default bindings
      vim.g.codeium_disable_bindings = 1

      -- Custom keybindings
      vim.keymap.set('i', '<C-j>', function()
        return vim.fn['codeium#Accept']()
      end, { expr = true, silent = true })
      -- Toggle Codeium on/off
      vim.keymap.set('n', '<leader>ct', function()
        if vim.g.codeium_enabled == 1 then
          vim.g.codeium_enabled = 0
          print 'Codeium Disabled'
        else
          vim.g.codeium_enabled = 1
          print 'Codeium Enabled'
        end
      end, { desc = 'Toggle Codeium' })

      vim.keymap.set('i', '<C-;>', function()
        return vim.fn['codeium#CycleCompletions'](1)
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-,>', function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end, { expr = true, silent = true })
      vim.keymap.set('i', '<C-x>', function()
        return vim.fn['codeium#Clear']()
      end, { expr = true, silent = true })

      -- Enable for specific filetypes
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'jsx', 'tsx', 'js', 'ts' },
        callback = function()
          vim.g.codeium_enabled = 1
        end,
      })
    end,
  },
  {
    'mg979/vim-visual-multi',
    branch = 'master',
  },
}
