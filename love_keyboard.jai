// This file was generated by generate_bindings.lua


KeyConstant :: enum {
	A; // a
	B; // b
	C; // c
	D; // d
	E; // e
	F; // f
	G; // g
	H; // h
	I; // i
	J; // j
	K; // k
	L; // l
	M; // m
	N; // n
	O; // o
	P; // p
	Q; // q
	R; // r
	S; // s
	T; // t
	U; // u
	V; // v
	W; // w
	X; // x
	Y; // y
	Z; // z
	_0; // 0
	_1; // 1
	_2; // 2
	_3; // 3
	_4; // 4
	_5; // 5
	_6; // 6
	_7; // 7
	_8; // 8
	_9; // 9
	Space; // space
	Exclamation; // !
	DoubleQuote; // "
	Hash; // #
	Dollar; // $
	Ampersand; // &
	SingleQuote; // '
	LParen; // (
	RParen; // )
	Star; // *
	Plus; // +
	Comma; // ,
	Dash; // -
	Period; // .
	FSlash; // /
	Colon; // :
	Semicolon; // ;
	LessThan; // <
	Equal; // =
	GreaterThan; // >
	Question; // ?
	At; // @
	LBrace; // [
	BSlash; // \
	RBrace; // ]
	Caret; // ^
	Underscore; // _
	Grave; // `
	Pad0; // kp0
	Pad1; // kp1
	Pad2; // kp2
	Pad3; // kp3
	Pad4; // kp4
	Pad5; // kp5
	Pad6; // kp6
	Pad7; // kp7
	Pad8; // kp8
	Pad9; // kp9
	PadDot; // kp.
	PadFSlash; // kp/
	PadStar; // kp*
	PadDash; // kp-
	PadPlus; // kp+
	PadEnter; // kpenter
	PadEqual; // kp=
	Up; // up
	Down; // down
	Right; // right
	Left; // left
	Home; // home
	End; // end
	PageUp; // pageup
	PageDown; // pagedown
	Insert; // insert
	Backspace; // backspace
	Tab; // tab
	Clear; // clear
	Return; // return
	Delete; // delete
	F1; // f1
	F2; // f2
	F3; // f3
	F4; // f4
	F5; // f5
	F6; // f6
	F7; // f7
	F8; // f8
	F9; // f9
	F10; // f10
	F11; // f11
	F12; // f12
	F13; // f13
	F14; // f14
	F15; // f15
	NumLock; // numlock
	CapsLock; // capslock
	RShift; // rshift
	LShift; // lshift
	RCtrl; // rctrl
	LCtrl; // lctrl
	RAlt; // ralt
	LAlt; // lalt
	Mode; // mode
	Pause; // pause
	Escape; // escape
	Help; // help
}
KeyConstantMap :: string.[ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "space", "!", "\"", "#", "$", "&", "'", "(", ")", "*", "+", ",", "-", ".", "/", ":", ";", "<", "=", ">", "?", "@", "[", "\\", "]", "^", "_", "`", "kp0", "kp1", "kp2", "kp3", "kp4", "kp5", "kp6", "kp7", "kp8", "kp9", "kp.", "kp/", "kp*", "kp-", "kp+", "kpenter", "kp=", "up", "down", "right", "left", "home", "end", "pageup", "pagedown", "insert", "backspace", "tab", "clear", "return", "delete", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15", "numlock", "capslock", "rshift", "lshift", "rctrl", "lctrl", "ralt", "lalt", "mode", "pause", "escape", "help",  ];

Scancode :: enum {
	A; // a
	B; // b
	C; // c
	D; // d
	E; // e
	F; // f
	G; // g
	H; // h
	I; // i
	J; // j
	K; // k
	L; // l
	M; // m
	N; // n
	O; // o
	P; // p
	Q; // q
	R; // r
	S; // s
	T; // t
	U; // u
	V; // v
	W; // w
	X; // x
	Y; // y
	Z; // z
	_1; // 1
	_2; // 2
	_3; // 3
	_4; // 4
	_5; // 5
	_6; // 6
	_7; // 7
	_8; // 8
	_9; // 9
	_0; // 0
	Return; // return
	Escape; // escape
	Backspace; // backspace
	Tab; // tab
	Space; // space
	Dash; // -
	Equal; // =
	LBrace; // [
	RBrace; // ]
	BSlash; // \
	NonUS; // nonus#
	Semicolon; // ;
	SingleQuote; // '
	Grave; // `
	Comma; // ,
	Period; // .
	FSlash; // /
	CapsLock; // capslock
	F1; // f1
	F2; // f2
	F3; // f3
	F4; // f4
	F5; // f5
	F6; // f6
	F7; // f7
	F8; // f8
	F9; // f9
	F10; // f10
	F11; // f11
	F12; // f12
	F13; // f13
	F14; // f14
	F15; // f15
	F16; // f16
	F17; // f17
	F18; // f18
	F19; // f19
	F20; // f20
	F21; // f21
	F22; // f22
	F23; // f23
	F24; // f24
	LCtrl; // lctrl
	LShift; // lshift
	LAlt; // lalt
	LGui; // lgui
	RCtrl; // rctrl
	RShift; // rshift
	RAlt; // ralt
	RGui; // rgui
	PrintScreen; // printscreen
	Pause; // pause
	Insert; // insert
	Home; // home
	NumLock; // numlock
	PageUp; // pageup
	Delete; // delete
	End; // end
	PageDown; // pagedown
	Right; // right
	Left; // left
	Down; // down
	Up; // up
	NonUSBSlash; // nonusbackslash
	Application; // application
	Execute; // execute
	Help; // help
	Menu; // menu
	Select; // select
	Stop; // stop
	Again; // again
	Undo; // undo
	Cut; // cut
	Copy; // copy
	Paste; // paste
	Find; // find
	PadFSlash; // kp/
	PadStar; // kp*
	PadDash; // kp-
	PadPlus; // kp+
	PadEqual; // kp=
	PadEnter; // kpenter
	Pad1; // kp1
	Pad2; // kp2
	Pad3; // kp3
	Pad4; // kp4
	Pad5; // kp5
	Pad6; // kp6
	Pad7; // kp7
	Pad8; // kp8
	Pad9; // kp9
	Pad0; // kp0
	PadPeriod; // kp.
	International1; // international1
	International2; // international2
	International3; // international3
	International4; // international4
	International5; // international5
	International6; // international6
	International7; // international7
	International8; // international8
	International9; // international9
	Lang1; // lang1
	Lang2; // lang2
	Lang3; // lang3
	Lang4; // lang4
	Lang5; // lang5
	Mute; // mute
	VolumeUp; // volumeup
	VolumeDown; // volumedown
	AudioNext; // audionext
	AudioPrev; // audioprev
	AudioStop; // audiostop
	AudioPlay; // audioplay
	AudioMute; // audiomute
	MediaSelect; // mediaselect
	WWW; // www
	Mail; // mail
	Calculator; // calculator
	Computer; // computer
	ACSearch; // acsearch
	ACHome; // achome
	ACBack; // acback
	ACForward; // acforward
	ACStop; // acstop
	ACRefresh; // acrefresh
	ACBookmarks; // acbookmarks
	Power; // power
	BrightnessDown; // brightnessdown
	BrightnessUp; // brightnessup
	DisplaySwitch; // displayswitch
	KBDIllumToggle; // kbdillumtoggle
	KBDDIllumDown; // kbdillumdown
	KBDIillumUp; // kbdillumup
	Eject; // eject
	Sleep; // sleep
	AltErase; // alterase
	SysReq; // sysreq
	Cancel; // cancel
	Clear; // clear
	Prior; // prior
	Return2; // return2
	Separator; // separator
	Out; // out
	OpEr; // oper
	ClearAgain; // clearagain
	CrSel; // crsel
	ExSel; // exsel
	Pad00; // kp00
	Pad000; // kp000
	ThousandsSeparator; // thsousandsseparator
	DecimalSeparator; // decimalseparator
	CurrencyUnit; // currencyunit
	CurrencySubUnit; // currencysubunit
	App1; // app1
	App2; // app2
	Unknown; // unknown
}
ScancodeMap :: string.[ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "return", "escape", "backspace", "tab", "space", "-", "=", "[", "]", "\\", "nonus#", ";", "'", "`", ",", ".", "/", "capslock", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15", "f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23", "f24", "lctrl", "lshift", "lalt", "lgui", "rctrl", "rshift", "ralt", "rgui", "printscreen", "pause", "insert", "home", "numlock", "pageup", "delete", "end", "pagedown", "right", "left", "down", "up", "nonusbackslash", "application", "execute", "help", "menu", "select", "stop", "again", "undo", "cut", "copy", "paste", "find", "kp/", "kp*", "kp-", "kp+", "kp=", "kpenter", "kp1", "kp2", "kp3", "kp4", "kp5", "kp6", "kp7", "kp8", "kp9", "kp0", "kp.", "international1", "international2", "international3", "international4", "international5", "international6", "international7", "international8", "international9", "lang1", "lang2", "lang3", "lang4", "lang5", "mute", "volumeup", "volumedown", "audionext", "audioprev", "audiostop", "audioplay", "audiomute", "mediaselect", "www", "mail", "calculator", "computer", "acsearch", "achome", "acback", "acforward", "acstop", "acrefresh", "acbookmarks", "power", "brightnessdown", "brightnessup", "displayswitch", "kbdillumtoggle", "kbdillumdown", "kbdillumup", "eject", "sleep", "alterase", "sysreq", "cancel", "clear", "prior", "return2", "separator", "out", "oper", "clearagain", "crsel", "exsel", "kp00", "kp000", "thsousandsseparator", "decimalseparator", "currencyunit", "currencysubunit", "app1", "app2", "unknown" ];


// Gets the key corresponding to the given hardware scancode.
love_keyboard_getKeyFromScancode :: (scancode: *u8) -> (key: *u8) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "keyboard");
	lua.getfield(L, -1, "getKeyFromScancode");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushstring(L, scancode);
	lua.call(L, 1, 1);

	return lua.tolstring(L, -1, null);
}
// Gets the hardware scancode corresponding to the given key.
love_keyboard_getScancodeFromKey :: (key: *u8) -> (scancode: *u8) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "keyboard");
	lua.getfield(L, -1, "getScancodeFromKey");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushstring(L, key);
	lua.call(L, 1, 1);

	return lua.tolstring(L, -1, null);
}
// Gets whether key repeat is enabled.
love_keyboard_hasKeyRepeat :: () -> (enabled: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "keyboard");
	lua.getfield(L, -1, "hasKeyRepeat");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.toboolean(L, -1);
}
// Gets whether screen keyboard is supported.
love_keyboard_hasScreenKeyboard :: () -> (supported: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "keyboard");
	lua.getfield(L, -1, "hasScreenKeyboard");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.toboolean(L, -1);
}
// Gets whether text input events are enabled.
love_keyboard_hasTextInput :: () -> (enabled: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "keyboard");
	lua.getfield(L, -1, "hasTextInput");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.toboolean(L, -1);
}
// Checks whether a certain key is down. Not to be confused with love.keypressed or love.keyreleased.
love_keyboard_isDown :: (key: *u8) -> (down: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "keyboard");
	lua.getfield(L, -1, "isDown");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushstring(L, key);
	lua.call(L, 1, 1);

	return lua.toboolean(L, -1);
}
// Checks whether a certain key is down. Not to be confused with love.keypressed or love.keyreleased.
// Checks whether the specified Scancodes are pressed. Not to be confused with love.keypressed or love.keyreleased.
love_keyboard_isScancodeDown :: (scancode: *u8) -> (down: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "keyboard");
	lua.getfield(L, -1, "isScancodeDown");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushstring(L, scancode);
	lua.call(L, 1, 1);

	return lua.toboolean(L, -1);
}
// Enables or disables key repeat for love.keypressed. It is disabled by default.
love_keyboard_setKeyRepeat :: (enable: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "keyboard");
	lua.getfield(L, -1, "setKeyRepeat");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushboolean(L, enable);
	lua.call(L, 1, 0);
}
// Enables or disables text input events. It is enabled by default on Windows, Mac, and Linux, and disabled by default on iOS and Android.
love_keyboard_setTextInput :: (enable: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "keyboard");
	lua.getfield(L, -1, "setTextInput");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushboolean(L, enable);
	lua.call(L, 1, 0);
}
// Enables or disables text input events. It is enabled by default on Windows, Mac, and Linux, and disabled by default on iOS and Android.
love_keyboard_setTextInput :: (enable: s32, x: lua.Number, y: lua.Number, w: lua.Number, h: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "keyboard");
	lua.getfield(L, -1, "setTextInput");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushboolean(L, enable);
	lua.pushnumber(L, x);
	lua.pushnumber(L, y);
	lua.pushnumber(L, w);
	lua.pushnumber(L, h);
	lua.call(L, 5, 0);
}
