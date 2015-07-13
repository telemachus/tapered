package.path = '../src/?.lua;' .. package.path
local tap = require 'tapered'
local error = error

-- Testing exit status. Call `pass` and then we're out.
tap.pass('ok - No test: just pass')
tap.done()
