vim.g.mapleader = " "
vim.g.maplocalleader = ","


vim.opt.nu = true
vim.opt.relativenumber = true


vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true


vim.opt.hlsearch = true
vim.opt.incsearch = true


vim.opt.termguicolors = true


vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", '"+d', { desc = "Delete to system clipboard" })


-- glow remaps  
vim.keymap.set("n", "<leader>gl", "<cmd>:term glow %<CR>", { desc = "Show Glow preview"} )
vim.keymap.set("n", "<leader>gb", "<C-^>", { desc = "Go back to the file from the Glow preview"})
