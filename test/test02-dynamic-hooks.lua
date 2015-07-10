#!/usr/bin/env lua
package.path = '../src/?.lua;' .. package.path
tap = require 'tapered'

function setup()
  print("# I'm a little teapot.")
end
tap.ok(true, "setup() only with '# I'm a little teapot.'")

function setup()
  print('# This is my handle and this is my spout.')
end
function teardown()
  print('# Cleanup on aisle 9!')
end
tap.ok(true, 'setup() handle and spout, teardown() cleanup on aisle 9')

function teardown()
  print('# I changed this.')
end
tap.ok(true, 'setup() again handle and spout, teardown() changed')

setup = nil
teardown = nil
tap.ok(true, 'Both setup and teardown should be gone now: redefined as nil.')

tap.done()
