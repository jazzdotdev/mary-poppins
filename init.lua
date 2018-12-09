local scl_file = fs.read_file("import.scl")
local table = scl.to_table(scl_file)

function sync()
	os.execute("mkdir .mp && cd .mp")
	
	for _, url in pairs(table.packages) do 
		os.execute("git clone " .. url)
	end

end

sync()

return 0
