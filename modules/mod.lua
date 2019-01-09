modules = {
  sync   = require"modules/sync/sync",
  upgrade = require"modules/upgrade/upgrade",
  refresh = require"modules/refresh/refresh",
  search = function() require"modules/search/search"(package_name) end,
  install = function() require"modules/install/install"(package_name) end,
  help   = usage
}
