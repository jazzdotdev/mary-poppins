local function install(name)

  local packages_table = get_table_from(config["app_store_path"], config["packages_list"])

  if packages_table[name] == nil then
    print("Package not found")
    return
  end

  fetch(packages_table[name], name, config["app_store"])
  local src_path = string.format("%s/%s/init.lua", config["app_store"], name)
  local dest_path = string.format("%s/%s", config["app_store_bin"], name)
  fs.symlink(src_path, dest_path)
end

return install
