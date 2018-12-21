#!/usr/bin/env torchbear

-- Machu Picchu
-- a general-purpose package manager

-- FIXME windows support
REPOSITORY_HOME = os.getenv("HOME") .. "/.mp/packages/"
MANIFEST_FILE = "manifest.scl"
REPOSITORY_URL = "https://github.com/foundpatterns/packages"
-- TODO alternative for windows
-- requires sudo 
MP_HOME = "/usr/share/mp/"
INSTALL_HOME = "/usr/share/"
-- INSTALL_HOME = os.getenv("HOME") .. "/.mp/"

DEFAULT_PATH           = "./"
DEFAULT_SAVE_DIRECTORY = ".mp/"

-- SCL file keys
URL       = "url"
RECURSIVE = "recursive"
EXPORT    = "export"
PLUCK     = "pluck"
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
  git.clone(url, save_dir .. rep_name)
end

function get_table_from(path, name)
  name = name or "/import.scl"
  -- todo: fix path handling
  local scl_file = fs.read_file(path .. name)
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
  sync   = require"sync",
  update = require"update",
  refresh = require"refresh",
  search = function() require"search"(package_name) end,
  install = function() require"install"(package_name) end,
  help   = usage

})[cmd] or usage)()
