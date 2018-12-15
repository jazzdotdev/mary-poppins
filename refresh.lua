-- get file from remote server
-- udpates existing file 
local function refresh() 
	-- place holder url
	os.execute("curl https://raw.githubusercontent.com/foundpatterns/machu-picchu/master/import.scl --create-dirs -o ~/.mp/packages.scl")

end

return refresh 