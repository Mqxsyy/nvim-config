vim.cmd "set expandtab"
vim.cmd "set tabstop=4"
vim.cmd "set softtabstop=4"
vim.cmd "set shiftwidth=4"
vim.cmd "set scrolloff=10"

vim.cmd "cnoreabbrev Q q"
vim.cmd "cnoreabbrev Qa qa"
vim.cmd "cnoreabbrev QA qa"

vim.opt.swapfile = false

vim.g.mapleader = " "

vim.opt.number = true
vim.o.relativenumber = true

vim.cmd "set clipboard+=unnamedplus"
vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
        ["+"] = "clip.exe",
        ["*"] = "clip.exe",
    },
    paste = {
        ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
}
