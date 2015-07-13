package.path = '../src/?.lua;' .. package.path
local tap = require 'tapered'
local error = error

--- pass and fail
-- pass([msg]) is not a test. It always passes.
-- fail([msg]) is not a test. It always fails.
-- These two methods are useful for checking the basic setup of a test suite.
-- Also, pass can be used as a quasi-skip and fail as a quasi-TODO.
tap.pass('ok - No test: just pass')
tap.fail('not ok - No test: just fail')
tap.done()
