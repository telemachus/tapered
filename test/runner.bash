#!/usr/bin/env bats

@test "ignition!" {
	run true
	[ "$status" -eq 0 ]
	[ "$output" = "" ]
}

@test "setup and teardown hooks" {
	run ./test01-hooks.lua
	[ "$status" -eq 0 ]
	[ "$output" = "$(cat result_test01.txt)" ]
}

@test "dynamic setup and teardown hooks" {
	run ./test02-dynamic-hooks.lua
	[ "$status" -eq 0 ]
	[ "$output" = "$(cat result_test02.txt)" ]
}

@test "individual tap methods" {
	run ./test03-allfuncs.lua
	[ "$status" -eq 0 ]
	[ "$output" = "$(cat result_test03.txt)" ]
}

@test "informational fields" {
	run ./test04-informational-fields.lua
	[ "$status" -eq 0 ]
	[ "$output" = "$(cat result_test04.txt)" ]
}
