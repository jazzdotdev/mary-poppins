-- syncs the files from `.mp/` to their respective as per import.scl
-- TODO use bindings rather than `os.execute`
file_sync = {}

function pluck(from_path, rep_name, to_path, file_name)
	-- map directories as per `scl` file
	local rep_loc = get_rep_path(rep_name)
	local dest_path = get_dest_path(from_path, to_path)

	os.execute(string.format("mkdir -p %s && cp %s/%s %s", dest_path, rep_loc, file_name, dest_path))
end

function export(from_path, rep_name, to_path, export_directory)
	local rep_loc = get_rep_path(rep_name)
	local export_dir_path = rep_loc .. "/" .. export_directory
	local dest_path = get_dest_path(from_path, to_path)

	os.execute(
		string.format("mkdir -p %s && cp %s/* %s -r", dest_path, export_dir_path, dest_path)
	)
end

function full_copy(from_path, rep_name, to_path)
    local rep_loc = get_rep_path(rep_name)
	local dest_path = get_dest_path(from_path, to_path)
	-- todo: escape shell arguments similar to `gut`
	os.execute(string.format("mkdir -p %s && cp %s/* %s -r", dest_path, rep_loc, dest_path))
end

function get_rep_path(rep_name)
	return DEFAULT_SAVE_DIRECTORY .. rep_name
end

function get_dest_path(from, to)
	return from .. "/" .. to
end
