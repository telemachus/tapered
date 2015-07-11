-- Helper variables and functions
local get_info = debug.getinfo
local pcall = pcall
local slice = string.sub
local sprintf = string.format
local str_find = string.find
local tonumber = tonumber
-- Lua 5.3 moved unpack to table.unpack
local unpack = unpack or table.unpack
local write = io.write
local getmetable = getmetatable

---- Helper methods

--- C-like printf method
local printf = function(fmt, ...)
  write(sprintf(fmt, ...))
end

--- Compare potentially complex tables or objects
--
-- Ideas here are taken from [Penlight][p], [Underscore][u], [cwtest][cw], and
-- [luassert][l].
-- [p]: https://github.com/stevedonovan/Penlight
-- [u]: https://github.com/mirven/underscore.lua
-- [cw]: https://github.com/catwell/cwtest
-- [l]: https://github.com/Olivine-Labs/luassert
--
-- Predeclare both function names
local key_value_compare
local same
--
-- Helper method to compare all the keys and values of a table
key_value_compare = function (t1, t2)
  for k1, v1 in pairs(t1) do
    local v2 = t2[k1]
    if v2 == nil or not same(v1, v2) then
      return false
    end
  end

  for k2, _ in pairs(t2) do
    if t1[k2] == nil then
      return false
    end
  end

  return true
end
--
-- Compare two items of any time for identity
same = function (t1, t2)
  -- If the types aren't the same, return false.
  local ty1 = type(t1)
  local ty2 = type(t2)
  if ty1 ~= ty2 then
    return false
  end

  -- If not tables, then compare directly.
  if ty1 ~= 'table' then
    return t1 == t2
  end

  -- If ._eq is found, use == and end quickly.
  local mt1 = getmetable(t1)
  local mt2 = getmetable(t2)
  if (mt1 and mt1.__eq) or (mt2 and mt2.__eq) then
    -- The return value of x == y can be order-dependent in Lua.
    -- https://gist.github.com/telemachus/5412ec98e68ff745d160
    -- Depending on the objects being compared, this may take a long time.
    -- Lua 5.3 seems to handle == differently than 5.2
    if _VERSION == 'Lua 5.3' then
      return (mt1 and mt1.__eq) and (mt2 and mt2.__eq) and t1 == t2 and t2 == t1
    else
      return t1 == t2 and t2 == t1
    end
  elseif (mt1 or mt2) and (not key_value_compare(mt1, mt2)) then
    return false  
  else
    return key_value_compare(t1, t2)
  end
end

local test_count = 0
local debug_level = 3

-- A bargain-basement pair of setup and teardown hooks. Use as follows:
-- 1. In the test file, define *global* setup and teardown methods.
-- 2. Redefine them as wanted, and they will _dynamically_ update.
local setup_call = function ()
  if _G["setup"] then return _G["setup"]() end
end

local teardown_call = function ()
  if _G["teardown"] then return _G["teardown"]() end
end

-- All other tests are defined in terms of this primitive, which is
-- kept private.
local _test = function (exp, msg)
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

local ok = function (expression, msg)
  _test(expression, msg)
end

local nok = function (expression, msg)
  _test(not expression, msg)
end

local is = function (actual, expected, msg)
  _test(actual == expected, msg)
end

local isnt = function (actual, expected, msg)
  _test(actual ~= expected, msg)
end

local same = function (actual, expected, msg)
  _test(same(actual, expected), msg)
end

local like = function (str, pattern, msg)
  _test(str_find(str, pattern), msg)
end

local unlike = function (str, pattern, msg)
  _test(not str_find(str, pattern), msg)
end

local pass = function (msg)
  _test(true, msg)
end

local fail = function (msg)
  _test(false, msg)
end

-- I really need a better name for this one, don't I?
local boom = function (func, args, msg)
  err, errmsg = pcall(func, unpack(args))
  _test(not err, msg)
  if not err and errmsg then
    printf('# Got this error:\n# %s\n', errmsg)
  end
end

-- An alternative to `plan()`. This function can be used in one of two ways.
-- Most obviously, if you don't know how many tests you plan to run or you
-- hate to manually count, then call done() with no parameters. In this case,
-- done will emit 1..n where n is the number of tests that actually ran.
-- This will satisfy traditional TAP tools. On the other hand, if you know the
-- number, then you can call done(n) with a number. If the number doesn't match
-- the actual number of tests run, you'll get a 'Bad plan' warning.
local done = function (n)
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

return {
  ok = ok,
  nok = nok,
  is = is,
  isnt = isnt,
  same = same,
  like = like,
  unlike = unlike,
  pass = pass,
  fail = fail,
  boom = boom,
  done = done,
  _VERSION = '1.0-0',
  _AUTHOR = 'Peter Aronoff',
  _URL = 'https://bitbucket.org/telemachus/tapered',
  _LICENSE = 'BSD 3-Clause'
}
