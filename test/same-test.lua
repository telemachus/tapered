package.path = '../src/?.lua;' .. package.path
local tap = require 'tapered'
local error = error

tap.same({},{}, 'ok - same({}, {}')
tap.same({1,2,3}, {1,2,3}, 'ok - same({1,2,3}, {1,2,3})')
tap.same({1},{}, 'not ok - same({1}, {})')
tap.same({{1}, 2, {3,4}},{{1}, 2, {3,4}},
	'ok - same({{1}, 2, {3,4}}, {{1}, 2, {3,4})')

local days1 = { 'Monday', 'Tuesday' }
local days2 = { 'Monday', 'Tuesday' }
tap.same(days1, days2, 'ok - same({"Monday", "Tuesday"}, {"Monday", "Tuesday"})')
local days3 = { 'Monday', 'Tuesday', 'Wednesday', }
tap.same(days2, days3,
	'not ok - same({"Monday", "Tuesday"}, {"Monday", "Tuesday", "Wednesday"})')

local  hash1 = {
	Monday = 1,
}
local  hash2 = {
	Monday = 1,
}
local  hash3 = {
	Monday = 1,
	Tuesday = 2,
}
tap.same(hash1, hash2, 'ok - same({Monday = 1}, {Monday = 1})')
tap.same(hash1, hash3,
	'not ok - same({Monday = 1}, {Monday = 1, Tuesday = 2})')

local n1 = { m = { 1, 2 }, n = { 1, 2 } }
local n2 = { m = { 1, 2 }, n = { 1, 2 } }
local n3 = { m = { 1, 2 }, n = { 1, 2, 3 } }
tap.same(n1, n2, 'ok - same({m = {1,2}, n = {1,2}}, {m = {1,2}, n = {1,2}})')
tap.same(n1, n3, 'not ok - same({m = {1,2}, n = {1,2}}, {m = {1,2}, n = {1,2,3}})')
tap.same(n3, n1, 'not ok - same({m = {1,2}, n = {1,2,3}}, {m = {1,2}, n = {1,2}})')

local method_table1 = { p = print, e = exit }
local method_table2 = { p = print, e = exit }
local method_table3 = { p = print, e = exit, u = unpack or table.unpack }
tap.same(method_table1, method_table2,
	'ok - same({p = print, e = exit}, {p = print, e = exit})')
tap.same(method_table1, method_table3,
	'not ok - same({p = print, e = exit}, {p = print, e = exit, u = unpack})')

local foo = {4, s = 4}
local bar = {6, s = 8}
local oof = {4, s = 3}
local mt1 = {}
local mt2 = {}
local evens = function (x, y) return x['s'] % 2 == 0 and y['s'] % 2 == 0  end
local even_odd = function (x, y) return x['s'] % 2 == 0 and y['s'] % 2 ~= 0  end
mt1.__eq = evens
mt2.__eq = even_odd
setmetatable(foo, mt1)
setmetatable(bar, mt1)
setmetatable(oof, mt1)
tap.same(foo, bar, 'ok - same({4, s=4}, {6, s=4},__eq => x[s] and y[s] are even)')
tap.same(bar, foo, 'ok - same({6, s=8}, {4, s=4},__eq => x[s] and y[s] are even)')
tap.same(foo, oof,
	'not ok - same({4, s=4}, {4, s=3},__eq => x[s] and y[s] are even)')
tap.same(oof, foo,
	'not ok - same({4, s=4}, {4, s=3},__eq => x[s] and y[s] are even)')
setmetatable(foo, mt2)
setmetatable(bar, mt2)
setmetatable(oof, mt2)
tap.same(foo, bar,
	'not ok - same({4, s=4}, {6, s=4},__eq => x[s] is even, y[s] odd)')
tap.same(foo, oof,
	'ok - same({4, s=4}, {4, s=3},__eq => x[s] is even, y[s] odd)')
tap.same(oof, foo,
	'not ok - same({4, s=3}, {4, s=4},__eq => x[s] is even, y[s] odd)')
tap.done()
