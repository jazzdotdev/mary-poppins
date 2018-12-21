local function install(name) 

  local packages_table = get_table_from(REPOSITORY_HOME, MANIFEST_FILE)

  if packages_table[name] == nil then
    print("Package not found")
    return
  end

  fetch(packages_table[name], name, INSTALL_HOME)
  local src_path = string.format("%s/%s/init.lua", INSTALL_HOME, name)
  local dest_path = string.format("%s/%s", BIN_HOME, name)
  fs.symlink(src_path, dest_path)
end

return install
