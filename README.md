# tapered [![Build Status](https://travis-ci.org/telemachus/tapered.svg?branch=master)](https://travis-ci.org/telemachus/tapered) [![Coverage](https://codecov.io/gh/telemachus/tapered/branch/master/graph/badge.svg)](https://codecov.io/gh/telemachus/tapered)

## Synopsis

Very minimal tap testing for Lua. Arguably too minimal.

## Assertions

The `message` parameter is always optional. Brief messages help make test output
clearer to readers, but are not needed if the output goes straight to another
program for parsing.

+ `ok(expression, [message])` Tests whether `expression` returns a truthy
  value.

+ `nok(expression, [message])` Tests whether `expression` returns a falsy
  value.

+ `is(actual, expected, [message])` Tests whether `actual` is equal to
  `expected`. The test uses `==` internally.

+ `isnt(actual, expected, [message])` Tests whether `actual` is not equal to
  `actual`. The test uses `~=` internally.

+ `same(actual, expected, [message])` Tests whether `actual` is a deep copy
  of `expected`. The test uses an `__eq` metamethod if one is found. Useful
  for comparing tables.

+ `like(string, pattern, [message])` Tests whether `string` matches the given
  `pattern`.

+ `unlike(string, pattern, [message])` Tests whether `string` does not match
  the given `pattern`.

+ `pass([message])` A test that always passes. Useful as a quasi-skip with a
  message.

+ `fail([message])` A test that always fails. Useful as a quasi-TODO with a
  message.

+ `boom(function, args, [message])` Calls `function` with `args` as
  parameters and checks to see if an exception is raised. Passes if an
  exception is raised; fails otherwise. (The exception is swallowed.) The
  `args` parameter expects a table. The table can be empty but not `nil`.

## Helper method

A method is available to show how many tests were run. (This output
is required for [TAP compliance][tap], which may matter in some cases.) 

[tap]: http://testanything.org/tap-specification.html

+ `done([number])` Call this function (optionally) at the end of your test file.
  It will print out a line in the form `1..n` where `n` is the total number
  of tests run. This secures TAP compliance when needed. The call to `done`
  is not otherwise required. If you don't care about TAP compliance, neither does
  the library. If you pass the optional parameter to the method, it will check
  whether the number of tests you expected matches the number of actual tests.
  Thus, if can function like a traditional `plan` method. However, this method
  should always be called *last* in your tap file, unlike `plan` methods which
  normally start the test file.

  Another reason to use `done` is if you care about the exit status of the
  tests. Many continuous integration tools rely on tests signalling success or
  failure via their exit status. After `done` is called, the script will exit
  with a status of 0, indicating success, if all tests passed. If some tests
  failed, the script will exit with a status equal to the number of failed
  tests, indicating failure. A script will also exit with an error status if
  there is a mismatch between the actual number of tests run and the number
  passed to `done` as a parameter.

## Varia

The module provides four informational functions that return strings. They
should be self-explanatory.

+ `version() -- 2.3.0`

+ `author() -- Peter Aronoff`

+ `url() -- https://github.com/telemachus/tapered.git`

+ `license() -- BSD 3-Clause`

## Credits

For the `same` method I took ideas and code from [Penlight][p], [Underscore][u],
[luassert][l], and [cwtest][cw]. I thank all the people who worked on those.

Indirect inspirations include [knock][k], [Test::More][tm], and [bats][b]—not so
much for code as for ideas about testing and simplicity.

Thanks in particular to [Pierre Chapuis][pchapuis] for help with ideas and
getting continuous integration for tapered.

An anonymous email showed me that my setup and teardown methods had a logical
flaw. As a result, I've removed those methods. I appreciate the report.

All the mistakes are mine. See [version history][c] for release details.

[p]: https://github.com/stevedonovan/Penlight
[u]: https://github.com/mirven/underscore.lua
[l]: https://github.com/Olivine-Labs/luassert
[cw]: https://github.com/catwell/cwtest
[k]: https://github.com/chneukirchen/knock
[tm]: http://search.cpan.org/perldoc?Test::More
[b]: https://github.com/sstephenson/bats
[c]: /CHANGES.md
[pchapuis]: https://twitter.com/pchapuis

---

(c) 2012-2017 Peter Aronoff. BSD 3-Clause license; see [LICENSE.md][li] for
details.

[li]: /LICENSE.md
