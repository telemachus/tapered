#!/usr/bin/env bats

@test "ignition!" {
	run true
	[ "$status" -eq 0 ]
	[ "$output" = "" ]
}

@test "ok and nok" {
	run lua -lluacov ok-nok-test.lua
	[ "$status" -eq 2 ]
	[ "$output" = "$(cat ok-nok-result.txt)" ]
}

@test "is and isnt" {
	run lua -lluacov is-isnt-test.lua
	[ "$status" -eq 13 ]
	[ "$output" = "$(cat is-isnt-result.txt)" ]
}

@test "same" {
	run lua -lluacov same-test.lua
	[ "$status" -eq 10 ]
	[ "$output" = "$(cat same-result.txt)" ]
}

@test "like and unlike" {
	run lua -lluacov like-unlike-test.lua
	[ "$status" -eq 3 ]
	[ "$output" = "$(cat like-unlike-result.txt)" ]
}

@test "pass and fail" {
	run lua -lluacov pass-fail-test.lua
	[ "$status" -eq 1 ]
	[ "$output" = "$(cat pass-fail-result.txt)" ]
}

@test "boom" {
	run lua -lluacov boom-test.lua
	[ "$status" -eq 1 ]
	# This is foul, but choices are limited. Error messages for Lua 5.3
	# are different, so I need to look at the output but NOT the errors.
	[ "$(grep -v '^#' <<< "$output")" = "$(cat boom-result.txt | grep -v '^#')" ]
}

@test "done success" {
	run lua -lluacov done-success-test.lua
	[ "$status" -eq 0 ]
	[ "$output" = "$(cat done-success-result.txt)" ]
}

@test "done failure" {
	run lua -lluacov done-failure-test.lua
	[ "$status" -eq 1 ]
	[ "$output" = "$(cat done-failure-result.txt)" ]
}

@test "exit status" {
	run lua -lluacov exit-success-test.lua
	[ "$status" -eq 0 ]

	run lua -lluacov exit-failure-test.lua
	[ "$status" -eq 1 ]
}

@test "informational fields" {
	run lua -lluacov informational-fields-test.lua
	[ "$status" -eq 0 ]
	[ "$output" = "$(cat informational-fields-result.txt)" ]
}
