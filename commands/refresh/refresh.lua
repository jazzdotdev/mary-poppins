local pull = require "pull"

-- get file from remote server
-- udpates existing file
local function refresh()
  if fs.exists(config["APP_STORE_PATH"]) then
    git.reset(config["APP_STORE_PATH"], "origin/master", "hard")
    pull(config["APP_STORE_PATH"])
  else
    fetch(config["APP_STORE_URL"], "", config["APP_STORE_PATH"])
  end
end

return refresh
