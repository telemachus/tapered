# Simulate Travis' matrix builds on drone.io

for lua in lua5.1 lua5.2 lua5.3 luajit
do
	rm -rf $HOME/.lua ;
	LUA="$lua" source "$LUA_ENV/setenv_lua.sh" ;
	lua -v ;
	luarocks install luacov
	luarocks install luacov-coveralls
	bats runner.bash ;
	[ $? -eq 0 ] || exit $? ;
done
luacov
cp -v luacov.report.out ../
cd ..
bash <(curl -s https://codecov.io/bash)
