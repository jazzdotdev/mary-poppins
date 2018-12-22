-- This file should be removed one day and its function built-in torchbear.

-- OS = 'windows'
OS = 'linux'

if OS == 'windows'
  SEPARATOR = '\\'
elseif OS == 'linux'
  SEPARATOR = '/'
end

if not fs then
  print("Panic, this is wrong.")
  fs = {}
end


fs.basename = function(path)
  return string.match(path, "[^" .. SEPARATOR .. "]+$")
end

fs.expand_path = function(file_name, dir_string)
  if not dir_string then
    return file_name
  end

  -- local pwd = os.getenv("PWD")
  local pwd, _ = string.gsub(debug.getinfo(1).short_src, "^(.+" .. SEPARATOR .. ")[^" .. SEPARATOR .. "]+$", "%1")
  if pwd.sub(1, 1) == SEPARATOR then
    pwd = pwd.sub(1, -1)
  end

  if not dir_string[1] == SEPARATOR then
    local pos, l_ = string.find(dir_string, '..')

    while pos do
      if pos == 1 then
        -- TODO
        string.find(pwd, SEPARATOR)
      else
        -- TODO
        string.find(pwd, SEPARATOR)
      end

      pos, l_ = string.find(dir_string, '..')
    end
  end

  return dir_string .. file_name
end
