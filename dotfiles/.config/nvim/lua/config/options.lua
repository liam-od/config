-- Ensure undodir exists
local undodir = vim.fn.stdpath("config") .. "/undodir"
if vim.fn.isdirectory(undodir) == 0 then
	vim.fn.mkdir(undodir, "p")
end

-- General Editor Settings
vim.o.number = true -- Show line numbers
--vim.o.relativenumber = true -- Show relative line numbers
vim.o.autochdir = true -- Change working directory to the file's directory

-- Tab & Indentation Settings
vim.o.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
vim.o.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.autoindent = true -- Copy indent from current line when starting a new line
vim.o.smartindent = true -- Smarter auto-indenting for some languages

-- Line Wrapping
vim.o.wrap = false -- Disable line wrapping

-- Search Settings
vim.o.ignorecase = true -- Ignore case in search patterns
vim.o.smartcase = true -- Override ignorecase if search pattern contains uppercase letters
vim.o.hlsearch = true -- Highlight all matches on search
vim.o.incsearch = true -- Show search results incrementally

-- Cursor & Scrolling
vim.o.cursorline = true -- Highlight the screen line of the cursor
vim.o.scrolloff = 8 -- Minimum number of screen lines to keep above and below the cursor
vim.o.sidescrolloff = 8 -- Minimum number of screen columns to keep to the left and right of the cursor

-- Appearance & UI
vim.o.termguicolors = true -- Enable 24-bit RGB color in the TUI
vim.o.background = "dark" -- Use a dark background
vim.o.signcolumn = "yes" -- Always show the sign column, otherwise it would shift the text
vim.o.ruler = true -- Show the cursor position in the last line of the screen or in the status line
--vim.o.pumheight = 10 -- Maximum number of items to show in the pop-up menu
vim.o.colorcolumn = "72,79" -- Lines to highlight for code style

-- Backspace Behavior
vim.o.backspace = "indent,eol,start" -- Allow backspace on indent, end of line or start of insert

-- Window Splitting
vim.o.splitright = true -- When splitting vertically, new window appears to the right
vim.o.splitbelow = true -- When splitting horizontally, new window appears below

-- File Management
vim.o.swapfile = false -- Disable swap files
vim.o.backup = false -- Disable backup files
vim.o.writebackup = false -- Disable write backup files (needed for some tools like conform.nvim)
vim.o.undofile = true -- Enable persistent undo
vim.o.undodir = undodir -- Set undo directory

-- Performance & Behavior
--vim.o.completeopt = "menuone,noselect" -- Completion options: show menu, only one item, no auto-selection
