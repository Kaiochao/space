world
	fps = 30
	New()
		..()
		game.loop()

var game/game = new
game
	proc/tick()
		for(var/mob/m)
			m.tick()

	proc/loop()
		spawn for()
			tick()
			sleep world.tick_lag