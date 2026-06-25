-- =============================================================================
-- fzf-lua: fuzzy finder (replaces telescope.nvim)
-- lua/plugins/telescope.lua
--
-- fzf-lua is significantly faster than telescope on large codebases — it uses
-- the native fzf binary and a single Lua/C core instead of pure Lua sorting.
-- The API intentionally mirrors telescope so keymaps feel familiar.
-- =============================================================================

return {
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local fzf = require 'fzf-lua'

      fzf.setup {
        -- 'telescope' preset gives a telescope-like layout out of the box
        'telescope',
        winopts = {
          height  = 0.85,
          width   = 0.85,
          preview = {
            layout     = 'horizontal',
            horizontal = 'right:55%',
          },
        },
        -- Use fd/rg if available for faster file/grep operations
        files = { formatter = 'path.filename_first' },
      }

      -- Register fzf-lua as the handler for vim.ui.select (code actions, etc.)
      fzf.register_ui_select()

      -- -----------------------------------------------------------------------
      -- Keymaps  (mirrors previous telescope keymaps exactly)
      -- -----------------------------------------------------------------------
      local map = vim.keymap.set

      map('n', '<leader>ff', fzf.files,            { desc = 'Find [F]iles' })
      map('n', '<leader>fg', fzf.live_grep,         { desc = 'Find by [G]rep' })
      map('n', '<leader>fw', fzf.grep_cword,        { desc = 'Find current [W]ord' })
      map('n', '<leader>fh', fzf.help_tags,         { desc = 'Find [H]elp' })
      map('n', '<leader>fk', fzf.keymaps,           { desc = 'Find [K]eymaps' })
      map('n', '<leader>fd', fzf.diagnostics_document, { desc = 'Find [D]iagnostics' })
      map('n', '<leader>fr', fzf.resume,            { desc = 'Find [R]esume' })
      map('n', '<leader>f.', fzf.oldfiles,          { desc = 'Find Recent Files' })
      map('n', '<leader>fs', fzf.builtin,           { desc = 'Find [S]elect picker' })
      map('n', '<leader><leader>', fzf.buffers,     { desc = 'Find existing buffers' })

      -- Fuzzy search lines in the current buffer
      map('n', '<leader>/', fzf.blines,             { desc = '[/] Fuzzy search in current buffer' })

      -- Live grep only within currently open buffers
      map('n', '<leader>s/', function()
        fzf.live_grep { prompt = 'Grep Open Files> ', grep_open_files = true }
      end, { desc = '[S]earch [/] in open files' })

      -- Search inside the Neovim config directory
      map('n', '<leader>sn', function()
        fzf.files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim config files' })
    end,
  },
}
