return {
	"jay-babu/mason-nvim-dap.nvim",
	lazy = false,
	config = function()
		local mdap = require("mason-nvim-dap")
		local dap = require("dap")
		local widgets = require("dap.ui.widgets")

		mdap.setup({
			ensure_installed = { "stylua" },
			handlers = {
				function(config)
					mdap.default_setup(config)
				end,
				python = function(cb, config)
					config.adapters = {
						type = "executable",
            -- command = "/usr/bin/python3",
						-- command = "/usr/local/bin/python3",
						command = "python3",
						args = { "-m", "debugpy.adapter" },
						options = {
							source_filetype = "python",
						},
					}
					mdap.default_setup(config)
				end,
			},
		})

		vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

		local opts = { noremap = true, silent = true, buffer = bufnr }

		local my_sidebar = require("dap.ui.widgets").sidebar(widgets.scopes)

		-- keymaps
		-- vim.keymap.set("n", "<Leader>5", "<cmd>DapNew<CR>", opts)
		vim.keymap.set("n", "<Leader>3", function()
			require("dap").continue()
			my_sidebar.open()
			require("dap").repl.open()
		end, opts)
		vim.keymap.set("n", "<Leader>5", function()
			require("dap").repl.open()
			my_sidebar.open()
      -- DEBUG TRACE INFO WARN ERROR
      require("dap").set_log_level("DEBUG")
			require("dap").continue()
		end, opts)
		vim.keymap.set("n", "<Leader>4", function()
			require("dap").restart()
		end, opts)
		vim.keymap.set("n", "<Leader>v", "<cmd>DapContinue<CR>", opts)
		vim.keymap.set("n", "<Leader>mso", "<cmd>DapStepOver<CR>", opts)
		vim.keymap.set("n", "<Leader>msi", "<cmd>DapStepInto<CR>", opts)
		vim.keymap.set("n", "<Leader>msO", "<cmd>DapStepOut<CR>", opts)
		vim.keymap.set("n", "<Leader>bp", "<cmd>DapToggleBreakpoint<CR>", opts)
		vim.keymap.set("n", "<Leader>pp", "<cmd>DapTerminate<CR>", opts)
		vim.keymap.set("n", "<Leader>lp", function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
		end, opts)
		vim.keymap.set("n", "<Leader>lo", function()
			dap.set_breakpoint(nil, vim.fn.input("br-point stops: "), nil)
		end, opts)
    vim.keymap.set("n", "<leader>ll", "<cmd>vsplit ~/.cache/nvim/dap.log<CR>", opts)
		-- vim.keymap.set("n", "<Leader>lb", function()
		-- 	dap.list_breakpoints()
		-- end, opts)

		-- scopes, expression, sessions, frames, threads
		vim.keymap.set("n", "<Leader>md", function()
			require("dap").repl.toggle()
			my_sidebar.toggle()
		end, opts)
		-- from DAP.lua
		-- 	if config.request == "attach" then
		--     ---@diagnostic disable-next-line: undefined-field
		--     local port = (config.connect or config).port
		--     ---@diagnostic disable-next-line: undefined-field
		--     local host = (config.connect or config).host or "127.0.0.1"
		--     cb({
		--       type = "server",
		--       port = assert(port, "`connect.port` is required for a python `attach` configuration"),
		--       host = host,
		--       options = {
		--         source_filetype = "python",
		--       },
		--     })
		--   else
		--     cb({
		--       type = "executable",
		--       command = "/usr/bin/python3",
		--       args = { "-m", "debugpy.adapter" },
		--       options = {
		--         source_filetype = "python",
		--       },
		--     })
		--   end
		-- end,
	end,
	dependencies = {
		"williamboman/mason.nvim",
		"mfussenegger/nvim-dap",
	},
}
