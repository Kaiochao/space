//	The ship and the dude are two different objects
//	The mob can control both

//	default client movement input is not used
client
	Move()

	perspective = EYE_PERSPECTIVE

mob
	var entity/ship/ship
	var entity/dude/dude

	Login()
		..()
		src << "WDA to move."
		src << "Space to swap."
		src << "S to shoot."

		loc = null

		ship = new (locate(25, 25, 1))
		ship.player = src
		ship.name = "[key]'s ship"

		dude = new (locate(25, 25, 2))
		dude.player = src
		dude.name = "[key]'s dude"

		set_focus(dude)

	Logout()
		..()
		del ship
		del dude
		del src

	proc/set_focus(entity/e)
		client.focus = e
		client.eye = e