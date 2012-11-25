# lua-tap

Very minimal tap testing for Lua. Arguably too minimal. But for the moment,
it gets the job done for me.

Available functions and assertions:

    -- Start with a plan
    plan(7)

    -- Assertions: all messages are optional.
    ok(expression, message)
    nok(expression, message)
    is(actual, expected, message)
    isnt(actual, expected, message)
    like(string, pattern, message)
    unlike(string, pattern, message)
    pass(message)
    fail(message)
    boom(function, args, message)

    -- Optionally close this way to check if you ran the right number of
    -- tests
    done()

Most of those are self-explanatory. The last checks if a function raises an
error when given specific arguments. The `args` parameter expects a table.
It can be empty, but not `nil`.
