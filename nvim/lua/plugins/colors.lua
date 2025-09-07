return {
  'uga-rosa/ccc.nvim',
  event = 'BufReadPre', -- Load it early for a smooth experience
  config = function()
    require('ccc').setup({
      -- Your configuration comes here
    })
  end,
}
