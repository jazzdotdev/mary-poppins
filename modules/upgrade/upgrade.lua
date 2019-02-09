local pull = require "modules/upgrade/pull"
local unpack = require "modules/unpack/unpack"

local function upgrade(name)
  local store_table = 
      get_table_from(config["app_store_path"], config["packages_list"])
  local package_path = fs.join(config["app_store"], name)

  -- if dependencies in current working directory should be updated
  if name == "." then
    package_path = "."
  elseif store_table[name] == nil or not fs.exists(package_path) then
    print("Package not found")
    return
  end

  local package_table = get_table_from(package_path)
  upgrade_packages(package_table, package_path)

  -- upgrades the packages
  unpack(package_path, fs.join(package_path, config["default_save_directory"]))
end

-- package_table: manifest.scl for the app
-- package_path: location of home app, not dependency
function upgrade_packages(package_table, package_path)
    mp_path = fs.join(package_path, config["default_save_directory"])

    for rep_name, location in pairs(package_table.imports) do
      -- updates the packages in `default_save_directory`
      pull(fs.join(mp_path, rep_name))
      print("Upgrading: " .. rep_name)
 
      -- check if recursive
      if package_table[rep_name][recursive] == true or 
        package_table[rep_name][config["repo"]] == true then
        upgrade_packages(get_table_from(
          fs.join(mp_path, rep_name)), package_path)
      end
    end
 end

return upgrade
