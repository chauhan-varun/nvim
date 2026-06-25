-- =============================================================================
-- UI & Aesthetics Plugins
-- lua/plugins/ui.lua
-- =============================================================================

return {

  -- ---------------------------------------------------------------------------
  -- Colorscheme: Tokyo Night (transparent, no italic comments)
  -- ---------------------------------------------------------------------------
  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Load before all other plugins
    config = function()
      require('tokyonight').setup {
        transparent = true,
        styles = {
          comments = { italic = false },
          sidebars = 'transparent',
          floats   = 'transparent',
        },
      }
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  -- ---------------------------------------------------------------------------
  -- Noice: replaces cmdline, messages, and LSP progress with floating windows
  -- ---------------------------------------------------------------------------
  {
    'folke/noice.nvim',
    event        = 'VeryLazy',
    opts         = {},
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
  },

  -- ---------------------------------------------------------------------------
  -- Bufferline: VS Code-style buffer tabs at the top
  -- Tab / S-Tab to cycle. <leader>1-9 to jump by index.
  -- ---------------------------------------------------------------------------
  {
    'akinsho/bufferline.nvim',
    version      = '*',
    event        = 'VeryLazy',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        mode                  = 'buffers',
        separator_style       = 'slant',
        show_buffer_close_icons = true,
        show_close_icon       = false,
        diagnostics           = 'nvim_lsp',
        always_show_bufferline = true,
      },
    },
    keys = {
      { '<Tab>',      '<cmd>BufferLineCycleNext<cr>',    desc = 'Next buffer' },
      { '<S-Tab>',    '<cmd>BufferLineCyclePrev<cr>',    desc = 'Prev buffer' },
      { '<leader>bp', '<cmd>BufferLineTogglePin<cr>',    desc = '[B]uffer [P]in' },
      { '<leader>bc', '<cmd>BufferLinePickClose<cr>',    desc = '[B]uffer [C]lose (pick)' },
      { '<leader>bb', '<cmd>BufferLinePick<cr>',         desc = '[B]uffer [P]ick' },
      { '<leader>1',  '<cmd>BufferLineGoToBuffer 1<cr>', desc = 'Buffer 1' },
      { '<leader>2',  '<cmd>BufferLineGoToBuffer 2<cr>', desc = 'Buffer 2' },
      { '<leader>3',  '<cmd>BufferLineGoToBuffer 3<cr>', desc = 'Buffer 3' },
      { '<leader>4',  '<cmd>BufferLineGoToBuffer 4<cr>', desc = 'Buffer 4' },
      { '<leader>5',  '<cmd>BufferLineGoToBuffer 5<cr>', desc = 'Buffer 5' },
      { '<leader>6',  '<cmd>BufferLineGoToBuffer 6<cr>', desc = 'Buffer 6' },
      { '<leader>7',  '<cmd>BufferLineGoToBuffer 7<cr>', desc = 'Buffer 7' },
      { '<leader>8',  '<cmd>BufferLineGoToBuffer 8<cr>', desc = 'Buffer 8' },
      { '<leader>9',  '<cmd>BufferLineGoToBuffer 9<cr>', desc = 'Buffer 9' },
    },
  },

  -- ---------------------------------------------------------------------------
  -- Smear Cursor: animate cursor movement between lines and buffers
  -- ---------------------------------------------------------------------------
  {
    'sphamba/smear-cursor.nvim',
    opts = {
      smear_between_buffers        = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space          = true,
      legacy_computing_symbols_support = false,
      smear_insert_mode            = true,
    },
  },

  -- ---------------------------------------------------------------------------
  -- Mini.nvim: lightweight collection of small utility modules
  --   mini.ai       — extended text objects (va), yinq, ci', …)
  --   mini.surround — add/delete/replace surroundings (saiw), sd', sr)')
  --   mini.pairs    — auto-close brackets, quotes, parens (replaces nvim-autopairs)
  --   mini.statusline — simple, icon-aware statusline
  -- ---------------------------------------------------------------------------
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      require('mini.pairs').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- Show LINE:COL instead of the default percentage-based location
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },

  -- ---------------------------------------------------------------------------
  -- Todo Comments: highlight TODO, FIXME, NOTE, HACK, etc. in comments
  -- ---------------------------------------------------------------------------
  {
    'folke/todo-comments.nvim',
    event        = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts         = { signs = false },
  },

}

