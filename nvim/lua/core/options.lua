local opt = vim.opt -- for conciseness

-- Line Numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- Tabs & Indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- Search
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- Appearance
opt.termguicolors = true -- enable 24-bit RGB colors
opt.background = 'dark'  -- tell vim what the background color looks like
opt.signcolumn = 'yes'   -- always show the sign column, otherwise it would shift the text each time

-- Behavior
opt.clipboard = 'unnamedplus' -- sync with system clipboard
opt.wrap = false              -- disable line wrapping
opt.scrolloff = 8             -- minimal number of screen lines to keep above and below the cursor

-- Backups
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
opt.undofile = true

vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
