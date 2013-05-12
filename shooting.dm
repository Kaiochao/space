mob
	key_down(k)
		if(k == "space")
			shoot()
		else ..()

	proc/shoot()
		new /obj/blast (src)

game/tick()
	..()
	for(var/obj/blast/b)
		b.tick()

obj/blast
	icon_state = "shot"

	var	//	you can change this value
		speed = 16

	var tmp
		vx = 0
		vy = 0

	New(mob/m)
		set_loc(m.loc, m.step_x, m.step_y)

		//	shoot in the angle of the shooter
		vx = speed * sin(m.angle)
		vy = speed * cos(m.angle)

		//	the blast moves relative to the shooter
		vx += m.vx
		vy += m.vy

	//	this happens every tick
	proc/tick()
		do_velocity()

	//	move according to velocity
	proc/do_velocity()
		if(vx || vy)
			move(vx, vy)

	//	this is deleted when it fails to move (if you want to do something to the obstacle, use Bump())
	bump()
		del src

	//	this can can move through other blasts
	Cross(obj/blast/b) return ..() || istype(b)