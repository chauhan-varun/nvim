-- =============================================================================
-- Snacks.nvim — folke's utility collection
-- lua/plugins/snacks.lua
--
-- Replaces:
--   kdheepak/lazygit.nvim          → snacks.lazygit
--   lukas-reineke/indent-blankline → snacks.indent
--   rcarriga/nvim-notify           → snacks.notifier
--
-- Adds (new capabilities):
--   snacks.scroll   — smooth scrolling
--   snacks.words    — highlight all refs of word under cursor + [[ / ]] jump
--   snacks.rename   — file rename that also updates LSP import paths
--   snacks.quickfile — faster opening of small files on startup
--   snacks.bigfile  — auto-disables heavy features (treesitter, etc.) on huge files
-- =============================================================================

return {
  {
    'folke/snacks.nvim',
    priority = 1000, -- Load early so vim.notify is overridden before other plugins send messages
    lazy     = false,
    ---@type snacks.Config
    opts = {

      -- -----------------------------------------------------------------------
      -- bigfile: disable treesitter/LSP/etc. for files over 1.5 MB
      -- -----------------------------------------------------------------------
      bigfile = { enabled = true },

      -- -----------------------------------------------------------------------
      -- quickfile: read and render files before the plugin stack fully loads
      -- -----------------------------------------------------------------------
      quickfile = { enabled = true },

      -- -----------------------------------------------------------------------
      -- indent: animated indent guides with current-scope highlight
      -- (replaces lukas-reineke/indent-blankline.nvim)
      -- -----------------------------------------------------------------------
      indent = {
        enabled = true,
        indent = {
          char        = '│',
          only_scope  = false,  -- show guides for all indent levels
          only_current = false,
        },
        scope = {
          enabled   = true,
          char      = '│',
          underline = true,   -- underline the current scope's opening line
        },
        animate = {
          enabled  = true,
          style    = 'out',
          easing   = 'linear',
          duration = { step = 15, total = 300 },
        },
      },

      -- -----------------------------------------------------------------------
      -- notifier: replaces rcarriga/nvim-notify as the vim.notify backend
      -- noice.nvim routes its notifications through vim.notify automatically
      -- -----------------------------------------------------------------------
      notifier = {
        enabled = true,
        timeout = 3000,
        style   = 'compact',  -- 'compact' | 'fancy' | 'minimal'
      },

      -- -----------------------------------------------------------------------
      -- scroll: smooth scrolling for <C-d>, <C-u>, <C-f>, <C-b>, gg, G, etc.
      -- -----------------------------------------------------------------------
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 15, total = 250 },
          easing   = 'linear',
        },
      },

      -- -----------------------------------------------------------------------
      -- words: highlight every reference to the word under cursor
      -- automatically sets up [[ / ]] to jump between references
      -- -----------------------------------------------------------------------
      words = {
        enabled  = true,
        debounce = 150,  -- ms to wait after cursor stops before highlighting
      },

      -- -----------------------------------------------------------------------
      -- rename: file rename via vim.ui.input that also updates LSP imports
      -- Usage: <leader>rf or :lua Snacks.rename.rename_file()
      -- -----------------------------------------------------------------------
      rename = { enabled = true },

      -- -----------------------------------------------------------------------
      -- lazygit: full LazyGit TUI inside Neovim
      -- (replaces kdheepak/lazygit.nvim)
      -- -----------------------------------------------------------------------
      lazygit = { enabled = true },

      -- -----------------------------------------------------------------------
      -- Disabled — have better dedicated plugins for these
      -- -----------------------------------------------------------------------
      dashboard  = { enabled = false }, -- no startup dashboard
      explorer   = { enabled = false }, -- using yazi.nvim
      picker     = { enabled = false }, -- using fzf-lua
      terminal   = { enabled = false }, -- using built-in terminal
      zen        = { enabled = false },
      dim        = { enabled = false },
    },

    keys = {
      -- LazyGit
      { '<leader>gg', function() Snacks.lazygit() end,         desc = 'Open LazyGit' },
      { '<leader>gL', function() Snacks.lazygit.log() end,     desc = 'LazyGit log (repo)' },
      { '<leader>gB', function() Snacks.gitbrowse() end,       desc = 'Git [B]rowse (open in browser)' },

      -- File rename (LSP-aware)
      { '<leader>rf', function() Snacks.rename.rename_file() end, desc = '[R]ename [F]ile (LSP-aware)' },

      -- Notification history
      { '<leader>nh', function() Snacks.notifier.show_history() end, desc = '[N]otification [H]istory' },
      { '<leader>nd', function() Snacks.notifier.hide() end,         desc = '[N]otifications [D]ismiss all' },

      -- Word navigation (also auto-wired to [[ / ]] by snacks.words)
      { ']]', function() Snacks.words.jump(1,  true) end, desc = 'Next word reference' },
      { '[[', function() Snacks.words.jump(-1, true) end, desc = 'Prev word reference' },
    },
  },
}
