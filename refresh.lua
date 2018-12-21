-- get file from remote server
-- udpates existing file 
local function refresh() 
  git.reset(REPOSITORY_HOME, "origin/master", "hard")
  git.pull(REPOSITORY_HOME, "origin", "master")
end

return refresh
