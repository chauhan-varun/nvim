-- =============================================================================
-- Autocompletion
-- lua/plugins/completion.lua
-- =============================================================================

return {
  {
    'saghen/blink.cmp',
    event        = 'VimEnter',
    version      = '1.*',
    dependencies = {
      -- Snippet engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        -- Regex support in snippets requires building a C extension
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then return end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- Pre-built snippet collections (VS Code format)
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      enabled = function()
        -- Disable blink.cmp during visual-multi mode to prevent key conflicts
        return not (vim.g.VM_active == 1 or (vim.g.VM and vim.g.VM.is_active == 1))
      end,

      keymap = {
        -- Use 'enter' preset: <CR> accepts, <C-y> also works
        -- <C-space> opens menu, <C-e> closes, <C-k> toggles signature help
        -- <Tab>/<S-Tab> moves through snippet expansion points
        preset = 'enter',
      },

      appearance = {
        -- 'mono' = Nerd Font Mono spacing; 'normal' = standard Nerd Font
        nerd_font_variant = 'mono',
      },

      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
      },

      sources = {
        default   = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          -- Give lazydev completions a very high score so they rank first
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Use the Rust-based fuzzy matcher (downloads a prebuilt binary on first install)
      fuzzy = { implementation = 'prefer_rust_with_warning' },

      -- Show function signature help while typing arguments
      signature = { enabled = true },
    },
  },
}
