-- todo better names and organization?
return function(rep_path)
  if torchbear.os == "android" then
    os.execute("git -C " .. rep_path .. " pull")
  else
    git.pull(rep_path, "origin", "master")
  end
end
