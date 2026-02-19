local undodir = vim.fn.stdpath("config") .. "/undodir"
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

vim.o.number = true
--vim.o.relativenumber = true
vim.o.autochdir = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

vim.o.wrap = false

-- Search Settings
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.signcolumn = "yes"
vim.o.ruler = true
--vim.o.pumheight = 10
vim.o.colorcolumn = "72,79"

vim.o.backspace = "indent,eol,start"

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.undodir = undodir

vim.g.tex_flavor = "latex"

--vim.o.completeopt = "menuone,noselect"
