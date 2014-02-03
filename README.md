# lua-tap

Very minimal tap testing for Lua. Arguably too minimal.

Available functions and assertions. The `message` parameter is always
optional. The messages help make test output clearer to readers, but are
not needed if the output goes straight to another program for parsing.

+ `ok(expression, message)` Tests whether `expression` returns a truthy
  value.
+ `nok(expression, message)` Tests whether `expression` returns a falsy
  value.
+ `is(actual, expected, message)` Tests whether `actual` is equal to
  `expected`. The test uses `==` internally.
+ `isnt(actual, expected, message)` Tests whether `actual` is not equal to
  `actual`. The test uses `~=` internally.
+ `same(actual, expected, message)` Tests whether `actual` is a deep copy
  of `expected`. Useful for comparing tables.
+ `same_mt(actual, expected, message)` Tests whether `actual` is a deep
  copy of `expected`, using the `__eq` method in their metatables if such
  a method is found. Useful for comparing tables or objects.
+ `like(string, pattern, message)` Tests whether `string` matches the given
  `pattern`.
+ `unlike(string, pattern, message)` Tests whether `string` does not match
  the given `pattern`.
+ `pass(message)` A test that always passes.
+ `fail(message)` A test that always fails.
+ `boom(function, args, message)` Calls `function` with `args` as
  parameters and checks to see if an exception is raised. Passes if an
  exception is raised; fails otherwise. (The exception is swallowed.) The
  `args` parameter expects a table. The table can be empty but not `nil`.
+ `done()` Call this function (optionally) at the end of your test file.
  It will print out a line in the form `1..n` where `n` is the total number
  of tests run. This provides for TAP compliance. The call to `done` is not
  otherwise required. If you don't care about TAP compliance, neither does
  the library.
