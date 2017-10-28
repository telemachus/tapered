package.path = '../src/?.lua;' .. package.path
local tap = require 'tapered'

tap.is(tap.author(), 'Peter Aronoff', "author() should be 'Peter Aronoff'")
tap.is(tap.version(), '2.3.0', "version() should be '2.3.0'")
tap.is(tap.license(), 'BSD 3-Clause', "license() should be 'BSD 3-Clause'")
tap.is(tap.url(), "https://github.com/telemachus/tapered",
	"url() should be 'https://github.com/telemachus/tapered'")
