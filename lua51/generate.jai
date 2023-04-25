#run {
   set_build_options_dc(.{ do_output = false });

   opts: Generate_Bindings_Options;

   array_add(*opts.strip_prefixes, "lua_");
   array_add(*opts.system_include_paths, GENERATOR_DEFAULT_SYSTEM_INCLUDE_PATH);

   #if OS == .MACOS {
      array_add(*opts.system_include_paths, "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include");
      array_add(*opts.libpaths, "lib/mac");
      array_add(*opts.libnames, "liblua.dylib");
   }
   else #if OS == .WINDOWS {
      array_add(*opts.libpaths, "lib/windows");
      array_add(*opts.libnames, "liblua.dll");
   }

   array_add(*opts.include_paths, "lib/inc");
   array_add(*opts.source_files, "lua.h", "lualib.h", "lauxlib.h", "luajit.h");
   if !generate_bindings(opts, "bindings.jai") {
      compiler_set_workspace_status(.FAILED);
      return;
   }
}

#import "Basic";
#import "Compiler";
#import "Bindings_Generator";
