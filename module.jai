#module_parameters(use_wrappers := true);

#scope_file

lib_load :: (state: *lua.State) -> s32 #no_context #c_call {
   #if #exists(load) {
      push_context lua_ctx {
         load();
      }
   }

   return 0;
}

lib_update :: (L: *lua.State) -> s32 #no_context #c_call {
   #if #exists(update) {
      dt := lua.tonumber(L, -1);
      push_context lua_ctx {
         lua.pushboolean(L, xx update(xx dt));
      }
   }

   return 1;
}

lib_draw :: (L: *lua.State) -> s32 #no_context #c_call {
   #if #exists(draw) {
      push_context lua_ctx {
         draw();
      }
   }

   return 0;
}

#program_export "luaopen_libgame"
luaopen :: (state: *lua.State) -> s32 #no_context #c_call {
   L = state;
   lua.luaL_register(state, "game", game_funcs.data);
   return 1;
}

game_funcs :: lua.luaL_Reg.[
   .{ "load",   lib_load   },
   .{ "update", lib_update },
   .{ "draw",   lib_draw   },
   .{ null, null },
];

#scope_module;

#import "Math";
#import "Basic";
lua :: #import,file "lua51/module.jai";

L: *lua.State;
lua_ctx: Context;

#load "love_audio.jai";
#load "love_data.jai";
#load "love_event.jai";
#load "love_filesystem.jai";
#load "love_font.jai";
#load "love_graphics.jai";
#load "love_image.jai";
#load "love_joystick.jai";
#load "love_keyboard.jai";
#load "love_love.jai";
#load "love_math.jai";
#load "love_mouse.jai";
#load "love_physics.jai";
#load "love_sound.jai";
#load "love_system.jai";
#load "love_thread.jai";
#load "love_timer.jai";
#load "love_touch.jai";
#load "love_video.jai";
#load "love_window.jai";

#if use_wrappers {
   #load "audio.jai";
   #load "graphics.jai";
   #load "timer.jai";
   #load "mouse.jai";
   #load "keyboard.jai";
}
