local scl_file = fs.read_file("import.scl")
local table = scl.to_table(scl_file)

os.execute("git clone " .. table.packages[1])

return 0
