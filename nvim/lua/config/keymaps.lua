local keymap = vim.keymap

-- Directory Navigation
keymap.set("n", "<leader>mt", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
keymap.set("n", "<leader>ft", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- Pane Navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

-- window navigation
keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)

keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", opts)
keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", opts)
keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", opts)
keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", opts)

-- pane split
keymap.set("n", "<leader>sv", ":vsplit<CR>", opts) -- Split Verically
keymap.set("n", "<leader>sh", ":split<CR>", opts) -- Split Horizontally
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", opts) -- Toggle Minimize

keymap.set("n", "<leader>tn", ":tabNext<CR>", opts)
keymap.set("n", "<leader>tb", ":tabprevious<CR>", opts)
keymap.set("n", "<leader>tN", ":tabnew<CR>", opts)
keymap.set("n", "<leader>ts", ":tab split<CR>", opts)
keymap.set("n", "<leader>tq", ":tabclose<CR>", opts)

-- terminal
-- keymap.set("n", "<leader>tt", ":rightbelow term<CR>", opts)

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- Indenting
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Comments
vim.api.nvim_set_keymap("n", "<c-->", "gcc", { noremap = false })
vim.api.nvim_set_keymap("n", "<leader>#", "gcc", { noremap = false })
vim.api.nvim_set_keymap("n", "m#", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<C-->", "gcc", { noremap = false })
vim.api.nvim_set_keymap("v", "<Leader>#", "gcc", { noremap = false })
-- vim.api.nvim_set_keymap("v", "", "gcc", { noremap = false })

-- Testing
-- vim.api.nvim_create_user_command("SayHello", "echo 'HelloWorld'", {})
-- vim.api.nvim_create_user_command("GetFile", "echo '" .. tostring(vim.fn.expand("%:p:r")) .. "'", {})
-- vim.api.nvim_create_user_command("GetPos", function()
-- 	print(tostring(vim.api.nvim_win_get_cursor(0)[1]))
-- end, {})

-- vim.api.nvim_create_user_command
