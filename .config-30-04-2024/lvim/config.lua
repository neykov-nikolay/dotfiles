lvim.format_on_save.enabled = true
lvim.builtin.cmp.cmdline.enable = true
lvim.builtin.cmp.confirm_opts.select = true
lvim.builtin.cmp.completion.completeopt = 'menu,menuone,noinsert'
lvim.builtin.nvimtree.setup.respect_buf_cwd = true
lvim.builtin.nvimtree.setup.view.adaptive_size = true
lvim.builtin.nvimtree.setup.view.preserve_window_proportions = true
lvim.builtin.nvimtree.setup.hijack_directories.enable = true
lvim.builtin.nvimtree.setup.update_cwd = false
lvim.builtin.which_key.mappings["e"] = { "<cmd>NvimTreeFocus<CR>", "Explorer" }
lvim.builtin.which_key.mappings["x"] = { "<cmd>BufferKill<CR>", "Close Buffer" }
lvim.builtin.which_key.mappings["f"] = { "<cmd>Telescope<CR>", "Telescope" }
lvim.builtin.which_key.mappings["ff"] = { "<cmd>Telescope find_files<CR>", "Find Files" }
lvim.builtin.which_key.mappings["ft"] = { "<cmd>Telescope live_grep<CR>", "Live Grep" }
lvim.keys.normal_mode["<C-n>"] = "<cmd>NvimTreeToggle<CR>"
lvim.keys.term_mode["<C-l>"] = false
lvim.builtin.terminal.open_mapping = "<a-i>"
lvim.builtin.telescope.theme = "ivy"




local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "black" },
  {
    name = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespace
    -- options such as `--line-width 80` become either `{"--line-width", "80"}` or `{"--line-width=80"}`
    args = { "--print-width", "140" },
    ---@usage only start in these filetypes, by default it will attach to all filetypes it supports
    filetypes = { "javascript", "typescript", "typescriptreact" },
  },
}
