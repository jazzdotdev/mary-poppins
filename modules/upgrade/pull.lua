-- todo better names and organization?
return function(rep_path)
  if not fs.exists(rep_path) then
    log.error("Dependency does not exist!\nPlease run `mp unpack` first or reinstall the package")
    os.exit(2)
  end
  if torchbear.os == "android" then
    os.execute("git -C " .. rep_path .. " pull")
  else
    git.pull(rep_path, "origin", "master")
  end
end
