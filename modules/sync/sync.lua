require "modules/sync/file_sync"

local function sync(scl_path, mp_path)
  scl_path = scl_path or config["default_path"] 
  mp_path = mp_path or ".mp"

  process_table(get_table_from(scl_path), scl_path, mp_path)
end

function process_table(table, save_path, mp_path)
  save_path = save_path or "./"
	-- local table = get_table_from(scl_file_path)

  for rep_name, destination in pairs(table.imports) do
    -- download the repo if url is provided
    if table[rep_name][config["url"]] ~= nil then
      fetch(table[rep_name][config["url"]], rep_name, mp_path)

    -- local import directive used
    elseif table[rep_name][config["local_import"]] == true then
      sync(fs.join(".", rep_name))
    end

    -- check if recursive
    if table[rep_name][config["recursive"]] == true then
      -- no nesting
      sync(fs.join(save_path, config["default_save_directory"], rep_name))
    end

	 -- check if repo
    if table[rep_name][config["repo"]] == true then
      local repo_table = get_table_from(fs.join(mp_path, rep_name))
      destination = fs.join(save_path, destination)
      process_table(repo_table, destination, mp_path)
    end

    -- TODO verify

    -- Move files from `.mp/` as per `manifest.scl`
    if table[rep_name][config["pluck"]] ~= nil then
      pluck(save_path, rep_name, 
          destination, table[rep_name][config["pluck"]], 
          mp_path)

    elseif table[rep_name][config["export"]] ~= nil then
      export(save_path, rep_name,
          destination, table[rep_name][config["export"]], 
          mp_path)

      -- if local import does exist, then file won't be in `.mp/` so copy is not possible
      -- if a repo then we don't want to copy the contents
    elseif table[rep_name][config["local_import"]] == nil and table[rep_name][config["repo"]] == nil then
      full_copy(save_path, rep_name, destination, mp_path)
    end
  end
end

return sync
