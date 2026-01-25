-- Discord rich presence
require("cord").setup {
	enabled = true,
	display = {
		theme = "default",
		flavor = "dark",
	},
	editor = {
		client = "neovim",
		tooltip = "the kewl editor",
		icon = nil,
	},
	timestamp = {
		enabled = true,
		reset_on_idle = false,
		reset_on_change = false,
	},
	idle = {
		enabled = true,
		show_status = true,
		smart_idle = true,
		details = "spacin' out",
		tooltip = '💤',
		icon = nil,
	},
	text = {
		default = nil,
		dashboard = "Home",
		workspace = function(opts) return "In " .. opts.workspace end,
		viewing = function(opts) return "Viewing " .. opts.filename end,
		editing = function(opts) return "Editing " .. opts.filename end,
		file_browser = function(opts) return "Browsing files in " .. opts.name end,
		docs = function(opts) return "Reading " .. opts.name end,
		vcs = function(opts) return "Committing changes in " .. opts.name end,
		notes = function(opts) return "Taking notes in " .. opts.name end,
		debug = function(opts) return "Debugging in " .. opts.name end,
		test = function(opts) return "Testing in " .. opts.name end,
		diagnostics = function(opts) return "Fixing problems in " .. opts.name end,
		games = function(opts) return "Playing " .. opts.name end,
		terminal = function(opts) return "Running commands in " .. opts.name end,
	},
}

-- Wakatime to track your coding time
-- I personally need this to interface with Hackatime
vim.cmd.packadd("vim-wakatime")
