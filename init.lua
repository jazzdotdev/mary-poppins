function sync(path)
	local scl_file = fs.read_file(path .. "/import.scl")
	local table = scl.to_table(scl_file)

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

function update() 
	for rep_name, location in pairs(table.imports) do
		git.pull(location)

	end
end

if os.getenv("MP_ACTION") == "sync" or os.getenv("MP_ACTION") == "" then
	sync("./") 
elseif os.getenv("MP_ACTION") == "update" then
	update()
else
	print("Invalid Option\n" ..
		  "usage: ./mp [ACTIONS]")
end

return 0
