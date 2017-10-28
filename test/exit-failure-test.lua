package.path = '../src/?.lua;' .. package.path
local tap = require 'tapered'

-- Test exit status with a failed test. Call `fail` and we're done!
tap.fail('not ok - No test: just fail')
tap.done()
