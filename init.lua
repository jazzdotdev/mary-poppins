local scl_file = fs.read_file("import.scl")
local table = scl.to_table(scl_file)

function sync()
	for rep_name, location in pairs(table.imports) do
		local dir_name = get_dir_name(location)
		if dir_name ~= "" then 
			-- TODO check if directory is already present 
			os.execute("mkdir " .. dir_name .. " && cd " .. dir_name)
			os.execute("git clone " .. table[rep_name]["url"])
			os.execute("cd -")
		else
			os.execute("git clone" .. table[rep_name]["url"])
		end
	end 
end

function get_dir_name(str) 
	local i = string.len(str) - 1
	while i >= 0 do
		if string.sub(str, i, i) == '/' then
			return string.sub(str, 0, i)
		end
		i = i - 1
	end
	return ""
end


sync()

return 0
