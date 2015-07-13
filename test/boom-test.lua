package.path = '../src/?.lua;' .. package.path
local tap = require 'tapered'
local error = error

--- boom
-- boom(method, arguments, [msg]) tests if the function throws an exception when
-- given the arguments supplied. The arguments parameter must be a table. It can
-- be empty if the given method takes no arguments, but it cannot be nil.
--
-- Note that boom expects an exception. It passes if an exception is throw, and
-- fails if one is not. The exception, however, will be swallowed by boom so
-- that test execution continues.
local broken = function (x) return x.__eq end
local add = function (x, y) return x+y end
tap.boom(broken, {}, 'ok - return nada.__eq')
tap.boom(add, {2, 3}, 'not ok - Test boom with a method that throws no exception')
tap.boom(error, {'Kaboom!'},
	'ok - Test boom with a method that throws an exception "Kaboom!"')
tap.done()
