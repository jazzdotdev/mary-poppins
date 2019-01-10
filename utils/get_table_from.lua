function get_table_from(path, name)
  name = name or "/import.scl"
  -- todo: fix path handling

  if torchbear.os == "windows" then
    path = cwd .. path
  end

  local scl_file = fs.read_file(path .. name)

  return scl.to_table(scl_file)
end
