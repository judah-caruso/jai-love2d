// This file was generated by generate_bindings.lua


Event :: enum {
	Focus; // focus
	JoystickPressed; // joystickpressed
	JoystickReleased; // joystickreleased
	KeyPressed; // keypressed
	KeyReleased; // keyreleased
	MousePressed; // mousepressed
	MouseReleased; // mousereleased
	Quit; // quit
	Resize; // resize
	Visible; // visible
	MouseFocus; // mousefocus
	ThreadError; // threaderror
	JoystickAdded; // joystickadded
	JoystickRemoved; // joystickremoved
	JoystickAxis; // joystickaxis
	JoystickHat; // joystickhat
	GamepadPressed; // gamepadpressed
	GamepadReleased; // gamepadreleased
	GamepadAxis; // gamepadaxis
	TextInput; // textinput
	MouseMoved; // mousemoved
	LowMemory; // lowmemory
	TextEdited; // textedited
	WheelMoved; // wheelmoved
	TouchPressed; // touchpressed
	TouchReleased; // touchreleased
	TouchMoved; // touchmoved
	DirectoryDropped; // directorydropped
	FileDropped; // filedropped
	Jp; // jp
	Jr; // jr
	Kp; // kp
	Kr; // kr
	Mp; // mp
	Mr; // mr
	Q; // q
	F; // f
}
EventMap :: string.[ "focus", "joystickpressed", "joystickreleased", "keypressed", "keyreleased", "mousepressed", "mousereleased", "quit", "resize", "visible", "mousefocus", "threaderror", "joystickadded", "joystickremoved", "joystickaxis", "joystickhat", "gamepadpressed", "gamepadreleased", "gamepadaxis", "textinput", "mousemoved", "lowmemory", "textedited", "wheelmoved", "touchpressed", "touchreleased", "touchmoved", "directorydropped", "filedropped", "jp", "jr", "kp", "kr", "mp", "mr", "q", "f" ];


// Clears the event queue.
love_event_clear :: () #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "event");
	lua.getfield(L, -1, "clear");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 0);
}
// Returns an iterator for messages in the event queue.
love_event_poll :: () -> (i: *void) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "event");
	lua.getfield(L, -1, "poll");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return xx lua.tocfunction(L, -1);
}
// Pump events into the event queue.
love_event_pump :: () #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "event");
	lua.getfield(L, -1, "pump");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 0);
}
// Adds an event to the event queue.
love_event_push :: (n: *u8, a: *u8, b: *u8, c: *u8, d: *u8, e: *u8, f: *u8) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "event");
	lua.getfield(L, -1, "push");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushstring(L, n);
	lua.pushstring(L, a);
	lua.pushstring(L, b);
	lua.pushstring(L, c);
	lua.pushstring(L, d);
	lua.pushstring(L, e);
	lua.pushstring(L, f);
	lua.call(L, 7, 0);
}
// Adds the quit event to the queue.
love_event_quit :: (exitstatus: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "event");
	lua.getfield(L, -1, "quit");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, exitstatus);
	lua.call(L, 1, 0);
}
// Adds the quit event to the queue.
love_event_quit :: () #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "event");
	lua.getfield(L, -1, "quit");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 0);
}
// Like love.event.poll(), but blocks until there is an event in the queue.
love_event_wait :: () -> struct { _n: *u8; _a: *u8; _b: *u8; _c: *u8; _d: *u8; _e: *u8; _f: *u8; } #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "event");
	lua.getfield(L, -1, "wait");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 7);

	return .{ _n = lua.tolstring(L, -7, null), _a = lua.tolstring(L, -6, null), _b = lua.tolstring(L, -5, null), _c = lua.tolstring(L, -4, null), _d = lua.tolstring(L, -3, null), _e = lua.tolstring(L, -2, null), _f = lua.tolstring(L, -1, null) };
}
