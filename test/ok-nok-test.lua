package.path = '../src/?.lua;' .. package.path
local tap = require 'tapered'
local error = error

--- ok and nok
-- ok(exp, [msg]) tests if exp returns (or is) a truthy value.
-- nok(exp, [msg]) tests if exp returns (or is) a falsey value.
tap.ok(true, 'ok - ok(true)')
tap.ok(false, 'not ok - ok(false)')
tap.nok(false, 'ok - nok(false)')
tap.nok(true, 'not ok - nok(true)')
tap.done()
