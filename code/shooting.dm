entity/ship
	key_down(k)
		if(k == "s")
			shoot()
		else ..()

	proc/shoot()
		new /obj/blast (src)

entity/dude
	key_down(k)
		if(k == "s")
			shoot()
		else ..()

	proc/shoot()
		new /obj/bullet (src)

game/tick()
	..()
	for(var/obj/blast/b) b.tick()
	for(var/obj/bullet/b) b.tick()

obj/blast
	icon_state = "shot"
	density = 1

	var	//	you can change these values
		speed = 16
		life = 5

	var tmp
		vx = 0
		vy = 0

	New(entity/ship/e)
		set_loc(e.loc, e.step_x, e.step_y)

		//	shoot in the angle of the shooter
		vx = speed * sin(e.angle)
		vy = speed * cos(e.angle)

		//	the blast moves relative to the shooter
		vx += e.vx
		vy += e.vy

		if(life) spawn(life) die()

	//	this happens every tick
	proc/tick()
		do_velocity()

	//	move according to velocity
	proc/do_velocity()
		if(vx || vy)
			move(vx, vy)

	//	this is deleted when it fails to move (if you want to do something to the obstacle, use Bump())
	bump()
		die()

	proc/die()
		del src

	//	this can can move through other blasts
	Cross(obj/blast/b)
		return ..() || istype(b)


obj/bullet
	icon_state = "shot"
	density = 1

	var	//	you can change these values
		speed = 16
		life = 5

	var tmp
		vx = 0
		vy = 0

	New(entity/dude/e)
		set_loc(e.loc, e.step_x, e.step_y)

		//	shoot in the angle of the shooter
		vx = e.dir == EAST ? speed : -speed

		if(life) spawn(life) die()

	//	this happens every tick
	proc/tick()
		do_velocity()

	//	move according to velocity
	proc/do_velocity()
		if(vx || vy)
			move(vx, vy)

	//	this is deleted when it fails to move (if you want to do something to the obstacle, use Bump())
	bump()
		die()

	proc/die()
		del src

	//	this can can move through other blasts
	Cross(obj/bullet/b)
		return ..() || istype(b)