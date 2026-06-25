-- =============================================================================
-- Miscellaneous Plugins
-- lua/plugins/misc.lua
-- =============================================================================

return {

  -- ---------------------------------------------------------------------------
  -- Trouble: beautiful diagnostics, LSP references, TODOs panel
  --   <leader>xx  — all project diagnostics
  --   <leader>xX  — current buffer diagnostics only
  --   <leader>cs  — document symbols sidebar
  --   <leader>cl  — LSP definitions + references in one panel
  --   <leader>xQ  — quickfix list (replaces plain :copen)
  -- ---------------------------------------------------------------------------
  {
    'folke/trouble.nvim',
    cmd  = 'Trouble',
    opts = { focus = true }, -- auto-focus the trouble window when opened
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>',               desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',  desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>cs', '<cmd>Trouble symbols toggle<cr>',                   desc = '[C]ode [S]ymbols (Trouble)' },
      { '<leader>cl', '<cmd>Trouble lsp toggle<cr>',                       desc = '[C]ode LSP refs/defs (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>',                    desc = 'Quickfix List (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>',                   desc = 'Location List (Trouble)' },
    },
  },


  -- ---------------------------------------------------------------------------
  -- which-key: show pending keymap completions in a popup
  -- ---------------------------------------------------------------------------
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts  = {
      delay = 0, -- Show immediately (independent of timeoutlen)
      icons = {
        mappings = vim.g.have_nerd_font,
        -- Only provide text fallbacks when there is no Nerd Font available
        keys = vim.g.have_nerd_font and {} or {
          Up    = '<Up> ',   Down  = '<Down> ',
          Left  = '<Left> ', Right = '<Right> ',
          C     = '<C-…> ',  M     = '<M-…> ',
          D     = '<D-…> ',  S     = '<S-…> ',
          CR    = '<CR> ',   Esc   = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp   = '<ScrollWheelUp> ',
          NL    = '<NL> ',   BS    = '<BS> ',
          Space = '<Space> ', Tab  = '<Tab> ',
          F1  = '<F1>',  F2  = '<F2>',  F3  = '<F3>',  F4  = '<F4>',
          F5  = '<F5>',  F6  = '<F6>',  F7  = '<F7>',  F8  = '<F8>',
          F9  = '<F9>',  F10 = '<F10>', F11 = '<F11>', F12 = '<F12>',
        },
      },
      -- Named groups shown in the which-key popup
      spec = {
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>f', group = 'Find' },
        { '<leader>b', group = '[B]uffer' },
        { '<leader>c', group = '[C]ode' },
      },
    },
  },

  -- ---------------------------------------------------------------------------
  -- image.nvim: render images in terminal (required by leetcode.nvim)
  -- Needs: imagemagick (pacman -S imagemagick) + Kitty terminal
  -- Must load BEFORE leetcode.nvim so setup() is called before it's require'd
  -- ---------------------------------------------------------------------------
  {
    '3rd/image.nvim',
    lazy     = false,   -- must be eager — leetcode checks require('image') at load time
    priority = 1001,    -- load before everything else
    config   = function()
      require('image').setup({
        backend   = 'kitty',
        processor = 'magick_cli',
        max_width_window_percentage  = 50,
        max_height_window_percentage = 50,
      })
    end,
  },

  -- ---------------------------------------------------------------------------
  -- LeetCode: solve LeetCode problems without leaving Neovim
  -- ---------------------------------------------------------------------------
  {
    'kawre/leetcode.nvim',
    build        = ':TSUpdate html', -- tree-sitter-html for question formatting
    lazy         = false,
    opts         = {
      injector = {
        ["cpp"] = {
          before = {
            "// Local struct definitions for clangd LSP (ignored by LeetCode on submit)",
            "struct ListNode {",
            "    int val;",
            "    ListNode *next;",
            "    ListNode() : val(0), next(nullptr) {}",
            "    ListNode(int x) : val(x), next(nullptr) {}",
            "    ListNode(int x, ListNode *next) : val(x), next(next) {}",
            "};",
            "",
            "struct TreeNode {",
            "    int val;",
            "    TreeNode *left;",
            "    TreeNode *right;",
            "    TreeNode() : val(0), left(nullptr), right(nullptr) {}",
            "    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}",
            "    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}",
            "};",
          },
        },
      },
      image_support = true,   -- enable image rendering via snacks.nvim
      picker = { provider = 'fzf-lua' }, -- use your existing fzf-lua
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      '3rd/image.nvim',  -- leetcode.nvim specifically requires this, not snacks
    },
    keys = {
      { '<leader>ll', '<cmd>Leet list<cr>',         desc = 'LeetCode: List Problems' },
      { '<leader>ld', '<cmd>Leet desc toggle<cr>',  desc = 'LeetCode: Toggle Description' },
      { '<leader>lr', '<cmd>Leet run<cr>',          desc = 'LeetCode: Run Test Cases' },
      { '<leader>ls', '<cmd>Leet submit<cr>',       desc = 'LeetCode: Submit Solution' },
      { '<leader>li', '<cmd>Leet info<cr>',         desc = 'LeetCode: Show Info' },
    },
  },
}
