if vim.loader then
	vim.loader.enable()
end

_G.dd = function(...)
	require("util.debug").dump(...)
end
vim.print = _G.dd

require("config.lazy")
vim.filetype.add({
	pattern = {
		[".*%.vm%.original"] = "velocity",
		[".*%.vm%.bak"] = "velocity",
		[".*%.vm%..*"] = "velocity",
	},
})
