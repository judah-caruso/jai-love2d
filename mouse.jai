mouse :: struct {
   get_position :: () -> Vector2 {
      pos := love_mouse_getPosition();
      return .{ xx pos._x, xx pos._y };
   }

   is_down :: (button: int) -> bool {
      down := love_mouse_isDown(xx button);
      return xx down;
   }
}
