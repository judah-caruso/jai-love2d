// This file was generated by generate_bindings.lua

Body :: #type,distinct lua.Ref;
ChainShape :: #type,distinct lua.Ref;
CircleShape :: #type,distinct lua.Ref;
Contact :: #type,distinct lua.Ref;
DistanceJoint :: #type,distinct lua.Ref;
EdgeShape :: #type,distinct lua.Ref;
Fixture :: #type,distinct lua.Ref;
FrictionJoint :: #type,distinct lua.Ref;
GearJoint :: #type,distinct lua.Ref;
Joint :: #type,distinct lua.Ref;
MotorJoint :: #type,distinct lua.Ref;
MouseJoint :: #type,distinct lua.Ref;
PolygonShape :: #type,distinct lua.Ref;
PrismaticJoint :: #type,distinct lua.Ref;
PulleyJoint :: #type,distinct lua.Ref;
RevoluteJoint :: #type,distinct lua.Ref;
RopeJoint :: #type,distinct lua.Ref;
Shape :: #type,distinct lua.Ref;
WeldJoint :: #type,distinct lua.Ref;
WheelJoint :: #type,distinct lua.Ref;
World :: #type,distinct lua.Ref;

BodyType :: enum {
	Static; // static
	Dynamic; // dynamic
	Kinematic; // kinematic
}
BodyTypeMap :: string.[ "static", "dynamic", "kinematic" ];

JointType :: enum {
	Distance; // distance
	Friction; // friction
	Gear; // gear
	Mouse; // mouse
	Prismatic; // prismatic
	Pulley; // pulley
	Revolute; // revolute
	Rope; // rope
	Weld; // weld
}
JointTypeMap :: string.[ "distance", "friction", "gear", "mouse", "prismatic", "pulley", "revolute", "rope", "weld" ];

ShapeType :: enum {
	Circle; // circle
	Polygon; // polygon
	Edge; // edge
	Chain; // chain
}
ShapeTypeMap :: string.[ "circle", "polygon", "edge", "chain" ];


