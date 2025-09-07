-- [[ LSPs ]]

local lspconfig = require('lspconfig')

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'jdtls',
    'ts_ls',
    'pyright',
    'clangd',
    'rust_analyzer',
    'lua_ls',
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

local servers = {
  -- Java
  jdtls = {},
  -- JavaScript / TypeScript
  ts_ls = {},
  -- Python
  pyright = {},
  -- C / C++
  clangd = {},
  -- Rust
  rust_analyzer = {},
  -- Lua (for Neovim config)
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
      },
    },
  },
}

for server_name, config in pairs(servers) do
  local server_config = vim.tbl_deep_extend('force', {
    on_attach = on_attach,
    capabilities = capabilities,
  }, config)

  lspconfig[server_name].setup(server_config)
end
