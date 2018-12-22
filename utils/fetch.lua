function fetch(url, rep_name, save_dir)
  save_dir = save_dir or DEFAULT_SAVE_DIRECTORY

  if torchbear.os == "windows" then
    save_dir = cwd .. save_dir
  end

  if fs.exists(save_dir .. rep_name) then
    return
  end
  -- TODO: use log
  print("Cloning: " .. url)
  if torchbear.os == "android" then
    os.execute("git clone " .. url .. " " .. save_dir .. rep_name)
  else
    git.clone(url, save_dir .. rep_name)
  end
end
