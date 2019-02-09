return function(name) 
  local packages_table = get_table_from(config["app_store_path"], config["packages_list"])

  local src_path = fs.join(config["app_store"], name)
  local dest_path = fs.join(config["app_store_bin"], name)

  if packages_table[name] == nil or not fs.exists(src_path) then
    log.error("Package not found")
    return
  end

  if fs.exists(dest_path) then 
    fs.remove_file(dest_path)
  end

  fs.remove_dir(src_path, true)
end