modules = {
  unpack   = require"modules/unpack/unpack",
  upgrade = require"modules/upgrade/upgrade",
  refresh = require"modules/refresh/refresh",
  search = function() require"modules/search/search"(package_name) end,
  install = function() require"modules/install/install"(package_name) end,
  uninstall = function() require"modules/uninstall/uninstall"(package_name) end,
  help   = usage
}
