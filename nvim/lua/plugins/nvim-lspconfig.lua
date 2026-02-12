local on_attach = require("util.lsp").on_attach

local config = function()
	require("neoconf").setup({})

	local cmp_nvim_lsp = require("cmp_nvim_lsp")

  -- local lspconfig = require("lspconfig")
  local lsp = vim.lsp
	local lspconfig = lsp.config

	local signs = {
    Error = "x",
    Warn = "!",
    Hint = "+ ",
    Info = "i"
  }

  vim.diagnostic.config()

  --[[
  vim.diagnostic.config({
    signs =
      {
        name = "DiagnosticSign" .. 'Hint',
        text = {
          [vim.diagnostic.severity.ERROR] = signs['ERROR'],
          [vim.diagnostic.severity.WARN] = signs['WARN'],
          [vim.diagnostic.severity.HINT] = signs['HINT'],
          [vim.diagnostic.severity.INFO] = signs['INFO'],
        },
        texthl = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.HINT] = '',
          [vim.diagnostic.severity.INFO] = '',
        },
        numhl = {
          [vim.diagnostic.severity.ERROR] = '',
          [vim.diagnostic.severity.WARN] = '',
          [vim.diagnostic.severity.HINT] = '',
          [vim.diagnostic.severity.INFO] = '',
        },
      }
  })
  --]]

	for type, icon in pairs(signs) do
    -- vim.fn.sign_define(name, list)
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	local capabilities = cmp_nvim_lsp.default_capabilities()

	-- python
	-- lspconfig.pyright.setup({
  lspconfig('pyright', {
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
  lsp.enable('pyright')

	-- lua
	-- lspconfig.lua_ls.setup({
  lspconfig('lua_ls', {
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
  lsp.enable('lua_ls')

	-- openscad
  --[[
	lspconfig.openscad_lsp.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {},
	})
  --]]
  lsp.enable('openscad_lsp')

	-- latex
  --[[
	lspconfig.digestif.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {},
	})
  --]]
  lsp.enable('digestif')

	-- c++
  --[[
	lspconfig.clangd.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {},
	})
  --]]
  lsp.enable('clangd')

	-- json
  --[[
	lspconfig.biome.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {},
	})
  --]]
  lsp.enable('biome')

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
	--lspconfig.efm.setup({
	lspconfig('efm', {
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
  lsp.enable('efm')

	-- Format on Save
	local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = lsp_fmt_group,
		callback = function()
			-- deprecated
			--- local efm = vim.lsp.get_active_clients({ name = "efm" })
			local efm = vim.lsp.get_clients({ name = "efm" })

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
