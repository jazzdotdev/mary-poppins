local pull = require "modules/upgrade/pull"

-- get file from remote server
-- udpates existing file
local function refresh()
  if fs.exists(config["app_store_path"]) then
    git.reset(config["app_store_path"], "origin/master", "hard")
    pull(config["app_store_path"])
  else
    fetch(config["app_store_url"], "", config["app_store_path"])
  end
end

return refresh
