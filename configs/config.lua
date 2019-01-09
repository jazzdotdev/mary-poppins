-- Machu Picchu
-- a general-purpose package manager

-- `torchbear.os` return either "linux", "windows" or "android" if required to perform specific configs.

CONFIG_FILES_PATH = "./configs/"
BASE_CONF = "application.scl"

config = {}

-- FIXME windows support
config["app_store_path"] = os.getenv("HOME") .. "/.mp/packages/"
config["packages_list"] = "packages.scl"
config["app_store_url"] = "https://github.com/foundpatterns/packages"

cwd = ""
if torchbear.os == "windows" then
  cwd = table.remove(arg, 2) .. "/"

  print("cwd: " .. cwd)
end

-- TODO alternative for windows
-- requires sudo
config["mp_path"] = cwd .. "/usr/share/mp/"
config["app_store"] = cwd .. "/usr/share/"
-- config["app_store"] = os.getenv("HOME") .. "/.mp/"
config["app_store_bin"] = cwd .. "/usr/bin/"

-- FIXME: use config
if torchbear.os == "android" then
  config["app_store"] = "/data/data/com.termux/files/usr/share/"
  config["app_store_bin"] = "/data/data/com.termux/files/usr/bin/"
end

config["default_path"]           = "./"
config["default_save_directory"] = ".mp/"

-- SCL file keys
config["url"]           = "url"
config["recursive"]     = "recursive"
config["export"]        = "export"
config["pluck"]         = "pluck"
config["repo"]          = "repo"
config["local_import"]  = "local_import"


-- TODO enable the following.
--
-- function append_config(path, name)
--   config = table.merge(config, get_table_from(path, name))
--   return config
-- end
--
-- append_config(CONFIG_FILES_PATH, BASE_CONF)
