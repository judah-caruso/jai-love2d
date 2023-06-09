// This file was generated by generate_bindings.lua

RecordingDevice :: #type,distinct lua.Ref;
Source :: #type,distinct lua.Ref;

DistanceModel :: enum {
	None; // none
	Inverse; // inverse
	InverseClamped; // inverseclamped
	Linear; // linear
	LinearClamped; // linearclamped
	Exponent; // exponent
	ExponentClamped; // exponentclamped
}
DistanceModelMap :: string.[ "none", "inverse", "inverseclamped", "linear", "linearclamped", "exponent", "exponentclamped" ];

EffectType :: enum {
	Chorus; // chorus
	Compressor; // compressor
	Distortion; // distortion
	Echo; // echo
	Equalizer; // equalizer
	Flanger; // flanger
	Reverb; // reverb
	RingModulator; // ringmodulator
}
EffectTypeMap :: string.[ "chorus", "compressor", "distortion", "echo", "equalizer", "flanger", "reverb", "ringmodulator" ];

EffectWaveform :: enum {
	Sawtooth; // sawtooth
	Sine; // sine
	Square; // square
	Triangle; // triangle
}
EffectWaveformMap :: string.[ "sawtooth", "sine", "square", "triangle" ];

FilterType :: enum {
	Lowpass; // lowpass
	Highpass; // highpass
	Bandpass; // bandpass
}
FilterTypeMap :: string.[ "lowpass", "highpass", "bandpass" ];

SourceType :: enum {
	Static; // static
	Stream; // stream
	Queue; // queue
}
SourceTypeMap :: string.[ "static", "stream", "queue" ];

TimeUnit :: enum {
	Seconds; // seconds
	Samples; // samples
}
TimeUnitMap :: string.[ "seconds", "samples" ];


