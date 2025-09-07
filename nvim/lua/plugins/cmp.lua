return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Snippet engine & its source for nvim-cmp
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',

    -- Adds other useful completion sources
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',

    -- ***** Add nvim-autopairs as a dependency *****
    'windwp/nvim-autopairs',
    'zbirenbaum/copilot-cmp',

  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    -- ***** This line is new, to integrate with autopairs *****
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')

    -- Keybindings
    local has_words_before = function()
      local line, col = unpack(vim.api.nvim-win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-k>'] = cmp.mapping.select_prev_item(),
        ['<C-j>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        -- ***** This line is MODIFIED for autopairs *****
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      -- Sources for autocompletion
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'copilot' },
        { name = 'buffer' },
        { name = 'path' },
      }),
    })

    -- ***** This section is new *****
    -- Integrate nvim-autopairs with nvim-cmp
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end,
}
