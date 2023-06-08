vim.opt.wildmenu = true
vim.opt.wildmode = { "longest", "full" }
vim.opt.encoding = "utf-8"
vim.g.neoformat_try_node_exe = 1
vim.opt.cursorline = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.scrolloff = 1
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.incsearch = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.termguicolors = true
vim.opt.linespace = 0
vim.opt.pumheight = 20
vim.wo.number = true
vim.wo.signcolumn = "yes"
vim.o.wrap = false
vim.o.updatetime = 100
vim.o.hlsearch = true
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.breakindent = false
vim.o.undofile = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.background = "dark"
vim.o.guifont = "JetBrainsMono Nerd Font:h9"
vim.g.neovide_refresh_rate = 144
vim.g.neovide_confirm_quit = false
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_padding_top = 4
vim.g.neovide_padding_bottom = 4
vim.g.neovide_padding_right = 4
vim.g.neovide_padding_left = 4
vim.g.neovide_scale_factor = 1
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.opt.termguicolors = true
vim.cmd("colorscheme ayu")

require("dashboard").setup({
	theme = "hyper",
	config = {
		header = {
			" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
			" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
			" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
			" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
			" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
			" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
		},
	},
})
require("nvim-ts-autotag").setup({})
require("Comment").setup({ comment_empty = false })
require("lualine").setup({})
require("autoclose").setup()
require("bufferline").setup({
	options = {
		indicator = {
			style = "none",
		},
	},
})
require("gitsigns").setup({})
require("scrollbar").setup({ handlers = { gitsigns = true } })

vim.cmd([[
    augroup cmdline
    autocmd!
    autocmd CmdlineLeave : echo ''
    autocmd VimLeave * set guicursor=a:ver25
    augroup end
]])

-- vim.cmd([[
--     augroup diagnostic
--     autocmd!
--     autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
--     augroup end
-- ]])

vim.diagnostic.config({
	virtual_text = false,
	float = { border = "rounded" },
})

vim.cmd([[
    augroup fmt
    autocmd!
    autocmd BufWritePre * Neoformat
    augroup end
]])

local signs = {
	Error = "",
	Warning = "",
	Hint = "",
	Information = "",
}

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.g.indent_blankline_filetype_exclude = { "dashboard" }

require("indent_blankline").setup({
	show_current_context = true,
})

local lsp = require("lsp-zero").preset({})

lsp.preset("recommended")

lsp.ensure_installed({
	"tsserver",
	"eslint",
})

lsp.on_attach(function(client, bufnr)
	client.server_capabilities.semanticTokensProvider = nil
	lsp.default_keymaps({ buffer = bufnr })
end)

require("lspconfig").tsserver.setup({})
require("lspconfig").pyright.setup({})

local cmp = require("cmp")
local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }
local lspkind = require("lspkind")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	completion = {
		completeopt = "menu,menuone,noinsert",
	},
	sources = {
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "luasnip", option = { show_autosnippets = false } },
		{ name = "buffer" },
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-e>"] = cmp.mapping.abort(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<S-Tab>"] = cmp.mapping.select_prev_item(cmp_select_opts),
		["<Tab>"] = cmp.mapping.select_next_item(cmp_select_opts),
		["<C-p>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item(cmp_select_opts)
			else
				cmp.complete()
			end
		end),
		["<C-n>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_next_item(cmp_select_opts)
			else
				cmp.complete()
			end
		end),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	formatting = { format = lspkind.cmp_format({}) },
})

lsp.setup({})

require("nvim-treesitter.configs").setup({
	auto_install = true,
	highlight = {
		enable = true,
		disable = function(lang, buf)
			local max_filesize = 100 * 1024 -- 100 KB
			local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			if ok and stats and stats.size > max_filesize then
				return true
			end
		end,

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
})

require("telescope").setup({
	extensions = {
		file_browser = {
			theme = "ivy",
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
		},
	},
	defaults = {
		layout_strategy = "vertical",
		layout_config = {
			vertical = {
				height = 1080,
				width = 1920,
				prompt_position = "bottom",
			},
		},
		file_ignore_patterns = {
			".git",
			"node%_modules/.*",
			"package-lock.json",
			"plugged",
		},
	},
})

require("telescope").load_extension("file_browser")
