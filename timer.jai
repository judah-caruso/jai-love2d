timer :: struct {
   get_delta :: inline () -> float32 {
      dt := love_timer_getDelta();
      return xx dt;
   }
}
