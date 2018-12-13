#!/usr/bin/env torchbear

-- Machu Picchu
-- a general-purpose package manager


DEFAULT_PATH           = "./"
DEFAULT_SAVE_DIRECTORY = ".mp/"

-- SCL file keys
URL       = "url"
RECURSIVE = "recursive"
EXPORT    = "export"
PLUCK     = "pluck"
LOCAL_IMPORT = "local_import"


-- todo: fs: add `basename` function
local argv0 = string.match(table.remove(arg, 1), "[^/\\]+$")

local function usage(f)
	f = f or io.stderr
	f:write(
		string.format('usage: %s [sync]\n', argv0),
		string.format('usage: %s update\n', argv0),
		string.format('usage: %s help\n', argv0)
	)
	os.exit(f ~= io.stderr)
end

function fetch(url, location)
	git.clone(url, DEFAULT_SAVE_DIRECTORY .. location)
end

function get_table_from(path)
	-- todo: fix path handling
	local scl_file = fs.read_file(path .. "/import.scl")
	return scl.to_table(scl_file)
end

local cmd = table.remove(arg, 1) or "sync"
if #arg ~= 0 then
	usage()
end

(({
	sync   = function() require"sync"(DEFAULT_PATH) end,
	update = function() require"update"(DEFAULT_PATH) end,
	help   = usage

})[cmd] or usage)()
