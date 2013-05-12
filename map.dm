atom
	icon = 'icons.dmi'

world
	turf = /turf/space
	maxx = 100
	maxy = 100

turf
	space
		icon_state = "space"
		New()
			if(prob(10))
				new /obj/star (src)

obj
	star
		icon_state = "star"
		New()
			pixel_x = rand(31)
			pixel_y = rand(31)

mob
	icon_state = "mob"
	bounds = "9,1 to 24,24"