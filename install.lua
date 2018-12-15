local function install(name) 

	local packages_table = get_table_from(REPOSITORY_HOME, MANIFEST_FILE)

	if packages_table[name] ~= nil then
		fetch(packages_table[name], name, INSTALL_HOME)
		return
	else 
		print("Package not found")
	end
end

return install
