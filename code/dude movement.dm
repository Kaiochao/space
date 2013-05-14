entity/dude
	icon_state = "dude"
	bounds = "9,1 to 24,24"
	density = 1
	dir = EAST

	var
		max_speed = 6
		accel = 2
		decel = 1
		gravity = 2
		jump_speed = 16

	tick()
		accelerate()
		decelerate()
		do_gravity()
		do_velocity()
		do_jumping()

	key_down(k)
		if(k == "space")
			player.set_focus(player.ship)
		else ..()

	bump(d)
		if(d & 3) vy = 0
		if(d & 12) vx = 0

	proc/accelerate()
		var dx = accel * ((vx < max_speed && has_key("d")) - (vx > -max_speed && has_key("a")))
		if(dx)
			vx += dx
			if(dx > 0)
				dir = EAST
			else dir = WEST

	proc/decelerate()
		vx = abs(vx) > decel && vx - vx / abs(vx) * decel

	proc/do_gravity()
		vy -= gravity

	proc/do_velocity()
		if(vx || vy)
			var _dir = dir
			move(vx, vy)
			dir = _dir

	proc/do_jumping()
		if(has_key("w"))
			jump()

	proc/jump()
		if(on_ground())
			vy += jump_speed

	proc/on_ground()
		for(var/atom/o in obounds(src, 0, -1, 0, 1 - bound_height))
			if(o.density) return 1