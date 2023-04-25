keyboard :: struct {
   is_down :: inline (key: KeyConstant) -> bool {
      key_name := temp_c_string(KeyConstantMap[key]);
      return xx love_keyboard_isDown(key_name);
   }
}
