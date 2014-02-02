#!/usr/bin/env lua
package.path = '../src/?.lua;' .. package.path
tap = require 'tap'

function setup()
  print("# I'm a little teapot.")
end

function teardown()
  print("# Here is my handle, and here is my spout.")
end

tap.ok(true, "Short and stout.")
tap.done()
