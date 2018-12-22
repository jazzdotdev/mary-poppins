commands = {
  sync   = require"commands/sync/sync",
  upgrade = require"commands/upgrade/upgrade",
  refresh = require"commands/refresh/refresh",
  search = function() require"commands/search/search"(package_name) end,
  install = function() require"commands/install/install"(package_name) end,
  help   = usage
}
