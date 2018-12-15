local function install(name) 

	local packages_table = get_table_from(REPOSITORY_HOME, "packages.scl")

	for package_name, values in pairs(packages_table) do 
		if (package_name == name) then
			fetch(values[URL], package_name, REPOSITORY_HOME)
			return
		end
	end
	print("Package not found")
end

return install
