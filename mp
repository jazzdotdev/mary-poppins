#!/usr/bin/env torchbear

-- Machu Picchu
-- a general-purpose package manager

-- FIXME windows support
REPOSITORY_HOME = os.getenv("HOME") .. "/.mp/"

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
		string.format('usage: %s refresh\n', argv0),
		string.format('usage: %s install <package-name>\n', argv0),
		string.format('usage: %s search <package-name>\n', argv0),
		string.format('usage: %s help\n', argv0)
	)
	os.exit(f ~= io.stderr)
end

function fetch(url, location, save_dir)
	save_dir = save_dir or DEFAULT_SAVE_DIRECTORY 
	git.clone(url, save_dir .. location)
end

function get_table_from(path, name)
	name = name or "/import.scl"
	-- todo: fix path handling
	local scl_file = fs.read_file(path .. name)
	return scl.to_table(scl_file)
end

local cmd = table.remove(arg, 1) or "sync"
local arg2 = table.remove(arg, 1)

if #arg ~= 0 then
	usage()
end

(({
	sync   = require"sync",
	update = require"update",
	refresh = require"refresh",
	search = function() require"search"(arg2) end,
	install = function() require"install"(arg2) end,
	help   = usage

})[cmd] or usage)()
