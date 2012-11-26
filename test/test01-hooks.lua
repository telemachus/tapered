#!/usr/bin/env lua
-- We must define setup and teardown *before* requiring luatap. Otherwise,
-- the global hooks aren't visible to the tap code.
-- This is a little clumsy, but I can live with it.
function setup()
  print("# I'm a little teapot.")
end

function teardown()
  print("# Here is my handle, and here is my spout.")
end

tap = require 'luatap'

tap.plan(1)
tap.ok(true, "Short and stout.")
