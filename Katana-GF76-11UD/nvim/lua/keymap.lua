vim.g.mapleader = " "
vim.keymap.set("n", "<leader>p", "<cmd>Telescope find_files hidden=true<cr>", { noremap = true })
vim.keymap.set("n", "<leader>f", "<cmd>Telescope live_grep hidden=true<cr>", { noremap = true })
vim.keymap.set("n", "<leader>.", "<cmd>Telescope file_browser hidden=true<cr>", { noremap = true })
vim.keymap.set("n", "<C-leader>", "<cmd>telescope.nvim<cr>", { noremap = true })
-- telescope.nvim
vim.keymap.set("n", "<leader>", "<cmd><cr>", { noremap = true })
vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<CR>", { silent = true })
vim.keymap.set("i", "<S-Tab>", "<C-d>", { silent = true })
vim.keymap.set({ "n", "v" }, "<C-Space>", vim.lsp.buf.code_action, {})
-- vim.keymap.set("n", "<leader>.", "<cmd>Explore<cr>", {})
vim.keymap.set("n", "<C-W>", "<cmd>bdelete<cr>", { noremap = true })
vim.keymap.set("n", "<A-Tab>", "<cmd>bnext<cr>", { noremap = true })
vim.keymap.set("n", "<S-Tab>", "<cmd>bprevious<cr>", { noremap = true })
