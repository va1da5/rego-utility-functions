# Rego Utility Functions

[utils.rego](./utils/utils.rego) contains utility functions for helping with Open Policy Agent (OPA) rule development. The functions could be used as it is, or as a starting point for your own functions. It was heavily inspired by [Lodash](https://lodash.com/) library.

## Functions

- [`compact(array)`](./utils/utils.rego#L3) - Creates an array with all falsey values removed. The values `false`, `null`, `0`, `""`, `{}` and `[]` are considered falsey.

  ```rego
  out := compact(["a", false, null, 0, "", [], {}])
  out # [ "a" ]
  ```

  Arguments:
    - `array` (*array*): The array to compact.


- [`every(array, match)`](./utils/utils.rego#L15) - Checks if `match` value matches to all items in array.

  ```rego 
  every([true, true, true], true) # true
  every([true, false, true], true) # false
  every([false, false], false) # true
  ```

  Arguments:
    - `array` (*array*): The array to check.
    - `match` (*any*): The value to check against.


- [`get(object, path)`](./utils/utils.rego#L24) - Gets the value at `path` of `object`.

  ```rego
  get({"a": {"b": {"c": 1}}}, "a.b.c") # 1
  get({"a":[null, {"b": "hello"}]}, "a[1].b") # "hello"
  ```

  Arguments:
    - `object` (*object*): The object to get the value from.
    - `path` (*string*): The path to get the value from.


- [`get_or_default(object, path, default_value)`](./utils/utils.rego#L31) - Gets the value at `path` of `object`. If the resolved value is `undefined`, the `default_value` is returned in its place.

  ```rego
  get_or_default({"a": {"b": {"c": 1}}}, "a.b.c", null) # 1
  get_or_default({"a":[null, {"b": "hello"}]}, "a[1].b", null) # "hello"  
  get_or_default({"a": "b"}, "a.does.not.exist", "default") # "default"
  ```

  Arguments:
    - `object` (*object*): The object to get the value from.
    - `path` (*string*): The path to get the value from.
    - `default_value` (*any*): The value to return if the resolved value is `undefined`.


- [`has(object, path)`](./utils/utils.rego#L37) - Checks if `path` exists on `object`.

  ```rego
  has({"a": {"b": {"c": 1}}}, "a.b.c") # true
  has({"a":[null, {"b": "hello"}]}, "a[1].b") # true
  has({"a": "b"}, "a.does.not.exist") # false
  ```

  Arguments:
    - `object` (*object*): The object to check.
    - `path` (*string*): The path to check.

- [`includes(array, value)`](./utils/utils.rego#L44) - Checks if `value` exists in `array`.

  ```rego
  includes([1, 2, 3], 2) # true
  includes([1, 2, 3], 4) # false
  ```

  Arguments:
    - `array` (*array*): The array to check.
    - `value` (*any*): The value to check.

- [`index_by(array, fraction)`](./utils/utils.rego#L50) - Gets index of object in array that matches provided fraction object.

  ```rego
  index_by([{"a": 1, "b": 2}, {"a": 3, "b": 4}, {"a": 5, "b": 6}], {"a": 3}) # 1
  index_by([{"a": 1, "b": 2}, {"a": 3, "b": 4}, {"a": 5, "b": 6}], {"b": 6}) # 2
  index_by([{"a": 1, "b": 2}, {"a": 3, "b": 4}, {"a": 5, "b": 6}], {"c": 1}) # -1
  ```

  Arguments:
    - `array` (*array*): The array to check.
    - `fraction` (*object*): The object fraction to check.

- [`index_of(array, value)`](./utils/utils.rego#L59) - Gets index of `value` in `array`.

  ```rego
  index_of([1, 2, 3], 2) # 1
  index_of([1, 2, 3], 4) # -1
  ```

  Arguments:
    - `array` (*array*): The array to check.
    - `value` (*any*): The value to check.

- [`is_null_or_false(value)`](./utils/utils.rego#L68) - Checks if `value` is `null` or `false`.

  ```rego
  is_null_or_false(null) # true
  is_null_or_false(false) # true
  is_null_or_false(0) # false
  is_null_or_false("") # false
  ```

  Arguments:
    - `value` (*any*): The value to check.

- [`is_fraction(object, fraction)`](./utils/utils.rego#L74) - Checks if `object` matches `fraction`.

  ```rego
  is_fraction({"a": 1, "b": 2} {"a": 3}) # true
  is_fraction({"a": 5, "b": 6}, {"b": 6}) # true
  is_fraction({"a": 3, "b": 4}, {"c": 1}) # false
  ```

  Arguments:
    - `object` (*object*): The object to check.
    - `fraction` (*object*): The object fraction to check.


- [`keys(object)`](./utils/utils.rego#L84) - Gets the keys of `object`.

  ```rego
  keys({"a": 1, "b": 2}) # [ "a", "b" ]
  ```

  Arguments:
    - `object` (*object*): The object to get the keys from.


- [`size(collection)`](./utils/utils.rego#L91) - Gets the size of `collection`.

  ```rego
  size([1, 2, 3]) # 3
  size({a: 1, b: 2}) # 2
  size("hello") # 5
  ```

  Arguments:
    - `collection` (*array* or *object* or *string*): The collection to get the size of.


- [`to_array(set)`](./utils/utils.rego#L98) - Converts `set` to an array.

  ```rego
  to_array({"a", "b"}) # [ "a", "b" ]
  ```

  Arguments:
    - `set` (*set*): The set to convert to an array.


- [`to_set(array)`](./utils/utils.rego#L104) - Converts `array` to a set.

  ```rego
  to_set([1, 2, 2, 3, 3]) # { 1, 2, 3 }
  ```

  Arguments:
    - `array` (*array*): The array to convert to a set.

- [`to_path(path)`](./utils/utils.rego#L118) - Converts string `path` to a path array.

  ```rego
  to_path("a.b.c") # [ "a", "b", "c" ]
  to_path("a[1].b") # [ "a", 1, "b" ]
  ```

  Arguments:
    - `path` (*string*): The string to convert to a path.

- [`try_to_number(string)`](./utils/utils.rego#L125) - Attempts to converts `string` to a number.

  ```rego
  try_to_number("1") # 1
  try_to_number("1.2") # 1.2
  try_to_number("1.2.3") # "1.2.3"
  try_to_number("hello") # "hello"
  ```

  Arguments:
    - `string` (*string*): The string to convert to a number.


## Testing

Each function is covered by unit tests. The tests could be initiated by the following command:

  ```bash
  opa test -v ./utils/
  # or
  make test
  ```

## References

- [Rego Policy Language](https://www.openpolicyagent.org/docs/latest/policy-language/)
- [Rego Policy Reference](https://www.openpolicyagent.org/docs/latest/policy-reference/)
- [Rego Builtin Functions](https://github.com/open-policy-agent/opa/blob/main/ast/builtins.go)
- [Lodash](https://lodash.com/)

