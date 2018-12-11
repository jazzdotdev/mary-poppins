DEFAULT_PATH = "./"

function sync(path)
	local table = get_table_from(path) 

	-- download the repo
	for rep_name, location in pairs(table.imports) do
		fetch(table[rep_name]["url"], path .. location)

		-- check if recursive
		if table[rep_name]["recursive"] == true then
			sync(location)
		end
	end
end

function fetch(url, location) 
	git.clone(url, location)
end

function update(path) 
	local table = get_table_from(path)
	for rep_name, location in pairs(table.imports) do
		git.pull(location)

		if table[rep_name]["recursive"] == true then
			update(location)
		end
	end
end

function get_table_from(path) 
	local scl_file = fs.read_file(path .. "/import.scl")
	return scl.to_table(scl_file) 
end

if os.getenv("MP_ACTION") == "sync" or os.getenv("MP_ACTION") == "" then
	sync(DEFAULT_PATH) 
elseif os.getenv("MP_ACTION") == "update" then
	update(DEFAULT_PATH)
else
	print("Invalid Option\n" ..
		  "usage: ./mp [ACTIONS]")
end

return 0
