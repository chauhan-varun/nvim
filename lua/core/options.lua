-- =============================================================================
-- Core Options
-- lua/core/options.lua
-- =============================================================================

-- Leader key — must be set before lazy.nvim loads plugins
vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '

-- Set to true if a Nerd Font is installed and active in your terminal
vim.g.have_nerd_font = true

-- ---------------------------------------------------------------------------
-- Line numbers
-- ---------------------------------------------------------------------------
vim.opt.number         = true  -- Show absolute line number on current line
vim.opt.relativenumber = true  -- Relative numbers for easy motion counts (5j, d8k…)

-- ---------------------------------------------------------------------------
-- UI
-- ---------------------------------------------------------------------------
vim.opt.mouse      = 'a'      -- Enable mouse (useful for resizing splits)
vim.opt.showmode   = false    -- Mode is already shown in the statusline
vim.opt.cursorline = true     -- Highlight the line the cursor is on
vim.opt.signcolumn = 'yes'    -- Always show sign column (prevents layout shift)
vim.opt.scrolloff  = 10       -- Keep ≥10 lines visible above/below cursor
vim.opt.list       = true     -- Render certain whitespace characters visually
vim.opt.listchars  = { tab = '» ', trail = '·', nbsp = '␣' }

-- ---------------------------------------------------------------------------
-- Editing behaviour
-- ---------------------------------------------------------------------------
vim.opt.breakindent  = true   -- Wrapped lines preserve indentation
vim.opt.undofile     = true   -- Persist undo history across sessions
vim.opt.confirm      = true   -- Ask to save instead of failing on :q with changes
vim.opt.inccommand   = 'split' -- Live preview of :s substitutions in a split

-- ---------------------------------------------------------------------------
-- Search
-- ---------------------------------------------------------------------------
vim.opt.ignorecase = true  -- Case-insensitive search by default…
vim.opt.smartcase  = true  -- …unless the query contains a capital letter

-- ---------------------------------------------------------------------------
-- Timing
-- ---------------------------------------------------------------------------
vim.opt.updatetime = 250   -- Faster CursorHold / swap writes
vim.opt.timeoutlen = 300   -- Shorter which-key / keymap sequence timeout

-- ---------------------------------------------------------------------------
-- Splits
-- ---------------------------------------------------------------------------
vim.opt.splitright = true  -- Vertical splits open to the right
vim.opt.splitbelow = true  -- Horizontal splits open below

-- ---------------------------------------------------------------------------
-- Folding  (Treesitter-based, requires Neovim ≥ 0.10)
-- ---------------------------------------------------------------------------
vim.opt.foldmethod  = 'expr'
vim.opt.foldexpr    = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldenable  = true   -- Enable folding on open
vim.opt.foldlevel   = 99     -- Start with everything unfolded
vim.opt.foldnestmax = 3      -- Limit fold depth to avoid over-nesting
vim.opt.fillchars   = { fold = ' ' }

-- ---------------------------------------------------------------------------
-- Clipboard  (scheduled to avoid increasing startup time)
-- ---------------------------------------------------------------------------
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'  -- Sync with system clipboard
end)
