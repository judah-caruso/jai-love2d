
GRAVITY :: 9.81;

STARTING_BUNNIES   := 1000;
BUNNIES_PER_SECOND := 100;

BUNNIES:     [..]Bunny;
BUNNY_IMAGE: love.Image;

BUNNY_W :: 26;
BUNNY_H :: 37;

SCREEN_W: int;
SCREEN_H: int;

COLORS :: Vector4.[
   .{ 1, 0.5, 0.3, 1 }, // red
   .{ 0.3, 1, 0.5, 1 }, // green
   .{ 0.3, 0.5, 1, 1 }, // blue
];

Bunny :: struct {
   pos:   Vector2;
   vel:   Vector2;
   color: Vector4;
   alpha: float32;
}

load :: () {
   random_seed(cast(u64)seconds_since_init());

   SCREEN_W, SCREEN_H = love.graphics.get_dimensions();

   BUNNY_IMAGE = love.graphics.new_image("bunny.png");
   assert(BUNNY_IMAGE != 0, "failed to load bunny.png");

   for 0..STARTING_BUNNIES - 1 {
      array_add(*BUNNIES, .{
         pos = .{
            x = xx(random_get_zero_to_one_open_new() * SCREEN_W),
            y = xx(random_get_zero_to_one_open_new() * SCREEN_H),
         },
         vel = .{
            x = xx(random_get_zero_to_one_open_new() * 800),
            y = xx(random_get_zero_to_one_open_new() * 800),
         },
         color = COLORS[xx(random_get_zero_to_one_open_new() * COLORS.count)],
      });
   }
}

TIMER := 1.0;

update :: (dt: float32) -> (should_quit: bool) {
   defer reset_temporary_storage();

   TIMER -= 1 * dt;
   if TIMER <= 0 || love.mouse.is_down(1) {
      mouse_pos := love.mouse.get_position();

      bunnies_to_spawn := NewArray(BUNNIES_PER_SECOND, Bunny,, allocator = temporary_allocator);
      for *bunnies_to_spawn {
         it.* = .{
            pos = .{
               x = xx(random_get_zero_to_one_open_new() * SCREEN_W),
               y = xx(random_get_zero_to_one_open_new() * SCREEN_H),
            },
            vel = .{
               x = xx(random_get_zero_to_one_open_new() * 800),
               y = xx(random_get_zero_to_one_open_new() * 800),
            },
            color = COLORS[xx(random_get_zero_to_one_open_new() * COLORS.count)],
         };

         if TIMER > 0 {
            it.pos = mouse_pos;
         }
      }

      array_add(*BUNNIES, ..bunnies_to_spawn);

      TIMER = 1;
   }

   for *BUNNIES {
      if it.alpha < 1 it.alpha += dt;

      it.vel.y += GRAVITY;

      if it.pos.y >= xx(SCREEN_H - BUNNY_H) {
         it.vel.y *= 0.85 / 2;
         if random_get_zero_to_one_open_new() > 0.5 {
            it.vel.y -= xx(random_get_zero_to_one_open_new() * 800);
         }
      }
      else if it.pos.y < 0 {
         it.vel.y = -(it.vel.y * 2);
      }

      if it.pos.x >= xx(SCREEN_W - BUNNY_W/2) {
         it.vel.x = -abs(it.vel.x);
      }
      else if it.pos.x < 0 {
         it.vel.x = abs(it.vel.x);
      }

      it.pos += it.vel * dt;
   }

   return false;
}

draw :: () {
   for BUNNIES {
      love.graphics.set_color(.{ it.color.x, it.color.y, it.color.z, it.color.w * it.alpha });
      love.graphics.draw(xx BUNNY_IMAGE, it.pos.x, it.pos.y);
   }

   love.graphics.set_color(.{ 0, 0, 0, 0.8 });
   love.graphics.rectangle(.Fill, .{ 0, 0, 150, 60 });

   love.graphics.set_color(.{ 1, 1, 1, 1 });
   love.graphics.print(tprint("Bunnies: %", BUNNIES.count), 10, 10);
   love.graphics.print(tprint("FPS: %", love.timer.get_fps()), 10, 24);
}


#import "Basic";
#import "Math";
#import "Random";


#poke_name love load;
#poke_name love update;
#poke_name love draw;

love :: #import,file "../../module.jai";

