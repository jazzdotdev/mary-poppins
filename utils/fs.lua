-- This file should be removed one day and its function built-in torchbear.

-- OS = 'windows'
OS = 'linux'

if OS == 'windows' then
  SEPARATOR = '\\'
elseif OS == 'linux' then
  SEPARATOR = '/'
end

if not fs then
  print("Panic, this is wrong.")
  fs = {}
end


fs.basename = function(path)
  return string.match(path, "[^" .. SEPARATOR .. "]+$")
end

fs.expand_path = function(...)
  local err = nil
  local path = fs.join(...)
  local abspath = fs.canonicalize(path)
  if abspath == nil then
    err = "can't get absolute path of " .. path
  end
  return abspath, err
end
