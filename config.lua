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
