local o = vim.opt

-- explorer in tree style
vim.cmd("let g:netrw_liststyle = 3")

-- line number
o.relativenumber = true
o.number = true

-- identation
o.tabstop = 2 -- spaces for tab
o.shiftwidth = 2 -- spaces for ident
o.expandtab = true -- expand tab to spaces
o.autoindent = true -- copy indent from current line when starting a new one

-- disable line wrapping
o.wrap = false

-- search
o.ignorecase = true
o.smartcase = true -- use case-sensitive search when you input an uppercase letter

-- split windows
o.splitright = true
o.splitbelow = true

-- use the system clipboard
vim.opt.clipboard = "unnamedplus"


-- etc
o.cursorline = true -- highlight the current cursor line
o.signcolumn = "yes" 
o.backspace = { "indent", "eol", "start" } -- allow backspace on indent, end of line or insert mode start position
