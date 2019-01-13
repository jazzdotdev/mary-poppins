local sync = require "modules.sync.sync"

local function install(name)

  local packages_table = get_table_from(config["app_store_path"], config["packages_list"])

  if packages_table[name] == nil then
    print("Package not found")
    return
  end

  fetch(packages_table[name], name, config["app_store"])

  local src_path = fs.join(config["app_store"], name, "init.lua")
  local dest_path = fs.join(config["app_store_bin"], name)

  -- if symlink already exists, remove that
  if fs.exists(dest_path) then
    fs.remove_file(dest_path)
	end
	
	-- install dependencies
	sync(fs.join(config["app_store"], name),
			fs.join(config["app_store"], name, ".mp"))

  fs.symlink(src_path, dest_path)
end

return install
