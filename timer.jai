timer :: struct {
   get_delta :: inline () -> float32 {
      return xx love_timer_getDelta();
   }

   get_fps :: inline () -> float32 {
      return xx love_timer_getFPS();
   }
}
