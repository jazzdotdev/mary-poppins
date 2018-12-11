local scl_file = fs.read_file("import.scl")
local table = scl.to_table(scl_file)

function sync()
	for rep_name, location in pairs(table.imports) do
		git.clone(table[rep_name]["url"], location)
	end 
end

function update() 
	for rep_name, location in pairs(table.imports) do
		git.pull(location)

	end
end

if os.getenv("MP_ACTION") == "sync" or os.getenv("MP_ACTION") == "" then
	sync() 
elseif os.getenv("MP_ACTION") == "update" then
	update()
else
	print("Invalid Option\n" ..
		  "usage: ./mp [ACTIONS]")
end

return 0
