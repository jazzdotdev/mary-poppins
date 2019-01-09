local pull = require "pull"

local function upgrade(path)
  path = path or config["default_path"]
  local table = get_table_from(path)
  for rep_name, location in pairs(table.imports) do
    pull(config["default_save_directory"] .. rep_name)

    if table[rep_name][recursive] == true then
      upgrade(config["default_save_directory"] .. rep_name)
    end
  end
end

return upgrade