// Gets a list of the names of the currently enabled effects.
love_audio_getActiveEffects :: () -> (effects: lua.Table) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "getActiveEffects");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Gets the current number of simultaneously playing sources.
love_audio_getActiveSourceCount :: () -> (count: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "getActiveSourceCount");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.tonumber(L, -1);
}
// Returns the distance attenuation model.
love_audio_getDistanceModel :: () -> (model: *u8) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "getDistanceModel");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.tolstring(L, -1, null);
}
// Gets the current global scale factor for velocity-based doppler effects.
love_audio_getDopplerScale :: () -> (scale: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "getDopplerScale");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.tonumber(L, -1);
}
// Gets the settings associated with an effect.
love_audio_getEffect :: (name: *u8) -> (settings: lua.Table) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "getEffect");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushstring(L, name);
	lua.call(L, 1, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Gets the maximum number of active effects supported by the system.
love_audio_getMaxSceneEffects :: () -> (maximum: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "getMaxSceneEffects");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.tonumber(L, -1);
}
// Gets the maximum number of active Effects in a single Source object, that the system can support.
love_audio_getMaxSourceEffects :: () -> (maximum: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "getMaxSourceEffects");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.tonumber(L, -1);
}
// Returns the orientation of the listener.
love_audio_getOrientation :: () -> struct { _fx: lua.Number; _fy: lua.Number; _fz: lua.Number; _ux: lua.Number; _uy: lua.Number; _uz: lua.Number; } #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "getOrientation");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 6);

	return .{ _fx = lua.tonumber(L, -6), _fy = lua.tonumber(L, -5), _fz = lua.tonumber(L, -4), _ux = lua.tonumber(L, -3), _uy = lua.tonumber(L, -2), _uz = lua.tonumber(L, -1) };
}
// Returns the position of the listener. Please note that positional audio only works for mono (i.e. non-stereo) sources.
love_audio_getPosition :: () -> struct { _x: lua.Number; _y: lua.Number; _z: lua.Number; } #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "getPosition");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 3);

	return .{ _x = lua.tonumber(L, -3), _y = lua.tonumber(L, -2), _z = lua.tonumber(L, -1) };
}
// Gets a list of RecordingDevices on the system.
love_audio_getRecordingDevices :: () -> (devices: lua.Table) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "getRecordingDevices");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Gets the current number of simultaneously playing sources.
love_audio_getSourceCount :: () -> (numsources: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "getSourceCount");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.tonumber(L, -1);
}
// Returns the velocity of the listener.
love_audio_getVelocity :: () -> struct { _x: lua.Number; _y: lua.Number; _z: lua.Number; } #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "getVelocity");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 3);

	return .{ _x = lua.tonumber(L, -3), _y = lua.tonumber(L, -2), _z = lua.tonumber(L, -1) };
}
// Returns the master volume.
love_audio_getVolume :: () -> (volume: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "getVolume");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.tonumber(L, -1);
}
// Gets whether audio effects are supported in the system.
love_audio_isEffectsSupported :: () -> (supported: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "isEffectsSupported");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.toboolean(L, -1);
}
// Creates a new Source usable for real-time generated sound playback with Source:queue.
love_audio_newQueueableSource :: (samplerate: lua.Number, bitdepth: lua.Number, channels: lua.Number, buffercount: lua.Number) -> (source: Source) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "newQueueableSource");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, samplerate);
	lua.pushnumber(L, bitdepth);
	lua.pushnumber(L, channels);
	lua.pushnumber(L, buffercount);
	lua.call(L, 4, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new Source from a filepath, File, Decoder or SoundData.
love_audio_newSource :: (filename: *u8, type: *u8) -> (source: Source) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "newSource");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushstring(L, filename);
	lua.pushstring(L, type);
	lua.call(L, 2, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new Source from a filepath, File, Decoder or SoundData.
love_audio_newSource :: (file: File, type: *u8) -> (source: Source) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "newSource");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx file);
	lua.pushstring(L, type);
	lua.call(L, 2, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new Source from a filepath, File, Decoder or SoundData.
love_audio_newSource :: (decoder: Decoder, type: *u8) -> (source: Source) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "newSource");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx decoder);
	lua.pushstring(L, type);
	lua.call(L, 2, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new Source from a filepath, File, Decoder or SoundData.
love_audio_newSource :: (data: FileData, type: *u8) -> (source: Source) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "newSource");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx data);
	lua.pushstring(L, type);
	lua.call(L, 2, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new Source from a filepath, File, Decoder or SoundData.
love_audio_newSource :: (data: SoundData) -> (source: Source) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "newSource");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx data);
	lua.call(L, 1, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Pauses specific or all currently played Sources.
love_audio_pause :: () -> (sources: lua.Table) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "pause");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Pauses specific or all currently played Sources.
love_audio_pause :: (source: Source) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "pause");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx source);
	lua.call(L, 1, 0);
}
// Pauses specific or all currently played Sources.
love_audio_pause :: (sources: lua.Table) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "pause");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.createtable(L, 0, 0);
	lua.call(L, 1, 0);
}
// Plays the specified Source.
love_audio_play :: (source: Source) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "play");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx source);
	lua.call(L, 1, 0);
}
// Plays the specified Source.
love_audio_play :: (sources: lua.Table) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "play");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.createtable(L, 0, 0);
	lua.call(L, 1, 0);
}
// Plays the specified Source.
love_audio_play :: (source1: Source, source2: Source) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "play");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx source1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx source2);
	lua.call(L, 2, 0);
}
// Sets the distance attenuation model.
love_audio_setDistanceModel :: (model: *u8) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "setDistanceModel");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushstring(L, model);
	lua.call(L, 1, 0);
}
// Sets a global scale factor for velocity-based doppler effects. The default scale value is 1.
love_audio_setDopplerScale :: (scale: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "setDopplerScale");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, scale);
	lua.call(L, 1, 0);
}
// Defines an effect that can be applied to a Source.
love_audio_setEffect :: (name: *u8, settings: lua.Table) -> (success: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "setEffect");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushstring(L, name);
	lua.createtable(L, 0, 0);
	lua.call(L, 2, 1);

	return lua.toboolean(L, -1);
}
// Defines an effect that can be applied to a Source.
love_audio_setEffect :: (name: *u8, enabled: s32) -> (success: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "setEffect");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushstring(L, name);
	lua.pushboolean(L, enabled);
	lua.call(L, 2, 1);

	return lua.toboolean(L, -1);
}
// Sets whether the system should mix the audio with the system's audio.
love_audio_setMixWithSystem :: (mix: s32) -> (success: s32) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "setMixWithSystem");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushboolean(L, mix);
	lua.call(L, 1, 1);

	return lua.toboolean(L, -1);
}
// Sets the orientation of the listener.
love_audio_setOrientation :: (fx: lua.Number, fy: lua.Number, fz: lua.Number, ux: lua.Number, uy: lua.Number, uz: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "setOrientation");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, fx);
	lua.pushnumber(L, fy);
	lua.pushnumber(L, fz);
	lua.pushnumber(L, ux);
	lua.pushnumber(L, uy);
	lua.pushnumber(L, uz);
	lua.call(L, 6, 0);
}
// Sets the position of the listener, which determines how sounds play.
love_audio_setPosition :: (x: lua.Number, y: lua.Number, z: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "setPosition");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, x);
	lua.pushnumber(L, y);
	lua.pushnumber(L, z);
	lua.call(L, 3, 0);
}
// Sets the velocity of the listener.
love_audio_setVelocity :: (x: lua.Number, y: lua.Number, z: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "setVelocity");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, x);
	lua.pushnumber(L, y);
	lua.pushnumber(L, z);
	lua.call(L, 3, 0);
}
// Sets the master volume.
love_audio_setVolume :: (volume: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "setVolume");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, volume);
	lua.call(L, 1, 0);
}
// Stops currently played sources.
love_audio_stop :: () #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "stop");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 0);
}
// Stops currently played sources.
love_audio_stop :: (source: Source) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "stop");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx source);
	lua.call(L, 1, 0);
}
// Stops currently played sources.
love_audio_stop :: (source1: Source, source2: Source) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "stop");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx source1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx source2);
	lua.call(L, 2, 0);
}
// Stops currently played sources.
love_audio_stop :: (sources: lua.Table) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "audio");
	lua.getfield(L, -1, "stop");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.createtable(L, 0, 0);
	lua.call(L, 1, 0);
}
