require "file_sync"

local function sync(path)
	-- if path is provided add the default `.mp/` to path
	local table = {}
	if path ~= "./" and path ~= "." then
		table = get_table_from(DEFAULT_SAVE_DIRECTORY .. path)
	else
		table = get_table_from(path)
	end

	for rep_name, destination in pairs(table.imports) do
        -- download the repo
		fetch(table[rep_name][URL], rep_name)

		-- check if recursive
		if table[rep_name][RECURSIVE] == true then
			-- no nesting
			sync(rep_name)
		end

		-- TODO verify

		if table[rep_name][PLUCK] ~= nil then
			pluck(path, rep_name, destination, table[rep_name][PLUCK])
		elseif table[rep_name][EXPORT] ~= nil then
			export(path, rep_name, destination, table[rep_name][EXPORT])
   		else
			full_copy(path, rep_name, destination)
		end
	end
end

return sync
