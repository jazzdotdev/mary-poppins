local function update(path)
	path = path or DEFAULT_PATH
	local table = get_table_from(path)
	for rep_name, location in pairs(table.imports) do
		git.pull(DEFAULT_SAVE_DIRECTORY .. rep_name)

		if table[rep_name][RECURSIVE] == true then
			update(DEFAULT_SAVE_DIRECTORY .. rep_name)
		end
	end
end

return update
