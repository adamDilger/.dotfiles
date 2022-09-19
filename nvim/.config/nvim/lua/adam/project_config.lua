_PROJECT = {
	java = {
		ENABLED = false,
		vmArgs = nil,
	},

	TS_SERVER = false,
	PRETTIER = false,
	ES_LINT = false,
	EMMET = false,
	VOLAR = false,
	TAILWIND = false,
}
require("nvim-projectconfig").setup()
