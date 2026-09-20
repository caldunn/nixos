-- calebdtn: dual monitor desktop

hl.monitor({
	output = "desc:LG Electronics LG ULTRAGEAR+ 401NTWG55801",
	mode = "3840x2160@144.05",
	position = "0x0",
	scale = "1",
	vrr = 1,
	bitdepth = 8,
})

hl.monitor({
	output = "desc:BNQ BenQ LCD V7G11754019",
	mode = "2560x1440@60",
	position = "3840x300",
	scale = "1",
})

hl.workspace_rule({
	workspace = "9",
	monitor = "desc:LG Electronics LG ULTRAGEAR+ 401NTWG55801",
	persistent = true,
	default_name = "game",
})
