package.path = '../src/?.lua;' .. package.path
local tap = require 'tapered'
local error = error

--- ok and nok
-- ok(exp, [msg]) tests if exp returns (or is) a truthy value.
-- nok(exp, [msg]) tests if exp returns (or is) a falsey value.
tap.ok(true, 'Test ok on true')
tap.ok(false, 'Test ok on false')
tap.nok(false, 'Test nok on false')
tap.nok(true, 'Test nok on true')

--- is and isnt
-- is(actual, expected, [msg]) tests if actual == expected
-- isnt(actual, expected, [msg]) tests if actual ~= expected
tap.is(2+1, 3, 'Test is on 2 + 1 = 3')
tap.is(2+2, 3, 'Test is on 2 + 2 = 3')
tap.isnt(2+2, 3, 'Test isnt on 2 + 2 = 3')
tap.isnt(2+2, 4, 'Test isnt on 2 + 2 = 4')

--- same
-- same(first, second, [msg]) tests if first and second are the same.
--
-- An important question here is what counts as being the same thing?
--
-- 1. If the two objects are not of the same type, they are not the same.
-- 2. If they are of the same type and they are not tables, the method compares
--    the two items using ==. In this case, same is no different from is.
-- 3. If they are tables, the method tries a short-cut via the .__eq metamethod.
--    If both tables have the same .__eq metamethod, we pass back to == for the
--    comparison.
-- 3. For tables without .__eq, same does a recursive deep comparison. Everything
--    in both tables must be the same thing, as determined by same itself.
tap.same({},{}, 'Test same on two empty tables')
tap.same({1,2,3}, {1,2,3}, 'Test same on two identical, simple tables')
tap.same({1},{}, 'Test same on two simple non-identical tables')
tap.same({{1}, 2, {3,4}},{{1}, 2, {3,4}},
	'Test same on two identical, nested tables')
local days1 = { 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday' }
local days2 = { 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday' }
tap.same(days1, days2, 'Test same on identical, array-like tables')
local days3 = { 'Monday', 'Tuesday', 'Wednesday', 'Thursday', }
tap.same(days2, days3, 'Test same on two non-identical, array-like tables')
local  hash1 = {
	Monday = 1,
	Tuesday = 2,
	Wednesday = 3,
	Thursday = 4,
	Friday = 5
}
local  hash2 = {
	Monday = 1,
	Tuesday = 2,
	Wednesday = 3,
	Thursday = 4,
	Friday = 5
}
local  hash3 = {
	Monday = 1,
	Tuesday = 2,
	Wednesday = 3,
	Thursday = 4,
}
tap.same(hash1, hash2, 'Test same on two identical, hash-like tables')
tap.same(hash1, hash3, 'Test same on two non-identical, hash-like tables')
local sub = function (x,y) return x - y end
local mult = function (x,y) return x * y end
local div = function (x,y) return x / y end
local method_table1 = { sub = sub, mult = mult }
local method_table2 = { sub = sub, mult = mult }
local method_table3 = { sub = sub, mult = mult, div = div }
tap.same(method_table1, method_table2,
	'Test same on two identical tables with functions as values')
tap.same(method_table1, method_table3,
	'Test same on two non-identical tables with functions as values')
local foo = {4}
local bar = {5}
local bizz = {4}
local buzz = {4}
local mt1, mt2 = {}, {}
local always_true = function () return true end
local always_false = function () return false end
mt1.__eq = always_true
mt2.__eq = always_false
setmetatable(foo, mt1)
setmetatable(bar, mt1)
setmetatable(bizz, mt2)
tap.same(foo, bar, 'Test same on two dissimilar tables that share .__eq => true')
tap.same(foo, bizz, 'Test same: first table .__eq => true, second => false')
tap.same(foo, bizz, 'Test same: first table .__eq => false, second => true')
tap.same(foo, buzz, 'Test same on two similar tables where first .__eq => true')
tap.same(buzz, foo, 'Test same on two similar tables where second .__eq => true')

--- like and unlike
-- like(string, pattern, [msg]) tests if the pattern matches the string
-- unlike(string, pattern, [msg]) tests if the pattern does not match the string
tap.like('sat', 'sat', "Test like with string 'sat' and pattern 'sat'")
tap.like('sat', 'bbb', "Test like with string 'sat' and pattern 'bbb'")
tap.unlike('sat', 'q', "Test unlike with string 'sat' and pattern 'q'")
tap.unlike('q', 'q', "Test unlike with string 'q' and pattern 'q'")
tap.like('  sat', '%s+sat', "Test like with string '  sat' and pattern '%s+sat'")
tap.like('934', '%d%d%d', "Test like with string '934' and pattern '%d%d%d'")
tap.like('934', '%d%d', "Test like with string '934' and pattern '%d%d'")
tap.unlike('934', '%d%s', "Test unlike with string '934' and pattern '%d%s'")

--- pass and fail
-- pass([msg]) is not a test. It always passes.
-- fail([msg]) is not a test. It always fails.
-- These two methods are useful for checking the basic setup of a test suite.
-- Also, pass can be used as a quasi-skip and fail as a quasi-TODO.
tap.pass('No test: just pass')
tap.fail('No test: just fail')

--- boom
-- boom(method, arguments, [msg]) tests if the function throws an exception when
-- given the arguments supplied. The arguments parameter must be a table. It can
-- be empty if the given method takes no arguments, but it cannot be nil.
--
-- Note that boom expects an exception. It passes if an exception is throw, and
-- fails if one is not. The exception, however, will be swallowed by boom so
-- that test execution continues.
local function add(x, y) return x+y end
tap.boom(add, {2, 3}, 'Test boom with a method that throws no exception')
tap.boom(error, {'Kaboom!'},
	'Test boom with a method that throws an exception "Kaboom!"')

--- done
-- done([number]) is not a test. It simply prints out how many tests were run.
-- If called without a number, done will print out 1..n where n is the number
-- of tests run. If called with a number, done will check whether the given
-- number matches the actual number of tests run. If the two numbers don't match
-- an error message will be output. Thus done called with a number can function
-- like the traditional plan method (which this module does not provide).
tap.done()
tap.done(43)
