// This file was generated by generate_bindings.lua

VideoStream :: #type,distinct lua.Ref;


// Creates a new VideoStream. Currently only Ogg Theora video files are supported. VideoStreams can't draw videos, see love.graphics.newVideo for that.
love_video_newVideoStream :: (filename: *u8) -> (videostream: VideoStream) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "video");
	lua.getfield(L, -1, "newVideoStream");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushstring(L, filename);
	lua.call(L, 1, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new VideoStream. Currently only Ogg Theora video files are supported. VideoStreams can't draw videos, see love.graphics.newVideo for that.
love_video_newVideoStream :: (file: File) -> (videostream: VideoStream) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "video");
	lua.getfield(L, -1, "newVideoStream");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx file);
	lua.call(L, 1, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
