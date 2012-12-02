#!/usr/bin/env lua
tap = require 'luatap'

function setup()
  print("# I'm a little teapot.")
end

tap.plan(2)
tap.ok(true, "Short and stout.")

function setup()
  print("# This is my handle and this is my spout.")
end
function teardown()
  print("# Cleanup on aisle 9!")
end
tap.ok(true, "Can you hear me now?")