// Returns the two closest points between two fixtures and their distance.
love_physics_getDistance :: (fixture1: Fixture, fixture2: Fixture) -> struct { _distance: lua.Number; _x1: lua.Number; _y1: lua.Number; _x2: lua.Number; _y2: lua.Number; } #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "getDistance");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx fixture1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx fixture2);
	lua.call(L, 2, 5);

	return .{ _distance = lua.tonumber(L, -5), _x1 = lua.tonumber(L, -4), _y1 = lua.tonumber(L, -3), _x2 = lua.tonumber(L, -2), _y2 = lua.tonumber(L, -1) };
}
// Returns the meter scale factor.
love_physics_getMeter :: () -> (scale: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "getMeter");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.call(L, 0, 1);

	return lua.tonumber(L, -1);
}
// Creates a new body.
love_physics_newBody :: (world: World, x: lua.Number, y: lua.Number, type: *u8) -> (body: Body) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newBody");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx world);
	lua.pushnumber(L, x);
	lua.pushnumber(L, y);
	lua.pushstring(L, type);
	lua.call(L, 4, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new ChainShape.
love_physics_newChainShape :: (loop: s32, x1: lua.Number, y1: lua.Number, x2: lua.Number, y2: lua.Number) -> (shape: ChainShape) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newChainShape");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushboolean(L, loop);
	lua.pushnumber(L, x1);
	lua.pushnumber(L, y1);
	lua.pushnumber(L, x2);
	lua.pushnumber(L, y2);
	lua.call(L, 5, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new ChainShape.
love_physics_newChainShape :: (loop: s32, points: lua.Table) -> (shape: ChainShape) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newChainShape");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushboolean(L, loop);
	lua.createtable(L, 0, 0);
	lua.call(L, 2, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new CircleShape.
love_physics_newCircleShape :: (radius: lua.Number) -> (shape: CircleShape) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newCircleShape");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, radius);
	lua.call(L, 1, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new CircleShape.
love_physics_newCircleShape :: (x: lua.Number, y: lua.Number, radius: lua.Number) -> (shape: CircleShape) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newCircleShape");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, x);
	lua.pushnumber(L, y);
	lua.pushnumber(L, radius);
	lua.call(L, 3, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a DistanceJoint between two bodies.
love_physics_newDistanceJoint :: (body1: Body, body2: Body, x1: lua.Number, y1: lua.Number, x2: lua.Number, y2: lua.Number, collideconnected: s32) -> (joint: DistanceJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newDistanceJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body2);
	lua.pushnumber(L, x1);
	lua.pushnumber(L, y1);
	lua.pushnumber(L, x2);
	lua.pushnumber(L, y2);
	lua.pushboolean(L, collideconnected);
	lua.call(L, 7, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new EdgeShape.
love_physics_newEdgeShape :: (x1: lua.Number, y1: lua.Number, x2: lua.Number, y2: lua.Number) -> (shape: EdgeShape) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newEdgeShape");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, x1);
	lua.pushnumber(L, y1);
	lua.pushnumber(L, x2);
	lua.pushnumber(L, y2);
	lua.call(L, 4, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates and attaches a Fixture to a body.
love_physics_newFixture :: (body: Body, shape: Shape, density: lua.Number) -> (fixture: Fixture) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newFixture");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx shape);
	lua.pushnumber(L, density);
	lua.call(L, 3, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Create a friction joint between two bodies. A FrictionJoint applies friction to a body.
love_physics_newFrictionJoint :: (body1: Body, body2: Body, x: lua.Number, y: lua.Number, collideconnected: s32) -> (joint: FrictionJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newFrictionJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body2);
	lua.pushnumber(L, x);
	lua.pushnumber(L, y);
	lua.pushboolean(L, collideconnected);
	lua.call(L, 5, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Create a friction joint between two bodies. A FrictionJoint applies friction to a body.
love_physics_newFrictionJoint :: (body1: Body, body2: Body, x1: lua.Number, y1: lua.Number, x2: lua.Number, y2: lua.Number, collideconnected: s32) -> (joint: FrictionJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newFrictionJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body2);
	lua.pushnumber(L, x1);
	lua.pushnumber(L, y1);
	lua.pushnumber(L, x2);
	lua.pushnumber(L, y2);
	lua.pushboolean(L, collideconnected);
	lua.call(L, 7, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Create a GearJoint connecting two Joints.
love_physics_newGearJoint :: (joint1: Joint, joint2: Joint, ratio: lua.Number, collideconnected: s32) -> (joint: GearJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newGearJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx joint1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx joint2);
	lua.pushnumber(L, ratio);
	lua.pushboolean(L, collideconnected);
	lua.call(L, 4, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a joint between two bodies which controls the relative motion between them.
love_physics_newMotorJoint :: (body1: Body, body2: Body, correctionfactor: lua.Number) -> (joint: MotorJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newMotorJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body2);
	lua.pushnumber(L, correctionfactor);
	lua.call(L, 3, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a joint between two bodies which controls the relative motion between them.
love_physics_newMotorJoint :: (body1: Body, body2: Body, correctionfactor: lua.Number, collideconnected: s32) -> (joint: MotorJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newMotorJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body2);
	lua.pushnumber(L, correctionfactor);
	lua.pushboolean(L, collideconnected);
	lua.call(L, 4, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Create a joint between a body and the mouse.
love_physics_newMouseJoint :: (body: Body, x: lua.Number, y: lua.Number) -> (joint: MouseJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newMouseJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body);
	lua.pushnumber(L, x);
	lua.pushnumber(L, y);
	lua.call(L, 3, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new PolygonShape.
love_physics_newPolygonShape :: (x1: lua.Number, y1: lua.Number, x2: lua.Number, y2: lua.Number, x3: lua.Number, y3: lua.Number) -> (shape: PolygonShape) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newPolygonShape");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, x1);
	lua.pushnumber(L, y1);
	lua.pushnumber(L, x2);
	lua.pushnumber(L, y2);
	lua.pushnumber(L, x3);
	lua.pushnumber(L, y3);
	lua.call(L, 6, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new PolygonShape.
love_physics_newPolygonShape :: (vertices: lua.Table) -> (shape: PolygonShape) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newPolygonShape");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.createtable(L, 0, 0);
	lua.call(L, 1, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a PrismaticJoint between two bodies.
love_physics_newPrismaticJoint :: (body1: Body, body2: Body, x: lua.Number, y: lua.Number, ax: lua.Number, ay: lua.Number, collideconnected: s32) -> (joint: PrismaticJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newPrismaticJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body2);
	lua.pushnumber(L, x);
	lua.pushnumber(L, y);
	lua.pushnumber(L, ax);
	lua.pushnumber(L, ay);
	lua.pushboolean(L, collideconnected);
	lua.call(L, 7, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a PrismaticJoint between two bodies.
love_physics_newPrismaticJoint :: (body1: Body, body2: Body, x1: lua.Number, y1: lua.Number, x2: lua.Number, y2: lua.Number, ax: lua.Number, ay: lua.Number, collideconnected: s32) -> (joint: PrismaticJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newPrismaticJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body2);
	lua.pushnumber(L, x1);
	lua.pushnumber(L, y1);
	lua.pushnumber(L, x2);
	lua.pushnumber(L, y2);
	lua.pushnumber(L, ax);
	lua.pushnumber(L, ay);
	lua.pushboolean(L, collideconnected);
	lua.call(L, 9, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a PrismaticJoint between two bodies.
love_physics_newPrismaticJoint :: (body1: Body, body2: Body, x1: lua.Number, y1: lua.Number, x2: lua.Number, y2: lua.Number, ax: lua.Number, ay: lua.Number, collideconnected: s32, referenceangle: lua.Number) -> (joint: PrismaticJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newPrismaticJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body2);
	lua.pushnumber(L, x1);
	lua.pushnumber(L, y1);
	lua.pushnumber(L, x2);
	lua.pushnumber(L, y2);
	lua.pushnumber(L, ax);
	lua.pushnumber(L, ay);
	lua.pushboolean(L, collideconnected);
	lua.pushnumber(L, referenceangle);
	lua.call(L, 10, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a PulleyJoint to join two bodies to each other and the ground.
love_physics_newPulleyJoint :: (body1: Body, body2: Body, gx1: lua.Number, gy1: lua.Number, gx2: lua.Number, gy2: lua.Number, x1: lua.Number, y1: lua.Number, x2: lua.Number, y2: lua.Number, ratio: lua.Number, collideconnected: s32) -> (joint: PulleyJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newPulleyJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body2);
	lua.pushnumber(L, gx1);
	lua.pushnumber(L, gy1);
	lua.pushnumber(L, gx2);
	lua.pushnumber(L, gy2);
	lua.pushnumber(L, x1);
	lua.pushnumber(L, y1);
	lua.pushnumber(L, x2);
	lua.pushnumber(L, y2);
	lua.pushnumber(L, ratio);
	lua.pushboolean(L, collideconnected);
	lua.call(L, 12, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Shorthand for creating rectangular PolygonShapes. 
love_physics_newRectangleShape :: (width: lua.Number, height: lua.Number) -> (shape: PolygonShape) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newRectangleShape");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, width);
	lua.pushnumber(L, height);
	lua.call(L, 2, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Shorthand for creating rectangular PolygonShapes. 
love_physics_newRectangleShape :: (x: lua.Number, y: lua.Number, width: lua.Number, height: lua.Number, angle: lua.Number) -> (shape: PolygonShape) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newRectangleShape");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, x);
	lua.pushnumber(L, y);
	lua.pushnumber(L, width);
	lua.pushnumber(L, height);
	lua.pushnumber(L, angle);
	lua.call(L, 5, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a pivot joint between two bodies.
love_physics_newRevoluteJoint :: (body1: Body, body2: Body, x: lua.Number, y: lua.Number, collideconnected: s32) -> (joint: RevoluteJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newRevoluteJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body2);
	lua.pushnumber(L, x);
	lua.pushnumber(L, y);
	lua.pushboolean(L, collideconnected);
	lua.call(L, 5, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a pivot joint between two bodies.
love_physics_newRevoluteJoint :: (body1: Body, body2: Body, x1: lua.Number, y1: lua.Number, x2: lua.Number, y2: lua.Number, collideconnected: s32, referenceangle: lua.Number) -> (joint: RevoluteJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newRevoluteJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body2);
	lua.pushnumber(L, x1);
	lua.pushnumber(L, y1);
	lua.pushnumber(L, x2);
	lua.pushnumber(L, y2);
	lua.pushboolean(L, collideconnected);
	lua.pushnumber(L, referenceangle);
	lua.call(L, 8, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a joint between two bodies. Its only function is enforcing a max distance between these bodies.
love_physics_newRopeJoint :: (body1: Body, body2: Body, x1: lua.Number, y1: lua.Number, x2: lua.Number, y2: lua.Number, maxlength: lua.Number, collideconnected: s32) -> (joint: RopeJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newRopeJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body2);
	lua.pushnumber(L, x1);
	lua.pushnumber(L, y1);
	lua.pushnumber(L, x2);
	lua.pushnumber(L, y2);
	lua.pushnumber(L, maxlength);
	lua.pushboolean(L, collideconnected);
	lua.call(L, 8, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a constraint joint between two bodies. A WeldJoint essentially glues two bodies together. The constraint is a bit soft, however, due to Box2D's iterative solver.
love_physics_newWeldJoint :: (body1: Body, body2: Body, x: lua.Number, y: lua.Number, collideconnected: s32) -> (joint: WeldJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newWeldJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body2);
	lua.pushnumber(L, x);
	lua.pushnumber(L, y);
	lua.pushboolean(L, collideconnected);
	lua.call(L, 5, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a constraint joint between two bodies. A WeldJoint essentially glues two bodies together. The constraint is a bit soft, however, due to Box2D's iterative solver.
love_physics_newWeldJoint :: (body1: Body, body2: Body, x1: lua.Number, y1: lua.Number, x2: lua.Number, y2: lua.Number, collideconnected: s32) -> (joint: WeldJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newWeldJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body2);
	lua.pushnumber(L, x1);
	lua.pushnumber(L, y1);
	lua.pushnumber(L, x2);
	lua.pushnumber(L, y2);
	lua.pushboolean(L, collideconnected);
	lua.call(L, 7, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a constraint joint between two bodies. A WeldJoint essentially glues two bodies together. The constraint is a bit soft, however, due to Box2D's iterative solver.
love_physics_newWeldJoint :: (body1: Body, body2: Body, x1: lua.Number, y1: lua.Number, x2: lua.Number, y2: lua.Number, collideconnected: s32, referenceangle: lua.Number) -> (joint: WeldJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newWeldJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body2);
	lua.pushnumber(L, x1);
	lua.pushnumber(L, y1);
	lua.pushnumber(L, x2);
	lua.pushnumber(L, y2);
	lua.pushboolean(L, collideconnected);
	lua.pushnumber(L, referenceangle);
	lua.call(L, 8, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a wheel joint.
love_physics_newWheelJoint :: (body1: Body, body2: Body, x: lua.Number, y: lua.Number, ax: lua.Number, ay: lua.Number, collideconnected: s32) -> (joint: WheelJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newWheelJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body2);
	lua.pushnumber(L, x);
	lua.pushnumber(L, y);
	lua.pushnumber(L, ax);
	lua.pushnumber(L, ay);
	lua.pushboolean(L, collideconnected);
	lua.call(L, 7, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a wheel joint.
love_physics_newWheelJoint :: (body1: Body, body2: Body, x1: lua.Number, y1: lua.Number, x2: lua.Number, y2: lua.Number, ax: lua.Number, ay: lua.Number, collideconnected: s32) -> (joint: WheelJoint) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newWheelJoint");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body1);
	lua.rawgeti(L, lua.LUA_REGISTRYINDEX, xx body2);
	lua.pushnumber(L, x1);
	lua.pushnumber(L, y1);
	lua.pushnumber(L, x2);
	lua.pushnumber(L, y2);
	lua.pushnumber(L, ax);
	lua.pushnumber(L, ay);
	lua.pushboolean(L, collideconnected);
	lua.call(L, 9, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Creates a new World.
love_physics_newWorld :: (xg: lua.Number, yg: lua.Number, sleep: s32) -> (world: World) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "newWorld");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, xg);
	lua.pushnumber(L, yg);
	lua.pushboolean(L, sleep);
	lua.call(L, 3, 1);

	return xx lua.luaL_ref(L, lua.LUA_REGISTRYINDEX);
}
// Sets the pixels to meter scale factor.
love_physics_setMeter :: (scale: lua.Number) #no_context #c_call {
	lua.getfield(L, lua.LUA_GLOBALSINDEX, "love");
	lua.getfield(L, -1, "physics");
	lua.getfield(L, -1, "setMeter");
	lua._remove(L, -3);
	lua._remove(L, -2);

	lua.pushnumber(L, scale);
	lua.call(L, 1, 0);
}
