// This file was generated by generate_bindings.lua

Cursor :: #type,distinct lua.Ref;

CursorType :: enum {
	Image; // image
	Arrow; // arrow
	Ibeam; // ibeam
	Wait; // wait
	WaitArrow; // waitarrow
	Crosshair; // crosshair
	SizeNWSE; // sizenwse
	SizeNESW; // sizenesw
	SizeWE; // sizewe
	SizeNS; // sizens
	SizeAll; // sizeall
	No; // no
	Hand; // hand
}
CursorTypeMap :: string.[ "image", "arrow", "ibeam", "wait", "waitarrow", "crosshair", "sizenwse", "sizenesw", "sizewe", "sizens", "sizeall", "no", "hand" ];


// Gets the current Cursor.
love_mouse_getCursor :: () -> (cursor: Cursor) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "getCursor");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Returns the current position of the mouse.
love_mouse_getPosition :: () -> struct { _x: lua.Number; _y: lua.Number; } #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "getPosition");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 2);

	return .{ _x = lua.tonumber(L, -2), _y = lua.tonumber(L, -1) };
}
// Gets whether relative mode is enabled for the mouse.
love_mouse_getRelativeMode :: () -> (enabled: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "getRelativeMode");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.toboolean(L, -1);
}
// Gets a Cursor object representing a system-native hardware cursor.
love_mouse_getSystemCursor :: (ctype: *u8) -> (cursor: Cursor) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "getSystemCursor");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushstring(L, ctype);
	lua.call(L, 1, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Returns the current x-position of the mouse.
love_mouse_getX :: () -> (x: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "getX");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.tonumber(L, -1);
}
// Returns the current y-position of the mouse.
love_mouse_getY :: () -> (y: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "getY");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.tonumber(L, -1);
}
// Gets whether cursor functionality is supported.
love_mouse_isCursorSupported :: () -> (supported: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "isCursorSupported");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.toboolean(L, -1);
}
// Checks whether a certain mouse button is down.
love_mouse_isDown :: (button: lua.Number) -> (down: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "isDown");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, button);
	lua.call(L, 1, 1);

	return lua.toboolean(L, -1);
}
// Checks if the mouse is grabbed.
love_mouse_isGrabbed :: () -> (grabbed: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "isGrabbed");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.toboolean(L, -1);
}
// Checks if the cursor is visible.
love_mouse_isVisible :: () -> (visible: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "isVisible");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.toboolean(L, -1);
}
// Creates a new hardware Cursor object from an image file or ImageData.
love_mouse_newCursor :: (imagedata: ImageData, hotx: lua.Number, hoty: lua.Number) -> (cursor: Cursor) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "newCursor");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx imagedata);
	lua.pushnumber(L, hotx);
	lua.pushnumber(L, hoty);
	lua.call(L, 3, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new hardware Cursor object from an image file or ImageData.
love_mouse_newCursor :: (filename: *u8, hotx: lua.Number, hoty: lua.Number) -> (cursor: Cursor) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "newCursor");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushstring(L, filename);
	lua.pushnumber(L, hotx);
	lua.pushnumber(L, hoty);
	lua.call(L, 3, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new hardware Cursor object from an image file or ImageData.
love_mouse_newCursor :: (filedata: FileData, hotx: lua.Number, hoty: lua.Number) -> (cursor: Cursor) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "newCursor");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx filedata);
	lua.pushnumber(L, hotx);
	lua.pushnumber(L, hoty);
	lua.call(L, 3, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Sets the current mouse cursor.
love_mouse_setCursor :: (cursor: Cursor) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "setCursor");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx cursor);
	lua.call(L, 1, 0);
}
// Sets the current mouse cursor.
love_mouse_setCursor :: () #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "setCursor");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 0);
}
// Grabs the mouse and confines it to the window.
love_mouse_setGrabbed :: (grab: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "setGrabbed");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushboolean(L, grab);
	lua.call(L, 1, 0);
}
// Sets the current position of the mouse. Non-integer values are floored.
love_mouse_setPosition :: (x: lua.Number, y: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "setPosition");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, x);
	lua.pushnumber(L, y);
	lua.call(L, 2, 0);
}
// Sets whether relative mode is enabled for the mouse.
love_mouse_setRelativeMode :: (enable: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "setRelativeMode");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushboolean(L, enable);
	lua.call(L, 1, 0);
}
// Sets the current visibility of the cursor.
love_mouse_setVisible :: (visible: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "setVisible");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushboolean(L, visible);
	lua.call(L, 1, 0);
}
// Sets the current X position of the mouse.
love_mouse_setX :: (x: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "setX");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, x);
	lua.call(L, 1, 0);
}
// Sets the current Y position of the mouse.
love_mouse_setY :: (y: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "mouse");
	lua.getfield(L, -1, "setY");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, y);
	lua.call(L, 1, 0);
}
