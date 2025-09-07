return {
  -- LSP Configuration & Mason
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and formatters to PATH
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      -- This is where we will configure our LSPs.
      -- This function gets executed when the plugin is loaded.
      -- We will call our modular LSP configuration here.
      require('config.lsp')
    end,
  },
}
