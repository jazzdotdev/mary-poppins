local pull = require "pull"

local function upgrade(path)
  path = path or DEFAULT_PATH
  local table = get_table_from(path)
  for rep_name, location in pairs(table.imports) do
    pull(DEFAULT_SAVE_DIRECTORY .. rep_name)

    if table[rep_name][RECURSIVE] == true then
      upgrade(DEFAULT_SAVE_DIRECTORY .. rep_name)
    end
  end
end

return upgrade
