local function install(name)

  local packages_table = get_table_from(config["APP_STORE_PATH"], config["PACKAGES_LIST"])

  if packages_table[name] == nil then
    print("Package not found")
    return
  end

  fetch(packages_table[name], name, config["APP_STORE"])
  local src_path = string.format("%s/%s/init.lua", config["APP_STORE"], name)
  local dest_path = string.format("%s/%s", config["APP_STORE_BIN"], name)
  fs.symlink(src_path, dest_path)
end

return install
