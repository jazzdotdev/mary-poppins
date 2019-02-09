local function search(name)

  -- TODO Should be possible to have multiple app store lists.
  local packages_table = get_table_from(config["app_store_path"], config["packages_list"])
  local found_any = false

  for package_name, _ in pairs(packages_table) do
    local s1 = string.lower(package_name)
    local s2 = string.lower(name)
    -- name is same or either is a substring of other one
    -- FIXME lua considers - a special character, if possible, escape it
    if s1 == s2 or s2:match(s1) or s1:match(s2) then
      log.info(package_name)
      found_any = true
    end
  end
  if found_any == false then
    log.error("No package found")
  end
end

return search
