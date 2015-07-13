package.path = '../src/?.lua;' .. package.path
local tap = require 'tapered'
local error = error

--- is and isnt
-- is(actual, expected, [msg]) tests if actual == expected
-- isnt(actual, expected, [msg]) tests if actual ~= expected
tap.is(2+1, 3, 'ok - is(2+1, 3)')
tap.is(2+2, 3, 'not ok - is(2+2, 3)')
tap.is(print, print, 'ok - is(print, print)')
tap.is(print, 3, 'not ok - is(print, 3)')
tap.is('hello', 'hello', 'ok - is("hello", "hello")')
tap.is('goodbye', 'hello', 'not ok - is("goodbye", "hello")')
tap.is(nil, nil, 'ok - is(nil, nil)')
tap.is(nil, false, 'not ok - is(nil, false)')
tap.is(false, false, 'ok - is(false, false)')
tap.is(true, true, 'ok - is(true, true)')
tap.is(true, false, 'not ok - is(true, false)')
tap.is(false, true, 'not ok - is(false, true)')
tap.isnt(2+2, 3, 'ok - isnt(2+2, 3)')
tap.isnt(2+2, 4, 'not ok - isnt(2+2, 4)')
tap.isnt(3, print, 'ok - isnt(3, print)')
tap.isnt(print, exit, 'ok - isnt(print, exit)')
tap.isnt('hello', 'goodbye', 'ok - isnt("hello", "goodbye")')
tap.isnt('hello', 'hello', 'not ok - isnt("hello", "hello")')
tap.isnt(nil, nil, 'not ok - isnt(nil, nil)')
tap.isnt(nil, false, 'ok - isnt(nil, false)')
tap.isnt(false, false, 'not ok - isnt(false, false)')
tap.isnt(true, true, 'not ok - isnt(true, true)')
tap.isnt(true, false, 'ok - isnt(true, false)')
tap.isnt(false, true, 'ok - isnt(false, true)')
tap.isnt(nil, false, 'ok - isnt(nil, false)')
tap.isnt(false, false, 'not ok - isnt(false, false)')
tap.isnt(true, true, 'not ok - isnt(true, true)')
tap.isnt(true, false, 'ok - isnt(true, false)')
tap.isnt(false, true, 'ok - isnt(false, true)')
tap.done()
