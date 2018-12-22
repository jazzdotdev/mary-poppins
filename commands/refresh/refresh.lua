local pull = require "pull"

-- get file from remote server
-- udpates existing file
local function refresh()
  if fs.exists(REPOSITORY_HOME) then
    git.reset(REPOSITORY_HOME, "origin/master", "hard")
    pull(REPOSITORY_HOME)
  else
    fetch(REPOSITORY_URL, "", REPOSITORY_HOME)
  end
end

return refresh
