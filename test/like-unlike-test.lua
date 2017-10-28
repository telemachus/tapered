package.path = '../src/?.lua;' .. package.path
local tap = require 'tapered'

--- like and unlike
-- like(string, pattern, [msg]) tests if the pattern matches the string
-- unlike(string, pattern, [msg]) tests if the pattern does not match the string
tap.like('sat', 'sat', "ok - like('sat', 'sat')")
tap.like('sat', 'bbb', "not ok - like('sat', 'bbb')")
tap.unlike('sat', 'q', "ok - unlike('sat', 'q')")
tap.unlike('q', 'q', "not ok - unlike('q', 'q')")
tap.like('  sat', '%s+sat', "ok - like('   sat', '%s+sat')")
tap.like('934', '%d%d%d', "ok - like('934', '%d%d%d')")
tap.like('934', '%d%d', "ok - like('934', '%d%d')")
tap.like('934', '%d%s', "not ok - like('934', '%d%s')")
tap.unlike('934', '%d%s', "ok - unlike('934', '%d%s')")
tap.done()
