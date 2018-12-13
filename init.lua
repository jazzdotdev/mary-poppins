DEFAULT_PATH = "./"
DEFAULT_SAVE_DIRECTORY = ".mp/"

-- scl file keys
URL = "url"
RECURSIVE = "recursive"
EXPORT = "export"
PLUCK = "pluck"

function fetch(url, location)
	git.clone(url, DEFAULT_SAVE_DIRECTORY .. location)
end

function get_table_from(path)
	local scl_file = fs.read_file(path .. "/import.scl")
	return scl.to_table(scl_file) 
end

if os.getenv("MP_ACTION") == "sync" or os.getenv("MP_ACTION") == "" then
	require "sync"
	sync(DEFAULT_PATH)
elseif os.getenv("MP_ACTION") == "update" then
	require "update"
	update(DEFAULT_PATH)
else
	print("Invalid Option\n" ..
		  "usage: ./mp [ACTIONS]")
end

return 0
