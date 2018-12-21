#!/usr/bin/env torchbear

-- Machu Picchu
-- a general-purpose package manager

-- FIXME windows support
REPOSITORY_HOME = os.getenv("HOME") .. "/.mp/packages/"
MANIFEST_FILE = "manifest.scl"
REPOSITORY_URL = "https://github.com/foundpatterns/packages"

cwd = ""
if torchbear.os == "windows" then
  cwd = table.remove(arg, 2) .. "/"
end

print("cwd: " .. cwd)
-- TODO alternative for windows
-- requires sudo
MP_HOME = cwd .. "/usr/share/mp/"
INSTALL_HOME = cwd .. "/usr/share/"
-- INSTALL_HOME = os.getenv("HOME") .. "/.mp/"
BIN_HOME = cwd .. "/usr/bin/"

-- FIXME: use config
if torchbear.os == "android" then
  INSTALL_HOME = "/data/data/com.termux/files/usr/share/"
  BIN_HOME = "/data/data/com.termux/files/usr/bin/"
end

DEFAULT_PATH           = "./"
DEFAULT_SAVE_DIRECTORY = ".mp/"

-- SCL file keys
URL       = "url"
RECURSIVE = "recursive"
EXPORT    = "export"
PLUCK     = "pluck"
REPO 	  = "repo"
LOCAL_IMPORT = "local_import"


-- todo: fs: add `basename` function
local argv0 = string.match(table.remove(arg, 1), "[^/\\]+$")

local function usage(f)
  f = f or io.stderr
  f:write(
    string.format('usage: %s [sync]\n', argv0),
    string.format('usage: %s update\n', argv0),
    string.format('usage: %s refresh\n', argv0),
    string.format('usage: %s install <package-name>\n', argv0),
    string.format('usage: %s search <package-name>\n', argv0),
    string.format('usage: %s help\n', argv0)
  )
  os.exit(f ~= io.stderr)
end

function fetch(url, rep_name, save_dir)
  save_dir = save_dir or DEFAULT_SAVE_DIRECTORY

  if torchbear.os == "windows" then
    save_dir = cwd .. save_dir
  end

  if fs.exists(save_dir .. rep_name) then
    return
  end
  -- TODO: use log
  print("Cloning: " .. url)
  if torchbear.os == "android" then
	os.execute("git clone " .. url .. " " .. save_dir .. rep_name)
  else
  	git.clone(url, save_dir .. rep_name)
  end
end

function get_table_from(path, name)
  name = name or "/import.scl"
  -- todo: fix path handling
  if torchbear.os == "windows" then
    path = cwd .. path
  end
  print("path: " .. path)
  print("name:" .. name)
  local scl_file = fs.read_file(path .. name)
  print(scl_file)
  return scl.to_table(scl_file)
end

local cmd = table.remove(arg, 1)
local package_name = table.remove(arg, 1)
if cmd == "install" or cmd == "search" then
  if package_name == "" or package_name == nil then
    usage()
    return
  end
end

if #arg ~= 0 then
  usage()
end

if cmd ~= "refresh" and fs.exists(REPOSITORY_HOME) == false then
    print("You have to first run: ./mp refresh")
    return
end

(({
  sync   = require"commands/sync/sync",
  update = require"commands/upgrade/upgrade",
  refresh = require"commands/refresh/refresh",
  search = function() require"commands/search/search"(package_name) end,
  install = function() require"commands/install/install"(package_name) end,
  help   = usage

})[cmd] or usage)()
