-- File: lua/plugins/foundry.lua
return {
  'mrcjkb/foundry.nvim',
  ft = 'solidity',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('foundry').setup {}
  end,
}
