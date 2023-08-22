vim.opt.encoding = "utf-8"
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.hlsearch = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.o.undofile = true
vim.opt.pumheight = 15
vim.opt.signcolumn = "yes"
vim.g.mapleader = " "

if vim.g.neovide then
	vim.o.guifont = "FiraCode Nerd Font:h12"
	vim.g.neovide_padding_top = 0
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 0
	vim.g.neovide_scroll_animation_length = 0.5
	vim.g.neovide_cursor_animation_length = 0
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_refresh_rate = 144
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
		lazy = false,
	},
	{
		"sbdchd/neoformat",
		config = function() end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({
				view = {
					width = {
						min = 30,
						max = 60,
					},
				},
				renderer = {
					root_folder_label = false,
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		config = function()
			local builtin = require("telescope.builtin")

			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { "node%_modules/.*" },
				},
			})

			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		config = function()
			local signs = {
				Error = "",
				Warn = "",
				Hint = "",
				Information = "",
				Other = "",
			}

			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type

				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			vim.diagnostic.config({
				virtual_text = true,
				update_in_insert = true,
			})
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		config = function()
			local c = require("vscode.colors").get_colors()
			require("vscode").setup({
				group_overrides = {
					["@variable.builtin"] = { fg = c.vscBlue, bg = "NONE" },
				},
			})
			vim.cmd.colorscheme("vscode")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		config = function()
			require("lualine").setup({ options = { theme = "vscode" } })
		end,
	},
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({

				auto_install = true,
				highlight = { enable = true, additional_vim_regex_highlighting = false },
				indent = { enable = true },
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			vim.opt.list = true

			require("indent_blankline").setup({
				show_current_context = true,
				show_current_context_start = false,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/nvim-cmp",
				"L3MON4D3/LuaSnip",
				"saadparwaiz1/cmp_luasnip",
				"rafamadriz/friendly-snippets",
			},
		},
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			local luasnip = require("luasnip")
			local cmp = require("cmp")

			require("luasnip.loaders.from_snipmate").lazy_load()

			local servers = { "tsserver", "angularls", "eslint", "pyright", "lua_ls" }

			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities,
					settings = {
						Lua = {
							diagnostics = {
								-- Get the language server to recognize the `vim` global
								globals = { "vim" },
							},
						},
					},

					on_attach = function(client)
						client.server_capabilities.semanticTokensProvider = nil
					end,
				})
			end

			--			lspconfig.tsserver.setup({
			--				capabilities,
			--				on_attach = function(client)
			--					client.server_capabilities.semanticTokensProvider = nil
			--				end,
			--			})
			--			lspconfig.eslint.setup({ capabilities })
			--			lspconfig.angularls.setup({ capabilities })
			--			lspconfig.pyright.setup({ capabilities })
			--			lspconfig.lua_ls.setup({
			--				capabilities,
			--				settings = {
			--					Lua = {
			--						diagnostics = {
			--							-- Get the language server to recognize the `vim` global
			--							globals = { "vim" },
			--						},
			--					},
			--				},
			--			})

			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.g.vscode_snippets_path or "" })

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered({
						border = "single",
					}),
					documentation = cmp.config.window.bordered({
						border = "single",
					}),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
					["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
					-- C-b (back) C-f (forward) for snippet placeholder navigation.
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "nvim_lua" },
					{ name = "path" },
					{ name = "buffer" },
				},
			})

			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				border = "single",
			})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
					vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set("n", "<space>wl", function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
					vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<space>f", function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end,
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
})

vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeFocus <cr>")
vim.keymap.set("n", "<C-N>", "<cmd> NvimTreeToggle <cr>")

vim.api.nvim_create_autocmd("BufWritePre", {
	command = "Neoformat",
})
