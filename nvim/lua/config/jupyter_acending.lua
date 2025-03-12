local api = vim.api
local fn = vim.fn
local keymap = vim.keymap

local python_call = "python3"
local ascending_module = "jupyter_ascending"
local python_ascending = python_call .. " -m " .. ascending_module

local jupyter_asc_pattern = ".sync.py"
local jupyter_cell_pattern = "# %%"

local handle = os.execute

local on_stdout = function(j, d, e)
	print("[JupyterAscending]:" .. d)
	--
end

local execute = function(cmd_str)
	-- fn.jobstart(cmd_str, { on_stdout:funcref("s:on_stdout") })
	local cmd_list = {}
	for i in string.gmatch(cmd_str, "%S+") do
		table.insert(cmd_list, i)
	end

	--vim.system(cmd_str, {})
	--fn.jobstart(cmd_str, { on_stdout = on_stdout })
	-- vim.system(cmd_list, { on_stdout = on_stdout })
end

local execute_sh = function(cmd_str)
	print(cmd_str)
	os.execute(cmd_str .. " &> /dev/null")
end

local rm_fname = function(instr)
	local ret_str = ""
	for i in instr.gmatch(instr, "%S+/") do
		ret_str = ret_str .. i
	end
	return ret_str
end

local ascend_sync = function()
	--
	local file_name = fn.expand("%:p")

	local asc_cmd = python_ascending .. ".requests.sync --filename " .. file_name
	execute_sh(asc_cmd)
end

local ascend_exec = function()
	local file_name = fn.expand("%:p")
	local asc_cmd = python_ascending
		.. ".requests.execute --filename "
		.. file_name
		.. " --linenumber "
		.. api.nvim_win_get_cursor(0)[1]

	execute_sh(asc_cmd)
end

local ascend_exec_all = function()
	--
end

local ascend_restart = function()
	local fname = fn.expand("%:p")

	local asc_cmd = python_ascending .. ".requests.restart --filename " .. fname
	execute_sh(asc_cmd)
end

local ascend_make_pair = function()
	local fpath = rm_fname(tostring(vim.fn.expand("%:p:r"))) -- tostring(fn.expand("%:p:r"))
	local fname = fpath .. fn.input("File: ")
	local asc_cmd = python_ascending .. ".scripts.make_pair " .. "--base '" .. fname .. "'"
	execute_sh(asc_cmd)
end

local start_jupyter = function()
	io.popen(python_call .. " -m jupyter notebook &> /dev/null")
end

local go_to_next_cell = function()
	api.nvim_command("/# %%")
end
local go_to_prev_cell = function()
	api.nvim_command("?# %%")
end

local ascend_exec_next = function()
	ascend_exec()
	go_to_next_cell()
end

local change_ascending_port = function()
	-- this you just need to change an environment variable
	local new_port = fn.input("Jupyter port")
end

api.nvim_create_user_command("JupyterSync", "", {})
api.nvim_create_user_command("JupyterExec", "", {})
api.nvim_create_user_command("JupyterStartNotebook", start_jupyter, {})
api.nvim_create_user_command("JupyterNextCell", go_to_next_cell, {})
api.nvim_create_user_command("JupyterPrevCell", go_to_next_cell, {})

api.nvim_create_user_command("AscendingMakePair", ascend_make_pair, {})
api.nvim_create_user_command("AscendingSync", ascend_sync, { bang = false })
api.nvim_create_user_command("AscendingExec", ascend_exec, {})
api.nvim_create_user_command("AscendingExecNext", ascend_exec_next, {})
api.nvim_create_user_command("AscendingExecAll", ascend_exec_all, {})
api.nvim_create_user_command("AscendingRestart", ascend_restart, {})

keymap.set("n", "<Leader>je", "<cmd>AscendingExec<CR>", opts)
keymap.set("n", "<Leader>jE", "<cmd>AscendingExecNext<CR>", opts)
keymap.set("n", "<Leader>ja", "<cmd>AscendingExecAll<CR>", opts)
keymap.set("n", "<Leader>js", "<cmd>AscendingSync<CR>", opts)
keymap.set("n", "<Leader>jr", "<cmd>AscendingRestart<CR>", opts)
keymap.set("n", "<Leader>jn", "<cmd>JupyterNextCell<CR>", opts)
keymap.set("n", "<Leader>jp", "<cmd>JupyterPrevCell<CR>", opts)
-- keymap.set("n", "<Leader>jt", "<cmd>JupyterStartNotebook<CR>", opts)
