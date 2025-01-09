return {
	-- Plugin base do Velocity
	{
		"lepture/vim-velocity",
		ft = { "velocity", "vm" },
		config = function()
			-- Configuração de filetype
			vim.filetype.add({
				pattern = {
					[".*%.vm"] = "velocity",
				},
			})

			-- Configurações específicas para arquivos Velocity
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "velocity", "vm" },
				callback = function()
					-- Configurações de indentação
					vim.bo.expandtab = true
					vim.bo.shiftwidth = 2
					vim.bo.tabstop = 2
					vim.bo.softtabstop = 2
					vim.bo.autoindent = true
					vim.bo.smartindent = true

					-- Definir comentários corretos para Velocity
					vim.bo.commentstring = "## %s"

					-- Configurar palavra-chave para autocompletar
					vim.opt_local.iskeyword:append("$")
				end,
			})
		end,
	},

	-- Configuração para HTML LSP
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				html = {
					filetypes = { "html", "velocity", "vm" },
					init_options = {
						configurationSection = { "html", "css", "javascript" },
						embeddedLanguages = {
							css = true,
							javascript = true,
						},
						provideFormatter = true,
					},
				},
			},
		},
	},

	-- Configuração do nvim-cmp para autocompletar
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			local cmp = require("cmp")
			opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
				{ name = "nvim_lsp" },
				{ name = "path" },
				{ name = "buffer" },
			}))
		end,
	},

	-- Configuração do TreeSitter
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			if type(opts.ensure_installed) == "table" then
				vim.list_extend(opts.ensure_installed, { "html", "css", "javascript" })
			end
		end,
	},

	-- Configuração do conform.nvim para formatação
	{
		"stevearc/conform.nvim",
		optional = true,
		opts = {
			formatters_by_ft = {
				velocity = { "prettier" },
				vm = { "prettier" },
			},
			formatters = {
				prettier = {
					prepend_args = { "--parser", "html" },
				},
			},
		},
	},
}
