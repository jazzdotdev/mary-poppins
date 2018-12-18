require "file_sync"

local function sync(path, base_path)
  path = path or DEFAULT_PATH
  base_path = base_path or "."
  local scl_file_path = base_path .. "/" .. path
  local table = get_table_from(scl_file_path)

  for rep_name, destination in pairs(table.imports) do
        -- download the repo if url is provided
    if table[rep_name][URL] ~= nil then
      fetch(table[rep_name][URL], rep_name)
    -- local import directive used
    elseif table[rep_name][LOCAL_IMPORT] == true then
      sync(rep_name, ".")
    end

    -- check if recursive
    if table[rep_name][RECURSIVE] == true then
      -- no nesting
      sync(rep_name, DEFAULT_SAVE_DIRECTORY)
    end

    -- TODO verify

    if table[rep_name][PLUCK] ~= nil then
      pluck(path, rep_name, destination, table[rep_name][PLUCK])
    elseif table[rep_name][EXPORT] ~= nil then
      export(path, rep_name, destination, table[rep_name][EXPORT])
    -- if local import does exist, then file won't be in `.mp/` so copy is not possible
    elseif table[rep_name][LOCAL_IMPORT] == nil then
      full_copy(path, rep_name, destination)
    end
  end
end

return sync
