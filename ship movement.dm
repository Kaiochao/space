//	default client movement input is not used
client/Move()

mob
	var	//	you can change these values
		turn_rate	= 5		//	how fast the ship turns
		max_speed	= 10	//	maximum speed in any direction
		accel		= 0.5	//	how fast the ship speeds up
		restitution	= 0.5	//	when the ship hits something, it bounces and this is multiplied to the bounced velocity component

	var	tmp	//	no use changing these values
		angle = 0			//	the current angle of the ship
		vx = 0				//	the current horizontal velocity component
		vy = 0				//	the current vertical velocity component

		//	these are generated at runtime
		icon/normal_icon	//	the rotated icon of the normal state
		icon/thrust_icon	//	the rotated icon of the thrust state

	//	this stuff happens every tick
	proc/tick()
		accelerate()
		decelerate()
		do_velocity()

	Login()
		..()
		set_loc(loc)
		client.focus = src
		normal_icon = rotate_icon(icon, icon_state)
		thrust_icon = rotate_icon(icon, icon_state + "-thrust")

	//	(boolean) is the player's k key currently down?
	proc/has_key(k)
		return client && istype(client.keys) && client.keys[k]

	//	bounce slightly when bumping something
	bump(d)
		..()
		bounce(d)

	//	reflect velocity component and scale by restitution
	proc/bounce(d)
		switch(d)
			if(NORTH)	vy = -abs(vy) * restitution
			if(SOUTH)	vy =  abs(vy) * restitution
			if(EAST)	vx = -abs(vx) * restitution
			if(WEST)	vx =  abs(vx) * restitution

	//	thrust and rotate
	proc/accelerate()
		var thrust = accel * has_key("w")
		if(thrust)
			icon = thrust_icon
			vx += thrust * sin(angle)
			vy += thrust * cos(angle)
			if(vx || vy)
				var speed = sqrt(vx * vx + vy * vy)
				var new_speed = min(speed, max_speed)
				if(speed != new_speed)
					var scale = new_speed / speed
					vx *= scale
					vy *= scale
		else icon = normal_icon

		var rotate = turn_rate * (has_key("d") - has_key("a"))
		if(rotate)
			angle = clamp_angle(angle + rotate)
			icon_state = angle2state(angle)

	//	enforce the speed limit
	proc/decelerate()
		var speed = sqrt(vx * vx + vy * vy)
		if(speed > max_speed)
			var scale = max_speed / speed
			vx *= scale
			vy *= scale

	//	split movement into a bunch of small steps
	proc/do_velocity()
		if(vx || vy)
			var steps = sqrt(vx * vx + vy * vy)
			for(var/n in 1 to steps)
				move(vx / steps, vy / steps)
				if(!vx && !vy) return