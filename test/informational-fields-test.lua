package.path = '../src/?.lua;' .. package.path
tap = require 'tapered'

tap.is(tap.author(), 'Peter Aronoff', "author() should be 'Peter Aronoff'")
tap.is(tap.version(), '2.0.0-1', "version() should be '2.0.0-1'")
tap.is(tap.license(), 'BSD 3-Clause', "license() should be 'BSD 3-Clause'")
tap.is(tap.url(), "https://bitbucket.org/telemachus/tapered",
	"url() should be 'https://bitbucket.org/telemachus/tapered'")
