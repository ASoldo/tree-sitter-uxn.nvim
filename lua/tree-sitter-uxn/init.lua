local function setup()
	vim.filetype.add({
		extension = {
			uxn = "uxn",
			rom = "rom",
		},
	})

	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
	parser_config.uxn = {
		install_info = {
			url = "https://github.com/ASoldo/tree-sitter-uxn.git",
			files = { "src/parser.c" },
			branch = "main",
		},
		filetype = "uxn",
	}

	local highlights_scm = [[
    (keyword) @keyword
    ]]

	local runtime_path = vim.fn.stdpath("cache")
	vim.opt.runtimepath:append(runtime_path)
	vim.fn.mkdir(runtime_path .. "/queries/uxn", "p")

	if vim.fn.isdirectory(runtime_path .. "/queries/uxn") == 1 then
		local highlights_file = io.open(runtime_path .. "/queries/uxn/highlights.scm", "w")
		io.output(highlights_file)
		io.write(highlights_scm)
		io.close(highlights_file)
	end

	-- Autocmd to enable Tree-sitter highlight for uxn files
	vim.api.nvim_exec(
		[[
      augroup UxnHighlight
        autocmd!
        autocmd BufRead,BufNewFile *.uxn TSBufEnable highlight
      augroup END
    ]],
		false
	)
end

return { setup = setup }
