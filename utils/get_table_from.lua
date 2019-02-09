function get_table_from(path, name)
	name = name or config["manifest"] 

  if torchbear.os == "windows" then
    path = fs.join(cwd, path)
	end
	
	scl_path = fs.join(path, name)

	if not fs.exists(scl_path) then
		log.error("Error manifest.scl file not found: " .. scl_path)
		os.exit(1)
  end

  local scl_file = fs.read_file(scl_path)

  return scl.to_table(scl_file)
end
