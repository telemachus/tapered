package.path = '../src/?.lua;' .. package.path
tap = require 'tapered'

tap.ok(true, "This is not really the point of today's exercise.")
tap.done()
