local tap = {}

-- Helper variables and functions
local get_info = debug.getinfo
local pcall = pcall
local slice = string.sub
local sprintf = string.format
local str_find = string.find
local tonumber = tonumber
local unpack = unpack

local u = require 'utilitybelt'
local printf = u.printf
local same = u.same
local same_mt = u.same_mt

local test_count = 0
local debug_level = 3

-- A bargain-basement pair of setup and teardown hooks. Use as follows:
-- 1. In the test file, define global setup and teardown methods.
-- 2. Redefine them as wanted, and they will _dynamically_ update.
local function setup_call()
  if _G["setup"] then return _G["setup"]() end
end

local function teardown_call()
  if _G["teardown"] then return _G["teardown"]() end
end

-- All other tests are defined in terms of this primitive, which is
-- kept private.
local function _test(exp, msg)
  test_count = test_count + 1

  if msg then
    msg = sprintf(" - %s", msg)
  else
    msg = ''
  end

  setup_call()

  if exp then
    printf("ok %s%s\n", test_count, msg)
  else
    printf("not ok %s%s\n", test_count, msg)
    info = get_info(debug_level)
    printf("# Trouble in %s around line %s\n",
           slice(info.source, 2), info.currentline)
  end

  teardown_call()
end

function tap.ok(expression, msg)
  _test(expression, msg)
end

function tap.nok(expression, msg)
  _test(not expression, msg)
end

function tap.is(actual, expected, msg)
  _test(actual == expected, msg)
end

function tap.isnt(actual, expected, msg)
  _test(actual ~= expected, msg)
end

function tap.same(actual, expected, msg)
  _test(same(actual, expected), msg)
end

function tap.same_mt(actual, expected, msg)
  _test(same_mt(actual, expected), msg)
end

function tap.like(str, pattern, msg)
  _test(str_find(str, pattern), msg)
end

function tap.unlike(str, pattern, msg)
  _test(not str_find(str, pattern), msg)
end

function tap.pass(msg)
  _test(true, msg)
end

function tap.fail(msg)
  _test(false, msg)
end

-- I really need a better name for this one, don't I?
function tap.boom(func, args, msg)
  err, errmsg = pcall(func, unpack(args))
  _test(not err, msg)
  if not err and errmsg then
    printf('# Got this error:\n# %s\n', errmsg)
  end
end

-- The promised alternative to plan(n). This function can be used in one of
-- two ways. Most obviously, if you don't know how many tests you plan to
-- run or you just hate to manually count, then call done() with no
-- parameters. In this case, done will emit 1..n where n is the number of
-- tests that actually ran. This will satisfy traditional TAP tools.
--
-- On the other hand, if you know the number and simply prefer done(n) at
-- the end to plan(n) at the top, then you can call done(n) with a number.
-- If the number doesn't match the actual number of tests run, you'll get
-- a 'Bad plan' warning.
local function done(n)
  local expected = tonumber(n)
  if not expected or test_count == expected then
    printf('1..%d\n', test_count)
  elseif expected ~= test_count then
    local s
    if expected == 1 then s = '' else s = 's' end
    printf("# Bad plan. You planned %d test%s but ran %d\n",
      expected, s, test_count)
  end
end
tap.done = done

return tap
