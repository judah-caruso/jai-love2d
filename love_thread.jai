// This file was generated by generate_bindings.lua

Channel :: #type,distinct lua.Ref;
Thread :: #type,distinct lua.Ref;


// Creates or retrieves a named thread channel.
love_thread_getChannel :: (name: *u8) -> (channel: Channel) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "thread");
	lua.getfield(L, -1, "getChannel");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushstring(L, name);
	lua.call(L, 1, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Create a new unnamed thread channel.
love_thread_newChannel :: () -> (channel: Channel) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "thread");
	lua.getfield(L, -1, "newChannel");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new Thread from a filename, string or FileData object containing Lua code.
love_thread_newThread :: (filename: *u8) -> (thread: Thread) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "thread");
	lua.getfield(L, -1, "newThread");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushstring(L, filename);
	lua.call(L, 1, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new Thread from a filename, string or FileData object containing Lua code.
love_thread_newThread :: (filedata: FileData) -> (thread: Thread) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "thread");
	lua.getfield(L, -1, "newThread");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx filedata);
	lua.call(L, 1, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new Thread from a filename, string or FileData object containing Lua code.
