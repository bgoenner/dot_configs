local on_attach = require("util.lsp").on_attach

local config = function()
	require("neoconf").setup({})

	local cmp_nvim_lsp = require("cmp_nvim_lsp")

	local lspconfig = require("lspconfig")

	local signs = { Error = "x", Warn = "!", Hint = "+ ", Info = "i" }

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- python
	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
				},
			},
		},
	})
	-- lua
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			Lua = {
				-- make the lanuage server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})
	-- openscad
	lspconfig.openscad_lsp.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {},
	})
	-- latex
	lspconfig.digestif.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {},
	})
	-- c++
	lspconfig.clangd.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {},
	})
	-- json
	lspconfig.biome.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {},
	})

	-- lua
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")

	-- python
	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")
	local autopep8 = require("efmls-configs.formatters.autopep8")

	-- makefile
	local checkmake = require("efmls-configs.linters.checkmake")

	-- c++
	local clang_format = require("efmls-configs.formatters.clang_format")
	local cpplint = require("efmls-configs.linters.cpplint")

	-- Dockerfile
	local dockerfile_lint = require("efmls-configs.linters.hadolint")

	--json, jsonc
	-- local biome_lint = require("efmls-configs.linters.biome")
	local biome_form = require("efmls-configs.formatters.biome")

	-- configure efm server
	lspconfig.efm.setup({
		filetypes = {
			"lua",
			"python",
			"cpp",
			"dockerfile",
			"json",
			"jsonc",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
				python = { flake8, autopep8 },
				makefile = { checkmake },
				cpp = { cpplint, clang_format },
				dockfile = { dockerfile_lint },
				json = { biome_form },
				jsonc = { biome_form },
			},
		},
	})

	-- Format on Save
	local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = lsp_fmt_group,
		callback = function()
			-- deprecated
			local efm = vim.lsp.get_active_clients({ name = "efm" })
			-- local efm = vim.lsp.get_clients({ name = "efm" })

			if vim.tbl_isempty(efm) then
				return
			end

			vim.lsp.buf.format({ name = "efm" })
		end,
	})
end

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
}
