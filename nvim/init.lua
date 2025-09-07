-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load core settings
require('core.options')
require('core.keymaps')

-- Set path to lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim and load plugins from the 'lua/plugins' directory
require('lazy').setup('plugins', {
  rocks = {
    enabled = false,
  },
})

-- The line below is for the theme. It should be at the end of your init.lua.
vim.cmd.colorscheme 'catppuccin'
