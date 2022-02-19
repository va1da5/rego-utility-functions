package utils

test_compact {
	array = [
		"a",
		false,
		null,
		0,
		[],
		{},
	]

	["a"] == compact(array)
	[] == compact([false])
}

test_to_path {
	["a", "b", "c"] == to_path("a.b.c")
	["a", 123, "c"] == to_path("a.[123].c")
}

test_is_null_or_false {
	is_null_or_false(null) == true
	is_null_or_false(false) == true
}

test_get {
	obj = {"a": {"b": [0, 1, {"c": "valid"}, {"d": false}]}}

	"valid" == get(obj, "a.b.[2].c")
	"valid" == get(obj, "a.b.[2].c")

	not get(obj, "a.b.[0].foo.bar")
}

test_get_or_default {
	obj = {"a": {"b": [0, 1, {"c": "valid"}, {"d": false}]}}

	"valid" == get_or_default(obj, "a.b.[2].c", false)
	false == get_or_default(obj, "a.b.[3].d", false)
	"does not exist" == get_or_default(obj, "a.b.[123].c", "does not exist")
	"does not exist" == get_or_default(obj, "a.b.[0].foo.bar", "does not exist")
}

test_has {
	obj = {"a": {"b": [0, 1, {"c": true}, {"d": false}]}}
	has(obj, "a.b.[2].c") == true
	has(obj, "a.b.[3].d") == true
	has(obj, "a.b.[123].c") == false
	has(obj, "a.b.[2].d") == false
}

test_keys {
	obj = {"a": 1, "b": 2, "c": 3, "d": {"e": 4}}
	arr = ["a", "b", "c", "d"]
	keys(obj) == {"a", "b", "c", "d"}
	keys(arr) == {0, 1, 2, 3}
}

test_is_fraction {
	obj = {"a": 2, "b": 3, "c": false, "d": "hello", "e": {"hello": "world"}}

	is_fraction(obj, {"a": 2})
	is_fraction(obj, {"a": 2, "b": 3})
	is_fraction(obj, {"a": 2, "c": false})
	is_fraction(obj, {"a": 2, "c": true}) == false
	is_fraction(obj, {"e": {"hello": "world"}})
	is_fraction(obj, {"e": {}}) == false
}

test_every {
	every([true, true, true], true) == true
	every([false, false, false], false) == true
	every([true, false, true], true) == false
	every([false, true, false], false) == false
	every([1, 1, 1], 1) == true
	every([1, 2, 3], 1) == false
	every([null, null], null) == true
	every(["", ""], "") == true
}

test_includes {
	includes(["a", "b", "c"], "b") == true
	includes([2, 3, 4, 5], 4) == true
	includes(["a", null, "c"], null) == true
	includes(["a", false, 3], false) == true
	includes(["a", false, 3], true) == false
}

test_size {
	size([]) == 0
	size([1, 2, 3]) == 3
	size([1, 2, 3, 4, 5]) == 5
	size([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) == 10
	size({"a": 0, "b": 1, "c": 2}) == 3
	size("hello") == 5
}

test_to_set {
	{"a", "b"} == to_set(["a", "b", "b", "a"])
	{"a", "b", null} == to_set(["a", "b", "b", null])
	{1, false, null} == to_set([1, 1, false, null, false])
}

test_to_array {
	["a", "b"] == to_array({"a", "b"})
	["a", "b"] == to_array({"b", "a"})
	[null, "a", "b"] == to_array({"a", "b", null})
	[null, false, 1] == to_array({1, false, null})
	[null, false, true, 1, "a", "z", {}] == to_array({1, true, false, null, "a", {}, "z"})
}

test_index_of {
	index_of(["a", 1, {}, false, null], "a") == 0
	index_of(["a", 1, {}, false, null], 1) == 1
	index_of(["a", 1, {}, false, null], {}) == 2
	index_of(["a", 1, {}, false, null], false) == 3
	index_of(["a", 1, {}, false, null], null) == 4
	index_of(["a", 1, {}, false, null], "nop") == -1
}

test_index_by {
	array := [{"a": 1, "b": 2}, {"a": 3, "b": 4}, {"a": 5, "b": 6}]
	index_by(array, {"a": 1}) == 0
	index_by(array, {"a": 3}) == 1
	index_by(array, {"b": 6}) == 2
	index_by(array, {"b": 3}) == -1
}

test_try_to_number {
	try_to_number("1") == 1
	try_to_number("1.2") == 1.2
	try_to_number("1.2.3") == "1.2.3"
	try_to_number("test") == "test"
}
