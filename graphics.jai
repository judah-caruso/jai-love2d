graphics :: struct {
   clear :: inline (color: Vector4, clear_stencil := true, clear_depth := true) {
      love_graphics_clear(color.x, color.y, color.z, color.w, xx clear_stencil, xx clear_depth);
   }

   set_color :: inline (color: Vector4) {
      love_graphics_setColor(color.x, color.y, color.z, color.w);
   }

   print :: inline (str: string, x := 0.0, y := 0.0, r := 0.0, sx := 1.0, sy := 1.0, ox := 0.0, oy := 0.0, kx := 0.0, ky := 0.0) {
      cstr := temp_c_string(str);
      love_graphics_print(cstr, x, y, r, sx, sy, ox, oy, kx, ky);
   }

   new_image :: inline (path: string) -> Image {
      cstr := temp_c_string(path);
      return love_graphics_newImage(cstr, 0);
   }

   draw :: inline (drawable: Drawable, x := 0.0, y := 0.0, r := 0.0, sx := 1.0, sy := 1.0, ox := 0.0, oy := 0.0, kx := 0.0, ky := 0.0) {
      love_graphics_draw(drawable, x, y, r, sx, sy, ox, oy, kx, ky);
   }

   rectangle :: inline (mode: DrawMode, pos: Vector4) {
      mode_str := temp_c_string(DrawModeMap[mode]);
      love_graphics_rectangle(mode_str, pos.x, pos.y, pos.z, pos.w);
   }
}
