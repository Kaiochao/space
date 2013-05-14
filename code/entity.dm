entity
	parent_type = /obj

	var tmp
		vx = 0				//	the current horizontal velocity component
		vy = 0				//	the current vertical velocity component

		mob/player

	//	(boolean) is the player's k key currently down?
	proc/has_key(k)
		return player && player.client && player.client.focus == src && istype(player.client.keys) && player.client.keys[k]

	//	this stuff happens every tick
	proc/tick()