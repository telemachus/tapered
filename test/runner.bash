#!/usr/bin/env bats

@test "ignition!" {
	run true
	[ "$status" -eq 0 ]
	[ "$output" = "" ]
}

@test "setup and teardown hooks" {
	run lua setup-teardown-test.lua
	[ "$status" -eq 0 ]
	[ "$output" = "$(cat setup-teardown-result.txt)" ]
}

@test "dynamic setup and teardown hooks" {
	run lua dynamic-setup-teardown-test.lua
	[ "$status" -eq 0 ]
	[ "$output" = "$(cat dynamic-setup-teardown-result.txt)" ]
}

@test "ok and nok" {
	run lua ok-nok-test.lua
	[ "$status" -eq 2 ]
	[ "$output" = "$(cat ok-nok-result.txt)" ]
}

@test "is and isnt" {
	run lua is-isnt-test.lua
	[ "$status" -eq 13 ]
	[ "$output" = "$(cat is-isnt-result.txt)" ]
}

@test "same" {
	run lua same-test.lua
	[ "$status" -eq 10 ]
	[ "$output" = "$(cat same-result.txt)" ]
}

@test "like and unlike" {
	run lua like-unlike-test.lua
	[ "$status" -eq 3 ]
	[ "$output" = "$(cat like-unlike-result.txt)" ]
}

@test "pass and fail" {
	run lua pass-fail-test.lua
	[ "$status" -eq 1 ]
	[ "$output" = "$(cat pass-fail-result.txt)" ]
}

@test "boom" {
	run lua boom-test.lua
	[ "$status" -eq 1 ]
	# This is foul, but choices are limited. Error messages for Lua 5.3
	# are different, so I need to look at the output but NOT the errors.
	[ "$(grep -v '^#' <<< "$output")" = "$(cat boom-result.txt | grep -v '^#')" ]
}

@test "done" {
	run lua done-test.lua
	[ "$status" -eq 0 ]
	[ "$output" = "$(cat done-result.txt)" ]
}

@test "exit status" {
	run lua exit-success-test.lua
	[ "$status" -eq 0 ]

	run lua exit-failure-test.lua
	[ "$status" -eq 1 ]
}

@test "informational fields" {
	run lua informational-fields-test.lua
	[ "$status" -eq 0 ]
	[ "$output" = "$(cat informational-fields-result.txt)" ]
}
