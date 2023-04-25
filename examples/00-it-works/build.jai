#run {
   set_build_options_dc(.{ do_output = false });

   ws := compiler_create_workspace();

   options := get_build_options(ws);
   options.output_type            = .DYNAMIC_LIBRARY;
   options.output_executable_name = "libgame";

   set_build_options(options, ws);

   add_build_file("game.jai", ws);
}

#import "Basic";
#import "Compiler";

