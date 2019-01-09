-- FIXME windows support
APP_STORE_PATH = os.getenv("HOME") .. "/.mp/packages/"
PACKAGES_LIST = "packages.scl"
APP_STORE_URL = "https://github.com/foundpatterns/packages"

cwd = ""
if torchbear.os == "windows" then
  cwd = table.remove(arg, 2) .. "/"
end

print("cwd: " .. cwd)
-- TODO alternative for windows
-- requires sudo
MP_PATH = cwd .. "/usr/share/mp/"
APP_STORE = cwd .. "/usr/share/"
-- APP_STORE = os.getenv("HOME") .. "/.mp/"
APP_STORE_BIN = cwd .. "/usr/bin/"

-- FIXME: use config
if torchbear.os == "android" then
  APP_STORE = "/data/data/com.termux/files/usr/share/"
  APP_STORE_BIN = "/data/data/com.termux/files/usr/bin/"
end

DEFAULT_PATH           = "./"
DEFAULT_SAVE_DIRECTORY = ".mp/"

-- SCL file keys
URL           = "url"
RECURSIVE     = "recursive"
EXPORT        = "export"
PLUCK         = "pluck"
REPO          = "repo"
LOCAL_IMPORT  = "local_import"


-- TODO enable the following.

-- -- Machu Picchu
-- -- a general-purpose package manager
--
-- -- `torchbear.os` return either "linux", "windows" or "android" if required to perform specific configs.
--
-- CONFIG_FILES_PATH = "./configs/"
-- BASE_CONF = "application.scl"
--
-- config = {}
--
-- function append_config(path, name)
--   config = table.merge(config, get_table_from(path, name))
--   return config
-- end
--
-- append_config(CONFIG_FILES_PATH, BASE_CONF)
