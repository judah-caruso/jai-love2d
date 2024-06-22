// love_audio_getActiveEffects :: () -> (effects: lua.Table) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "getActiveEffects");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.call(L, 0, 1);

//    return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
// }

audio :: struct {
   get_active_source_count :: inline () -> int {
      count := love_audio_getSourceCount();
      return xx count;
   }

   get_distance_model :: inline () -> DistanceModel {
      model := to_string(love_audio_getDistanceModel());
      defer free(model);

      for str_value, enum_value: DistanceModelMap if str_value == model {
         return xx enum_value;
      }

      return .None;
   }

   get_doppler_scale :: inline () -> float32 {
      scale := love_audio_getDopplerScale();
      return xx scale;
   }

   get_max_scene_effects :: inline () -> float32 {
      max := love_audio_getMaxSceneEffects();
      return xx max;
   }

   get_max_source_effects :: inline () -> float32 {
      max := love_audio_getMaxSourceEffects();
      return xx max;
   }

   get_orientation :: inline () -> (fx: float32, fy: float32, fz: float32, ux: float32, uy: float32, uz: float32) {
      ori := love_audio_getOrientation();
      return xx ori._fx, xx ori._fy, xx ori._fz,
             xx ori._ux, xx ori._uy, xx ori._uz;
   }

   get_position :: inline () -> Vector3 {
      pos := love_audio_getPosition();
      return .{ xx pos._x, xx pos._y, xx pos._z };
   }

   get_source_count :: inline () -> int {
      count := love_audio_getSourceCount();
      return xx count;
   }

   get_velocity :: inline () -> Vector3 {
      vel := love_audio_getVelocity();
      return .{ xx vel._x, xx vel._y, xx vel._z };
   }

   get_volume :: inline () -> float32 {
      vol := love_audio_getVolume();
      return xx vol;
   }

   is_effects_supported :: inline () -> bool {
      supported := love_audio_isEffectsSupported();
      return xx supported;
   }

   set_distance_model :: inline (model: DistanceModel) {
      str := temp_c_string(DistanceModelMap[model]);
      love_audio_setDistanceModel(str);
   }
}

// // Gets a list of RecordingDevices on the system.
// love_audio_getRecordingDevices :: () -> (devices: lua.Table) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "getRecordingDevices");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.call(L, 0, 1);

//    return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
// }

// Creates a new Source usable for real-time generated sound playback with Source:queue.
// love_audio_newQueueableSource :: (samplerate: lua.Number, bitdepth: lua.Number, channels: lua.Number, buffercount: lua.Number) -> (source: Source) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "newQueueableSource");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.pushnumber(L, samplerate);
//    lua.pushnumber(L, bitdepth);
//    lua.pushnumber(L, channels);
//    lua.pushnumber(L, buffercount);
//    lua.call(L, 4, 1);

//    return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
// }
// Creates a new Source from a filepath, File, Decoder or SoundData.
// love_audio_newSource :: (filename: *u8, type: *u8) -> (source: Source) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "newSource");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.pushstring(L, filename);
//    lua.pushstring(L, type);
//    lua.call(L, 2, 1);

//    return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
// }
// Creates a new Source from a filepath, File, Decoder or SoundData.
// love_audio_newSource :: (file: File, type: *u8) -> (source: Source) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "newSource");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx file);
//    lua.pushstring(L, type);
//    lua.call(L, 2, 1);

//    return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
// }
// Creates a new Source from a filepath, File, Decoder or SoundData.
// love_audio_newSource :: (decoder: Decoder, type: *u8) -> (source: Source) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "newSource");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx decoder);
//    lua.pushstring(L, type);
//    lua.call(L, 2, 1);

//    return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
// }
// Creates a new Source from a filepath, File, Decoder or SoundData.
// love_audio_newSource :: (data: FileData, type: *u8) -> (source: Source) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "newSource");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx data);
//    lua.pushstring(L, type);
//    lua.call(L, 2, 1);

//    return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
// }
// Creates a new Source from a filepath, File, Decoder or SoundData.
// love_audio_newSource :: (data: SoundData) -> (source: Source) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "newSource");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx data);
//    lua.call(L, 1, 1);

//    return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
// }
// Pauses specific or all currently played Sources.
// love_audio_pause :: () -> (sources: lua.Table) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "pause");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.call(L, 0, 1);

