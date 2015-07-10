#!/usr/bin/env lua
package.path = '../src/?.lua;' .. package.path
tap = require 'tapered'

tap.is(tap._AUTHOR, 'Peter Aronoff', '_AUTHOR should be Peter Aronoff')
tap.is(tap._VERSION, '1.0-0', '_VERSION should be 1.0-0')
tap.is(tap._LICENSE, 'BSD 3-Clause', '_LICENSE should be BSD 3-Clause')
tap.is(tap._URL, 'https://bitbucket.org/telemachus/tapered',
	'_URL should be https://bitbucket.org/telemachus/tapered')
