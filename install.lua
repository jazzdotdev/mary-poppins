local function install(name) 

	local packages_table = get_table_from(REPOSITORY_HOME, MANIFEST_FILE)

	if packages_table[name] == nil then
		print("Package not found")
		return
	end

	fetch(packages_table[name], name, INSTALL_HOME) 
	-- TODO use bindings
	os.execute(string.format("ln -s %s/%s/init.lua /usr/bin/%s ", INSTALL_HOME, name, name))
	
end

return install