//    return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
// }
// Pauses specific or all currently played Sources.
// love_audio_pause :: (source: Source) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "pause");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx source);
//    lua.call(L, 1, 0);
// }
// Pauses specific or all currently played Sources.
// love_audio_pause :: (sources: lua.Table) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "pause");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.createtable(L, 0, 0);
//    lua.call(L, 1, 0);
// }
// Plays the specified Source.
// love_audio_play :: (source: Source) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "play");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx source);
//    lua.call(L, 1, 0);
// }
// Plays the specified Source.
// love_audio_play :: (sources: lua.Table) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "play");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.createtable(L, 0, 0);
//    lua.call(L, 1, 0);
// }
// Plays the specified Source.
// love_audio_play :: (source1: Source, source2: Source) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "play");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx source1);
//    lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx source2);
//    lua.call(L, 2, 0);
// }
// Sets a global scale factor for velocity-based doppler effects. The default scale value is 1.
// love_audio_setDopplerScale :: (scale: lua.Number) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "setDopplerScale");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.pushnumber(L, scale);
//    lua.call(L, 1, 0);
// }
// Defines an effect that can be applied to a Source.
// love_audio_setEffect :: (name: *u8, settings: lua.Table) -> (success: s32) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "setEffect");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.pushstring(L, name);
//    lua.createtable(L, 0, 0);
//    lua.call(L, 2, 1);

//    return lua.toboolean(L, -1);
// }
// Defines an effect that can be applied to a Source.
// love_audio_setEffect :: (name: *u8, enabled: s32) -> (success: s32) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "setEffect");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.pushstring(L, name);
//    lua.pushboolean(L, enabled);
//    lua.call(L, 2, 1);

//    return lua.toboolean(L, -1);
// }
// Sets whether the system should mix the audio with the system's audio.
// love_audio_setMixWithSystem :: (mix: s32) -> (success: s32) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "setMixWithSystem");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.pushboolean(L, mix);
//    lua.call(L, 1, 1);

//    return lua.toboolean(L, -1);
// }
// Sets the orientation of the listener.
// love_audio_setOrientation :: (fx: lua.Number, fy: lua.Number, fz: lua.Number, ux: lua.Number, uy: lua.Number, uz: lua.Number) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "setOrientation");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.pushnumber(L, fx);
//    lua.pushnumber(L, fy);
//    lua.pushnumber(L, fz);
//    lua.pushnumber(L, ux);
//    lua.pushnumber(L, uy);
//    lua.pushnumber(L, uz);
//    lua.call(L, 6, 0);
// }
// Sets the position of the listener, which determines how sounds play.
// love_audio_setPosition :: (x: lua.Number, y: lua.Number, z: lua.Number) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "setPosition");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.pushnumber(L, x);
//    lua.pushnumber(L, y);
//    lua.pushnumber(L, z);
//    lua.call(L, 3, 0);
// }
// Sets the velocity of the listener.
// love_audio_setVelocity :: (x: lua.Number, y: lua.Number, z: lua.Number) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "setVelocity");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.pushnumber(L, x);
//    lua.pushnumber(L, y);
//    lua.pushnumber(L, z);
//    lua.call(L, 3, 0);
// }
// Sets the master volume.
// love_audio_setVolume :: (volume: lua.Number) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "setVolume");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.pushnumber(L, volume);
//    lua.call(L, 1, 0);
// }
// Stops currently played sources.
// love_audio_stop :: () #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "stop");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.call(L, 0, 0);
// }
// Stops currently played sources.
// love_audio_stop :: (source: Source) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "stop");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx source);
//    lua.call(L, 1, 0);
// }
// Stops currently played sources.
// love_audio_stop :: (source1: Source, source2: Source) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "stop");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx source1);
//    lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx source2);
//    lua.call(L, 2, 0);
// }
// Stops currently played sources.
// love_audio_stop :: (sources: lua.Table) #no_context #c_call {
//    lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
//    lua.getfield(L, -1, "audio");
//    lua.getfield(L, -1, "stop");
//    lua._remove(L, -3);
//    lua._remove(L, -2);

//    lua.createtable(L, 0, 0);
//    lua.call(L, 1, 0);
// }
