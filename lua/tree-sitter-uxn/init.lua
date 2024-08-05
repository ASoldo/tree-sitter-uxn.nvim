local function setup()
	vim.filetype.add({
		extension = {
			uxn = "uxn",
			rom = "uxn",
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
			(function) @function
			(subroutine_call) @function
			(value) @number
			(identifier) @constant
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
end

return { setup = setup }
