#!/usr/bin/env torchbear

require 'third-party.path_separator'
require 'third-party.basename'
require 'third-party.sanitize'
require 'third-party.join'
require 'third-party.remove_file'
require 'modules.mod'

-- This should really be refactored
require 'utils.fetch'

-- This should really be refactored
require 'utils.get_table_from'

-- Machu Picchu
-- a general-purpose package manager

require 'configs.config'

local argv0 = fs.basename(table.remove(arg, 1))

local function usage(f)
  if not f then
    f = io.stderr
  end
  f:write(
    string.format('usage: mp unpack\n', argv0),
    string.format('usage: mp refresh\n', argv0),
    string.format('usage: mp upgrade <package-name>\n', argv0),
    string.format('usage: mp install <package-name>\n', argv0),
    string.format('usage: mp search <package-name>\n', argv0),
    string.format('usage: mp uninstall <package-name>\n', argv0),
    string.format('usage: mp [help]\n', argv0)
  )
  os.exit(f ~= io.stderr)
end

local cmd = table.remove(arg, 1)
if cmd == nil then
    usage(io.stdout)
    return
end

-- FIXME
package_name = table.remove(arg, 1)
if cmd == "install" or cmd == "search" 
   or cmd == "uninstall" or cmd == "upgrade" then 
  if package_name == "" or package_name == nil then
    usage()
    return
  end
end

if #arg ~= 0 then
  usage()
end

if cmd ~= "refresh" and not fs.exists(config["app_store_path"]) then
    print("You have to first run: ./mp refresh")
    return
end

(modules[cmd] or usage)()
