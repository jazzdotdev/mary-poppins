local scl_file = fs.read_file("import.scl")
local table = scl.to_table(scl_file)

function sync()
	for rep_name, location in pairs(table.imports) do
		os.execute("git clone " .. table[rep_name]["url"] .. 
		" " .. location)
	end 
end

function update() 
	for rep_name, location in pairs(table.imports) do
		os.execute("cd " .. location .. " && " ..
		" git pull -v ")
	end
end

sync()
update()

return 0
