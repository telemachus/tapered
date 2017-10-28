package.path = '../src/?.lua;' .. package.path
local tap = require 'tapered'

tap.ok(true)
tap.done(1)
