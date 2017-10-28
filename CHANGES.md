# tapered version history

## *1.0-0* (July 10, 2015)

+ Initial public release

## *1.0-1* (July 10, 2015)

+ Fix rockspec: the URL for Bitbucket was wrong.

## *1.1-0* (July 13, 2015)

+ Improve organization and coverage of tests
+ Refactor the `same` method
+ Remove `same_mt`
+ Meaningful exit statuses via `done`
+ Add CI via [drone.io][dio]

[dio]: https://drone.io/bitbucket.org/telemachus/tapered/latest

## *1.2.0-1* (July 19, 2015)

+ Clean up code using luacheck and luacov
+ Small tweaks to README and CHANGES
+ Fix version number: the previous two digit number was a mistake, based on
  a misunderstanding of LuaRocks conventions. This is an annoying switch, but
  better now than later. And better to do it than to live with a versioning
  pattern I dislike.

## *1.2.1-1* (December 5, 2015)

+ Test coverage stats are now thanks to [codecov][codecov].
+ Latest stable Lua in the 5.3 series is 5.3.2, so we test against that now.

[codecov]: https://codecov.io

## *2.0.0-1* (May 1, 2016)

+ The informational fields are now functions that return strings. This is to prevent them from violating Lua recommendations about variables such as `_VERSION`. (I've bumped the major version number since this is technically an API change, though for most users it will not require any changes on their end.)

## *2.0.1-1* (May 2, 2016)

+ Fix a typo in the documentation.
+ Adjust the `version()` return value to show only software version, not the rockspec version as well.

## *2.1.0-1* (July 21, 2016)

+ Update to test against Lua 5.3.3

## *2.2.0-1* (February 11, 2017)

+ Update to test against Lua 5.3.4
+ The repo is now housed on [Github](https://github.com/telemachus/tapered)
+ CI is now provided by [Travis.ci](https://travis-ci.org/telemachus/tapered)

## *2.3.0-1* (October 15, 2017)

+ Remove `setup()` and `teardown()`
+ Update to use luarocks 2.4.3 for testing on Travis

Would you rather view the [documentation][d]?

[d]: /README.md

---

(c) 2012-2017 Peter Aronoff. BSD 3-Clause license; see [LICENSE.md][l] for
details.

[l]: /LICENSE.md
