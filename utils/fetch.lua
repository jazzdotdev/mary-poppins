function fetch(url, rep_name, save_dir)
  save_dir = save_dir or config["default_save_directory"]

  if torchbear.os == "windows" then
    save_dir = fs.join(cwd, save_dir)
  end

  save_dir = fs.join(save_dir, rep_name)

  if fs.exists(save_dir) then
    return
  end
  -- TODO: use log
  print("Cloning: " .. url)
  if torchbear.os == "android" then
    os.execute("git clone " .. url .. " " .. save_dir)
	else 
    git.clone(url, save_dir)
  end
end
