update = {}

function update(path)
	local table = get_table_from(path)
	for rep_name, location in pairs(table.imports) do
		git.pull(DEFAULT_SAVE_DIRECTORY .. rep_name)

		if table[rep_name]["recursive"] == true then
			update(DEFAULT_SAVE_DIRECTORY .. rep_name)
		end
	end
end


