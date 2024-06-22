TOTAL_KEYS :: #run -> int {
   return (cast(*Type_Info_Enum)love.KeyConstant).values.count;
}

#add_context game: struct {
   mouse_pos:       Vector2;
   keys_this_frame: [TOTAL_KEYS]bool;
   keys_last_frame: [TOTAL_KEYS]bool;

   card_image:    love.Image;
   card_pos:      Vector4 = .{ 100, 100, 208, 304 };
   card_color:    Vector4;
   card_active:   bool;
   card_dragging: bool;
};

load :: () {
   defer print("jai stuff loaded!");

   using context.game;

   card_image = love.graphics.new_image("cardback.png");
   assert(card_image != 0, "Unable to load cardback!");
}

_xy := Vector2.{ 20, 20 };

update :: (dt: float32) -> (should_quit: bool) {
   using context.game;

   {
      memcpy(keys_last_frame.data, keys_this_frame.data, TOTAL_KEYS * size_of(bool));
      memset(keys_this_frame.data, 0, TOTAL_KEYS * size_of(bool));
      for 0..keys_this_frame.count - 1 keys_this_frame[it] = love.keyboard.is_down(xx it);

      mouse_pos = love.mouse.get_position();
   }

   if within(mouse_pos, card_pos) {
      card_active = true;
      card_color  = .{ .32, 1, .32, 1 };
   }
   else {
      card_active = false;
      card_color  = .{ 0, 0, 0, .5 };
   }

   card_dragging = love.mouse.is_down(1) && (card_dragging || card_active);
   if card_dragging {
      card_color  = .{ .32, .8, .32, 1 };
      card_pos.xy = lerp(card_pos.xy, mouse_pos - (card_pos.zw / 2), 15 * dt);
   }

   return pressed(.Escape);
}

draw :: () {
   defer reset_temporary_storage();

   using context.game;

   love.graphics.clear(.{ .12, .12, .12, 1 });

   dt := love.timer.get_delta();
   _xy.x += 4 * dt;
   _xy.y += 8 * dt;

   love.graphics.set_color(.{ .48, .88, .22, 1 });
   love.graphics.print("Love2D + Jai???", _xy.x, _xy.y);

   love.graphics.set_color(.{ 1, 1, 1, 1 });
   love.graphics.draw(
      xx card_image,
      card_pos.x, card_pos.y,
      sx = card_pos.z / 832,
      sy = card_pos.w / 1216);

   love.graphics.set_color(card_color);
   love.graphics.rectangle(.Line, card_pos);

   love.graphics.set_color(.{ 1, 0, 0, 1 });
   love.graphics.print("I'm super draggable!", card_pos.x + 10, card_pos.y + 10);

   love.graphics.set_color(.{ 1, 1, 1, 1 });
   love.graphics.print(tprint("mouse: %", mouse_pos), 10, 10);
   love.graphics.print("quit with escape!", 10, 24);
}

pressed :: (key: love.KeyConstant) -> bool {
   using context.game;
   return keys_last_frame[key] && !keys_this_frame[key];
}

held :: (key: love.KeyConstant) -> bool {
   using context.game;
   return keys_last_frame[key] && keys_this_frame[key];
}

within :: (point: Vector2, rect: Vector4) -> bool {
   return (point.x >= rect.x && point.x <= rect.x + rect.z) &&
          (point.y >= rect.y && point.y <= rect.y + rect.w);
}

#import "Basic";
#import "Math";

#poke_name love load;
#poke_name love update;
#poke_name love draw;
love :: #import,file "../../module.jai";

