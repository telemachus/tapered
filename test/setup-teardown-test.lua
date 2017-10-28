package.path = '../src/?.lua;' .. package.path
local tap = require 'tapered'

-- luacheck: globals setup teardown
function setup()
  print("# I'm a little teapot.")
end

function teardown()
  print("# Here is my handle, and here is my spout.")
end

tap.ok(true, "Short and stout.")
tap.done()
