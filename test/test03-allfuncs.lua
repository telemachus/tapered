#!/usr/bin/env lua
package.path = '../src/?.lua;' .. package.path
tap = require 'tap'
local error = error

tap.ok(true, 'That was true, right?')
tap.nok(false, 'That was false, right?')
tap.is(2+1, 3, '2+1 is 3, right?')
tap.isnt(2+2, 3, '2+2 is not 3, right?')

tap.same({1,2,3}, {1,2,3}, 'Two equal tables, right?')
local foo = {4}
local bar = {5}
local mt = {}
local function always_true()
  return true
end
mt.__eq = always_true
setmetatable(foo, mt)
setmetatable(bar, mt)
tap.same_mt(foo, bar, "These should appear the same because of __eq.")

tap.like('sat', 'sat', 'The pattern matches, right?')
tap.unlike('sat', 'q', 'That pattern does not match, right?')

tap.pass('pass always works.')
tap.fail('fail always fails.')

local function add(x, y) return x+y end
tap.boom(add, {2, 3}, 'No boom here, right?')
tap.boom(error, {'Kaboom!'}, 'Error says "Kaboom!"')

tap.done()
