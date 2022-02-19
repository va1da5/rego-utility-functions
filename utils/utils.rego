package utils

compact(array) = output {
	output := [value |
		value := array[_]
		not is_null(value)
		not value == false
		not value == ""
		not value == 0
		not value == []
		not value == {}
	]
}

every(array, match) {
	count([value |
		value := array[_]
		value == match
	]) == count(array)
} else = false {
	true
}

get(object, path) = output {
	[obj_path, value] = walk(object)
	path_array := to_path(path)
	obj_path == path_array
	output := value
}

get_or_default(object, path, default_value) = output {
	output := get(object, path)
} else = output {
	output := default_value
}

has(object, path) {
	[obj_path, value] = walk(object)
	obj_path == to_path(path)
} else = false {
	true
}

includes(array, value) {
	value == array[_]
} else = false {
	true
}

index_by(array, fraction) = output {
	some i
	item = array[i]
	is_fraction(item, fraction)
	output := i
} else = output {
	output := -1
}

index_of(array, value) = output {
	some i
	item = array[i]
	item == value
	output := i
} else = output {
	output := -1
}

is_null_or_false(value) = output {
	output := is_null(value)
} else = output {
	output := value == false
}

is_fraction(object, fraction) {
	search_keys = keys(fraction)
	count({key |
		key = search_keys[_]
		object[key] == fraction[key]
	}) == count(search_keys)
} else = false {
	true
}

keys(object) = output {
	output := {key |
		[path, value] = walk(object)
		key := path[0]
	}
}

size(collection) = output {
	is_string(collection)
	output := count(collection)
} else = output {
	output := count(keys(collection))
}

to_array(set) = output {
	output := [value |
		value := set[_]
	]
}

to_set(array) = output {
	output := {value |
		value := array[_]
	}
}

_parse_array_index(value) = output {
	contains(value, "[")
	number_string := substring(value, 1, count(value) - 2)
	output = try_to_number(number_string)
} else = output {
	output = value
}

to_path(path) = output_array {
	output_array := [value |
		part := split(path, ".")[_]
		value := _parse_array_index(part)
	]
}

try_to_number(string) = out {
	out := to_number(string)
} else = out {
	out := string
}
