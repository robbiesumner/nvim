local M = {}

local state = {
	buf = -1,
	win = -1,
}

local function create_floating_window(opts)
	opts = opts or {}

	local buf
	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true) -- unlisted, scratch buffer
	end

	-- Get editor dimensions
	local width = vim.o.columns
	local height = vim.o.lines

	-- Set floating window dimensions
	local win_width = math.ceil(width * 0.8)
	local win_height = math.ceil(height * 0.6)
	local row = math.ceil((height - win_height) / 2)
	local col = math.ceil((width - win_width) / 2)

	-- Create the floating window
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = win_width,
		height = win_height,
		row = row,
		col = col,
		border = "rounded",
	})

	return { buf = buf, win = win }
end

function M.toggle_floating_terminal()
	if not vim.api.nvim_win_is_valid(state.win) then
		state = create_floating_window({ buf = state.buf })
		if vim.bo[state.buf].buftype ~= "terminal" then
			vim.cmd.term()
		end
	else
		vim.api.nvim_win_hide(state.win)
	end
end

-- options on terminal open
vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
	callback = function()
		-- turn off line numbers
		vim.opt.relativenumber = false
		vim.opt.number = false
	end,
})

function M.create_small_terminal()
	vim.cmd.new()
	vim.cmd.wincmd("J")
	vim.cmd.term()
	vim.api.nvim_win_set_height(0, 12)
end

return M
