local keymap = vim.keymap

local config = function()
	local dap = require("dap")
	local widgets = require("dap.ui.widgets")
	-- local test_runners = require("dap-python")

	dap.adapters.python = function(cb, config)
		if config.request == "attach" then
			---@diagnostic disable-next-line: undefined-field
			local port = (config.connect or config).port
			---@diagnostic disable-next-line: undefined-field
			local host = (config.connect or config).host or "127.0.0.1"
			cb({
				type = "server",
				port = assert(port, "`connect.port` is required for a python `attach` configuration"),
				host = host,
				options = {
					source_filetype = "python",
				},
			})
		else
			cb({
				type = "executable",
				command = "/usr/bin/python3",
				args = { "-m", "debugpy.adapter" },
				options = {
					source_filetype = "python",
				},
			})
		end
	end

	dap.configurations.python = {
		{
			type = "python",
			request = "launch",
			name = "Launch Py",
			program = "${file}",
			pythonPath = function()
				-- return "/usr/bin/python3"
				-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
				-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
				-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
				local cwd = vim.fn.getcwd()
				if vim.fn.executable(cwd .. "/venv/bin/python3") == 1 then
					return cwd .. "/venv/bin/python3"
				elseif vim.fn.executable(cwd .. "/.venv/bin/python3") == 1 then
					return cwd .. "/.venv/bin/python3"
				else
					return "/usr/bin/python3"
				end
			end,
		},
	}

	local my_sidebar = widgets.sidebar(widgets.scopes)
	-- my_sidebar.open()

	vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })

	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- keymaps
	vim.keymap.set("n", "<Leader>5", "<cmd>DapNew<CR>", opts)
	vim.keymap.set("n", "<Leader>v", "<cmd>DapContinue<CR>", opts)
	vim.keymap.set("n", "<Leader>mo", "<cmd>DapStepOver<CR>", opts)
	vim.keymap.set("n", "<Leader>mi", "<cmd>DapStepInto<CR>", opts)
	vim.keymap.set("n", "<Leader>mO", "<cmd>DapStepOut<CR>", opts)
	vim.keymap.set("n", "<Leader>b", "<cmd>DapToggleBreakpoint<CR>", opts)
	vim.keymap.set("n", "<Leader>p", "<cmd>DapTerminate<CR>", opts)
	-- vim.keymap.set("n", "<Leader>lp", dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: ")))

	-- scopes, expression, sessions, frames, threads
	vim.keymap.set("n", "<Leader>ms", function()
		require("dap.ui.widgets").sidebar(widgets.scopes).open()
	end, opts)

	vim.keymap.set("n", "<Leader>md", function()
		require("dap").repl.open()
	end, opts)
	-- vim.keymap.set("n", "<Leader>dl", "<cmd>Dap")

	-- for launching an external terminal
	--
	--dap.defaults.fallback.external_terminal = {
	--  command = '/usr/bin/alacritty';
	--  args = {'-e'};
	--}
end

return {
	"mfussenegger/nvim-dap",
	lazy = false,
	-- config = function()
	config = config,
	-- keys = {
	--   keymap.set("n", "<Leader>b", ":DapBreakpoint<CR>")
	-- }
	-- dependences = {
	-- 	"mfussenegger/nvim-dap-python",
	-- },
}
