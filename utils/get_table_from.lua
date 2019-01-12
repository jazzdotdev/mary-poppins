function get_table_from(path, name)
	name = name or "/import.scl" 

  if torchbear.os == "windows" then
    path = fs.join(cwd, path)
	end
	
	scl_path = fs.join(path, name)

	if not fs.exists(scl_path) then
		print("Error import.scl file not found: " .. scl_path)
		os.exit(1)
  end

  local scl_file = fs.read_file(scl_path)

  return scl.to_table(scl_file)
end
