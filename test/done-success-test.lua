package.path = '../src/?.lua;' .. package.path
tap = require 'tapered'

tap.ok(true)
tap.done(1)
